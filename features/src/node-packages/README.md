# node-packages

Installs npm packages globally.

## Usage

```json
{
    "features": {
        "ghcr.io/devcontainers/features/node:1": {},
        "ghcr.io/shokkunrf/devcontainer-features/node-packages:1": {
            "packages": "@devcontainers/cli,prettier@3.8.1,@anthropic-ai/claude-code"
        }
    }
}
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `packages` | string | `""` | Comma-separated list of npm packages to install globally |

## Examples

```json
"packages": "@devcontainers/cli,prettier@3.8.1,@anthropic-ai/claude-code"
```

## Requirements

Node.js and npm must be available. Add the Node.js feature before this feature:

```json
{
    "features": {
        "ghcr.io/devcontainers/features/node:1": {},
        "ghcr.io/shokkunrf/devcontainer-features/node-packages:1": {
            "packages": "..."
        }
    }
}
```

Or use a base image that includes Node.js (e.g., `mcr.microsoft.com/devcontainers/javascript-node`).
