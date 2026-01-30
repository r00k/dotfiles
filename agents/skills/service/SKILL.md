---
name: service
description: This skill should be used when the user asks about service status, wants to rename a service, change service icons, link services, or create services with Docker images. For creating services with local code, prefer the `new` skill. For GitHub repo sources, use `new` skill to create empty service then `environment` skill to configure source.
allowed-tools: Bash(railway:*)
---

# Service Management

Check status, update properties, and advanced service creation.

## When to Use

- User asks about service status, health, or deployments
- User asks "is my service deployed?"
- User wants to rename a service or change service icon
- User wants to link a different service
- User wants to deploy a Docker image as a new service (advanced)

**Note:** For creating services with local code (the common case), prefer the `new` skill which handles project setup, scaffolding, and service creation together.

**For GitHub repo sources:** Use `new` skill to create empty service, then `environment` skill to configure source.repo via staged changes API.

## Create Service

Create a new service via GraphQL API. There is no CLI command for this.

### Get Context

```bash
railway status --json
```

Extract:
- `project.id` - for creating the service
- `environment.id` - for staging the instance config

### Create Service Mutation

```graphql
mutation serviceCreate($input: ServiceCreateInput!) {
  serviceCreate(input: $input) {
    id
    name
  }
}
```

### ServiceCreateInput Fields

| Field | Type | Description |
|-------|------|-------------|
| `projectId` | String! | Project ID (required) |
| `name` | String | Service name (auto-generated if omitted) |
| `source.image` | String | Docker image (e.g., `nginx:latest`) |
| `source.repo` | String | GitHub repo (e.g., `user/repo`) |
| `branch` | String | Git branch for repo source |
| `environmentId` | String | If set and is a fork, only creates in that env |

### Example: Create empty service

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'mutation createService($input: ServiceCreateInput!) {
    serviceCreate(input: $input) { id name }
  }' \
  '{"input": {"projectId": "PROJECT_ID"}}'
SCRIPT
```

### Example: Create service with image

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'mutation createService($input: ServiceCreateInput!) {
    serviceCreate(input: $input) { id name }
  }' \
  '{"input": {"projectId": "PROJECT_ID", "name": "my-service", "source": {"image": "nginx:latest"}}}'
SCRIPT
```

### Connecting a GitHub Repo

**Do NOT use serviceCreate with source.repo** - use staged changes API instead.

Flow:
1. Create empty service: `serviceCreate(input: {projectId: "...", name: "my-service"})`
2. Use `environment` skill to configure source via staged changes API
3. Apply to trigger deployment

### After Creating: Configure Instance

Use `environment` skill to configure the service instance:

```json
{
  "services": {
    "<serviceId>": {
      "isCreated": true,
      "source": { "image": "nginx:latest" },
      "variables": {
        "PORT": { "value": "8080" }
      }
    }
  }
}
```

**Critical:** Always include `isCreated: true` for new service instances.

Then use `environment` skill to apply and deploy.

For variable references, see [reference/variables.md](../reference/variables.md).

## Check Service Status

```bash
railway service status --json
```

Returns current deployment status for the linked service.

### Deployment History

```bash
railway deployment list --json --limit 5
```

### Present Status

Show:
- **Service**: name and current status
- **Latest Deployment**: status (SUCCESS, FAILED, DEPLOYING, CRASHED, etc.)
- **Deployed At**: when the current deployment went live
- **Recent Deployments**: last 3-5 with status and timestamps

### Deployment Statuses

| Status | Meaning |
|--------|---------|
| SUCCESS | Deployed and running |
| FAILED | Build or deploy failed |
| DEPLOYING | Currently deploying |
| BUILDING | Build in progress |
| CRASHED | Runtime crash |
| REMOVED | Deployment removed |

## Update Service

Update service name or icon via GraphQL API.

### Get Service ID

```bash
railway status --json
```

Extract `service.id` from the response.

### Update Name

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'mutation updateService($id: String!, $input: ServiceUpdateInput!) {
    serviceUpdate(id: $id, input: $input) { id name }
  }' \
  '{"id": "SERVICE_ID", "input": {"name": "new-name"}}'
SCRIPT
```

### Update Icon

Icons can be image URLs or animated GIFs.

| Type | Example |
|------|---------|
| Image URL | `"icon": "https://example.com/logo.png"` |
| Animated GIF | `"icon": "https://example.com/animated.gif"` |
| Devicons | `"icon": "https://devicons.railway.app/github"` |

**Railway Devicons:** Query `https://devicons.railway.app/{query}` for common developer icons (e.g., `github`, `postgres`, `redis`, `nodejs`). Browse all at https://devicons.railway.app

```bash
bash <<'SCRIPT'
${CLAUDE_PLUGIN_ROOT}/skills/lib/railway-api.sh \
  'mutation updateService($id: String!, $input: ServiceUpdateInput!) {
    serviceUpdate(id: $id, input: $input) { id icon }
  }' \
  '{"id": "SERVICE_ID", "input": {"icon": "https://devicons.railway.app/github"}}'
SCRIPT
```

### ServiceUpdateInput Fields

| Field | Type | Description |
|-------|------|-------------|
| `name` | String | Service name |
| `icon` | String | Emoji or image URL (including animated GIFs) |

## Link Service

Switch the linked service for the current directory:

```bash
railway service link
```

Or specify directly:

```bash
railway service link <service-name>
```

## Composability

- **Create service with local code**: Use `new` skill (handles scaffolding + creation)
- **Configure service**: Use `environment` skill (variables, commands, image, etc.)
- **Delete service**: Use `environment` skill with `isDeleted: true`
- **Apply changes**: Use `environment` skill
- **View logs**: Use `deployment` skill
- **Deploy local code**: Use `deploy` skill

## Error Handling

### No Service Linked
```
No service linked. Run `railway service link` to link a service.
```

### No Deployments
```
Service exists but has no deployments yet. Deploy with `railway up`.
```

### Service Not Found
```
Service "foo" not found. Check available services with `railway status`.
```

### Project Not Found
User may not be in a linked project. Check `railway status`.

### Permission Denied
User needs at least DEVELOPER role to create services.

### Invalid Image
Docker image must be accessible (public or with registry credentials).
