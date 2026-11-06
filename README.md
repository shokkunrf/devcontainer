# devcontainer

Custom devcontainer features and images.

## Development

### Release a feature

Bump `version` in `features/src/<name>/devcontainer-feature.json`, then create a GitHub Release tagged `features/<name>/vX.Y.Z` with the same version. It publishes the feature to `ghcr.io/shokkunrf/devcontainer-features/<name>`.

### Release an image

Create a GitHub Release tagged `images/<name>/vX.Y.Z`. It builds the image for amd64 and arm64 and pushes it to `ghcr.io/shokkunrf/devcontainer-images/<name>` with the `X.Y.Z`, `X.Y`, `X`, and `latest` tags. A prerelease pushes only the `sha-<commit>` tag.
