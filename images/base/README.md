# Base Image

Base devcontainer image with common tools.

## Usage

```json
{
  "image": "ghcr.io/shokkunrf/devcontainer-images/base:latest"
}
```

## Included Tools

| Tool | Source |
| --- | --- |
| common-utils (`developer` user) | [devcontainers/features/common-utils](https://github.com/devcontainers/features/tree/main/src/common-utils) |
| git | [devcontainers/features/git](https://github.com/devcontainers/features/tree/main/src/git) |
| GitHub CLI (`gh`) | [devcontainers/features/github-cli](https://github.com/devcontainers/features/tree/main/src/github-cli) |
| Node.js 26 + npm | [devcontainers/features/node](https://github.com/devcontainers/features/tree/main/src/node) |
| prettier | [prettier](https://www.npmjs.com/package/prettier) |
| tmux | Debian apt |

## Testing

```bash
devcontainer up --workspace-folder images/base
devcontainer exec --workspace-folder images/base /bin/sh -c 'cd test-project && chmod +x test.sh && ./test.sh'
```
