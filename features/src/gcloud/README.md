# Google Cloud CLI (gcloud)

Installs [Google Cloud CLI](https://cloud.google.com/sdk/gcloud) via the official tarball.

## Usage

```json
"features": {
    "ghcr.io/shokkunrf/devcontainer-features/gcloud": {}
}
```

## Requirements

- `curl` and `tar` must be available in the container
- Linux (x86_64 or aarch64)
- aarch64: Python 3.9-3.14 must be installed (x86_64 bundles Python)

## Using host credentials

To forward your host's gcloud credentials into the container, add the following to `devcontainer.json`:

```json
"mounts": [
    "source=${localEnv:HOME}/.config/gcloud,target=/home/vscode/.config/gcloud,type=bind,consistency=cached"
]
```

Replace `/home/vscode` with the appropriate home directory for your container user.
