---
name: domain
description: This skill should be used when the user wants to add a domain, generate a railway domain, check current domains, get the URL for a service, or remove a domain.
allowed-tools: Bash(railway:*)
---

# Domain Management

Add, view, or remove domains for Railway services.

## When to Use

- User asks to "add a domain", "generate a domain", "get a URL"
- User wants to add a custom domain
- User asks "what's the URL for my service"
- User wants to remove a domain

## Add Railway Domain

Generate a railway-provided domain (max 1 per service):

```bash
railway domain --json
```

For a specific service:
```bash
railway domain --json --service backend
```

### Response
Returns the generated domain URL. Service must have a deployment.

## Add Custom Domain

```bash
railway domain example.com --json
```

### Response
Returns required DNS records:
```json
{
  "domain": "example.com",
  "dnsRecords": [
    { "type": "CNAME", "host": "@", "value": "..." }
  ]
}
```

Tell user to add these records to their DNS provider.

## Read Current Domains

Use `environment` skill to see configured domains, or query directly:

```graphql
query domains($envId: String!) {
  environment(id: $envId) {
    config(decryptVariables: false)
  }
}
```

Domains are in `config.services.<serviceId>.networking`:
- `serviceDomains` - Railway-provided domains
- `customDomains` - User-provided domains

## Remove Domain

Use `environment` skill to remove domains:

### Remove custom domain
```json
{
  "services": {
    "<serviceId>": {
      "networking": {
        "customDomains": { "<domainId>": null }
      }
    }
  }
}
```

### Remove railway domain
```json
{
  "services": {
    "<serviceId>": {
      "networking": {
        "serviceDomains": { "<domainId>": null }
      }
    }
  }
}
```

Then use `environment` skill to apply and commit the change.

## CLI Options

| Flag | Description |
|------|-------------|
| `[DOMAIN]` | Custom domain to add (omit for railway domain) |
| `-p, --port <PORT>` | Port to connect |
| `-s, --service <NAME>` | Target service (defaults to linked) |
| `--json` | JSON output |

## Composability

- **Read domains**: Use `environment` skill
- **Remove domains**: Use `environment` skill
- **Apply removal**: Use `environment` skill
- **Check service**: Use `service` skill

## Error Handling

### No Service Linked
```
No service linked. Use --service flag or run `railway service` to select one.
```

### Domain Already Exists
```
Service already has a railway-provided domain. Maximum 1 per service.
```

### No Deployment
```
Service has no deployment. Deploy first with `railway up`.
```

### Invalid Domain
```
Invalid domain format. Use a valid domain like "example.com" or "api.example.com".
```
