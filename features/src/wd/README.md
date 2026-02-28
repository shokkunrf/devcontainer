# wd

Installs [wd](https://github.com/shokkunrf/wd) via the official installer, a CLI tool for managing git worktrees with devcontainer support.

## Usage

```json
{
  "features": {
    "ghcr.io/shokkunrf/devcontainer-features/wd": {}
  }
}
```

## Options

| Option    | Type   | Default    | Description                                                                          |
| --------- | ------ | ---------- | ------------------------------------------------------------------------------------ |
| `version` | string | `"latest"` | Version of wd to install (e.g., `v1.1.1`). Use `latest` for the most recent release. |

## Requirements

- `curl` or `wget`
- `git`

## Examples

Install a specific version:

```json
{
  "features": {
    "ghcr.io/devcontainers/features/git": {},
    "ghcr.io/shokkunrf/devcontainer-features/wd": {
      "version": "v1.1.1"
    }
  }
}
```
