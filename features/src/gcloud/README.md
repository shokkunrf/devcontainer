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
- Linux x86_64 or aarch64 (glibc-based; Alpine/musl is not supported)
- A Python 3 with the `sqlite3` stdlib module. If missing, the feature installs `python3` via `apt-get` (tested on Debian and Ubuntu). If a `python` feature is also added, its Python is reused.

## Using host credentials

To forward your host's gcloud credentials into the container, add the following to `devcontainer.json`:

```json
"mounts": [
    "source=${localEnv:HOME}/.config/gcloud,target=/home/vscode/.config/gcloud,type=bind,consistency=cached"
]
```

Replace `/home/vscode` with the appropriate home directory for your container user.
