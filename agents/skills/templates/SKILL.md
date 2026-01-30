---
name: templates
description: This skill should be used when the user wants to add a service from a template, find templates for a specific use case, or deploy tools like Ghost, Strapi, n8n, Minio, Uptime Kuma, etc. For databases (Postgres, Redis, MySQL, MongoDB), prefer the database skill.
allowed-tools: Bash(railway:*)
---

# Templates

Search and deploy services from Railway's template marketplace.

## When to Use

- User asks to "add Postgres", "add Redis", "add a database"
- User asks to "add Ghost", "add Strapi", "add n8n", or any other service
- User wants to find templates for a use case (e.g., "CMS", "storage", "monitoring")
- User asks "what templates are available?"
- User wants to deploy a pre-configured service

## Common Template Codes

| Category | Template | Code |
|----------|----------|------|
| **Databases** | PostgreSQL | `postgres` |
| | Redis | `redis` |
| | MySQL | `mysql` |
| | MongoDB | `mongodb` |
| **CMS** | Ghost | `ghost` |
| | Strapi | `strapi` |
| **Storage** | Minio | `minio` |
| **Automation** | n8n | `n8n` |
| **Monitoring** | Uptime Kuma | `uptime-kuma` |

For other templates, use the search query below.

## Prerequisites

Get project context:
```bash
railway status --json
```

Extract:
- `id` - project ID
- `environments.edges[0].node.id` - environment ID

Get workspace ID:
```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query getWorkspace($projectId: String!) {
    project(id: $projectId) { workspaceId }
  }' \
  '{"projectId": "PROJECT_ID"}'
SCRIPT
```

## Search Templates

List available templates with optional filters:

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query templates($first: Int, $verified: Boolean) {
    templates(first: $first, verified: $verified) {
      edges {
        node {
          name
          code
          description
          category
        }
      }
    }
  }' \
  '{"first": 20, "verified": true}'
SCRIPT
```

### Arguments

| Argument | Type | Description |
|----------|------|-------------|
| `first` | Int | Number of results (max ~100) |
| `verified` | Boolean | Only verified templates |
| `recommended` | Boolean | Only recommended templates |

### Rate Limit

10 requests per minute. Don't spam searches.

## Get Template Details

Fetch a specific template by code:

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query template($code: String!) {
    template(code: $code) {
      id
      name
      description
      serializedConfig
    }
  }' \
  '{"code": "postgres"}'
SCRIPT
```

Returns:
- `id` - template ID (needed for deployment)
- `serializedConfig` - service configuration (needed for deployment)

## Deploy Template

### Step 1: Fetch Template

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query template($code: String!) {
    template(code: $code) {
      id
      serializedConfig
    }
  }' \
  '{"code": "postgres"}'
SCRIPT
```

### Step 2: Deploy to Project

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'mutation deployTemplate($input: TemplateDeployV2Input!) {
    templateDeployV2(input: $input) {
      projectId
      workflowId
    }
  }' \
  '{
    "input": {
      "templateId": "TEMPLATE_ID_FROM_STEP_1",
      "serializedConfig": SERIALIZED_CONFIG_FROM_STEP_1,
      "projectId": "PROJECT_ID",
      "environmentId": "ENVIRONMENT_ID",
      "workspaceId": "WORKSPACE_ID"
    }
  }'
SCRIPT
```

**Important:** `serializedConfig` is the exact JSON object from the template query, not a string.

## Connecting Services

After deploying a template, connect other services using reference variables.

For complete variable syntax and wiring patterns, see [variables.md](../reference/variables.md).

### Pattern

```
${{ServiceName.VARIABLE_NAME}}
```

### Common Database Variables

| Service | Connection Variable |
|---------|---------------------|
| PostgreSQL (Postgres) | `${{Postgres.DATABASE_URL}}` |
| Redis | `${{Redis.REDIS_URL}}` |
| MySQL | `${{MySQL.MYSQL_URL}}` |
| MongoDB | `${{MongoDB.MONGO_URL}}` |

### Backend vs Frontend

**Backend services** can use private URLs (internal network):
```
${{Postgres.DATABASE_URL}}
```

**Frontend applications** run in the browser and cannot access Railway's private network. Options:
1. Use public URL variables (e.g., `${{MongoDB.MONGO_PUBLIC_URL}}`)
2. Better: Route through a backend API

## Example: Add PostgreSQL

```bash
bash <<'SCRIPT'
# 1. Get context
railway status --json
# → project.id = "proj-123", environment.id = "env-456"

# 2. Get workspace ID
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query { project(id: "proj-123") { workspaceId } }' '{}'
# → workspaceId = "ws-789"

# 3. Fetch Postgres template
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query { template(code: "postgres") { id serializedConfig } }' '{}'
# → id = "template-abc", serializedConfig = {...}

# 4. Deploy
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'mutation deploy($input: TemplateDeployV2Input!) {
    templateDeployV2(input: $input) { projectId workflowId }
  }' \
  '{"input": {
    "templateId": "template-abc",
    "serializedConfig": {...},
    "projectId": "proj-123",
    "environmentId": "env-456",
    "workspaceId": "ws-789"
  }}'
SCRIPT
```

## Example: Search for CMS Templates

```bash
bash <<'SCRIPT'
# Search verified templates
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'query {
    templates(first: 50, verified: true) {
      edges {
        node { name code description category }
      }
    }
  }' '{}'
# Filter results for "CMS" category or search descriptions
SCRIPT
```

## What Gets Created

Templates typically create:
- Service with pre-configured image/source
- Environment variables (connection strings, secrets)
- Volume for persistent data (databases)
- TCP proxy for external access (where needed)

## Response

Successful deployment returns:
```json
{
  "data": {
    "templateDeployV2": {
      "projectId": "proj-123",
      "workflowId": "deployTemplate/project/proj-123/xxx"
    }
  }
}
```

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| Template not found | Invalid code | Search templates or check spelling |
| Rate limit exceeded | Too many searches | Wait 1 minute, then retry |
| Permission denied | User lacks access | Need DEVELOPER role or higher |
| Project not found | Invalid project ID | Run `railway status --json` |

## Composability

- **Connect services**: Use `environment` skill to add variable references
- **View deployed service**: Use `service` skill
- **Check logs**: Use `deployment` skill
- **Add domains**: Use `domain` skill
