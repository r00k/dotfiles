---
name: railway-debugging
description: Debugs Railway deployment issues, checks logs, manages environment variables, and troubleshoots services. Use when Railway deploys fail, services crash, or need to inspect production state.
---

# Railway Debugging

Diagnose and fix Railway deployment and runtime issues.

## Quick Diagnostics

Run the diagnostic script for a full health check:
```bash
~/.config/agents/skills/railway-debugging/scripts/diagnose.sh
```

Or run individual commands:
```bash
# Check current project/service context
railway status

# View recent deploy logs (last 50 lines, last hour)
railway logs --lines 50 --since 1h

# View logs for a specific service
railway logs --lines 50 --since 1h --service council-bot-worker

# Filter for errors only
railway logs --lines 50 --filter "@level:error"

# View build logs
railway logs --build --lines 50

# List recent deployments with status
railway deployment list

# Check environment variables
railway variable list
railway variable list --json  # for parsing
```

## Services

This project has three Railway services:

| Service | Purpose | Config File |
|---------|---------|-------------|
| `council-bot` | Web server (Flask/Gunicorn) | `railway.json` |
| `council-bot-worker` | Cron job (hourly discovery/processing) | `railway-worker.json` |
| `Postgres` | Database | — |

Target a specific service with `--service`:
```bash
railway logs --service council-bot-worker --lines 100
railway variable list --service council-bot
```

## Common Issues & Solutions

### 1. Deploy Fails During Build

```bash
railway logs --build --lines 100
```

**Common causes:**
- Missing system packages → Set `RAILPACK_DEPLOY_APT_PACKAGES=package1,package2` env var
- Python dependency issue → Ensure `uv.lock` is committed
- Out of memory → Check build logs for OOM

### 2. Service Crashes on Startup

```bash
railway logs --lines 100 --latest  # --latest shows logs even from failed deploys
```

**Common causes:**
- Missing environment variable → `railway variable list` to verify
- Database connection failed → Check `DATABASE_URL` is set, Postgres is running
- Port binding → App must use `PORT` env var (Railway sets this)

### 3. Slow Deploys

Check if using Railway Metal:
- Dashboard → Service Settings → Deploy → Regions
- Look for `Metal (New)` tag

**Other fixes:**
- Remove unnecessary packages from `RAILPACK_DEPLOY_APT_PACKAGES` on services that don't need them
- Consider pre-built Docker images for faster deploys

### 4. Environment Variable Issues

```bash
# List all variables
railway variable list

# Check specific variable exists
railway variable list --json | python3 -c "import sys,json; v=json.load(sys.stdin); print(v.get('VAR_NAME', 'NOT SET'))"

# Set a variable
railway variable set KEY=value

# After changing env vars, redeploy:
railway redeploy --service council-bot -y
```

### 5. Database Queries

```bash
# Simple queries (use bin/prod-sql helper)
bin/prod-sql "SELECT id, date, status FROM meetings"

# Complex queries with single quotes
railway service Postgres > /dev/null 2>&1
DB_URL=$(railway variable list --json 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin)['DATABASE_PUBLIC_URL'])")
psql "$DB_URL" -c "SELECT * FROM meetings WHERE status = 'failed'"
railway service council-bot > /dev/null 2>&1
```

### 6. Worker Not Running / Cron Issues

The worker runs hourly via Railway cron. Check:
```bash
# Recent worker logs
railway logs --service council-bot-worker --lines 100 --since 2h

# Verify worker config is set in Railway dashboard:
# Settings → Railway Config File → /railway-worker.json
```

## Debugging Workflow

1. **Identify failing service:** `railway status` + `railway deployment list`
2. **Check logs:** `railway logs --lines 100 --since 1h` (add `--latest` for failed deploys)
3. **Filter errors:** `railway logs --lines 50 --filter "@level:error"`
4. **Check build:** `railway logs --build --lines 100`
5. **Verify env vars:** `railway variable list`
6. **Check database:** `bin/prod-sql "SELECT id, status FROM meetings ORDER BY id DESC LIMIT 5"`
7. **Fix and redeploy:** `railway redeploy --service <name> -y`

## Log Query Syntax

Railway supports powerful log filtering:
```bash
--filter "@level:error"              # By level
--filter "@level:warn AND timeout"   # Level + text
--filter "database connection"       # Text search
--filter "@level:error OR @level:warn"  # Multiple levels
```

## Key Environment Variables

| Variable | Purpose |
|----------|---------|
| `DATABASE_URL` | PostgreSQL connection (auto-set) |
| `DATABASE_PUBLIC_URL` | Public PostgreSQL URL (for local access) |
| `RAILPACK_DEPLOY_APT_PACKAGES` | System packages (e.g., `ffmpeg`) |
| `PORT` | Port to bind (auto-set by Railway) |
| `RAILWAY_ENVIRONMENT` | Current environment name |

## Important Notes

- `railway run <cmd>` runs **locally** with Railway env vars—does NOT execute on Railway
- `railway ssh` only works when the service is running
- Always redeploy after changing environment variables
- Use `--latest` flag to see logs from failed/building deployments
