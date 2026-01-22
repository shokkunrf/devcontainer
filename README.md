# devcontainer

Custom devcontainer features and images.

## Development

### Publish features

```sh
devcontainer features publish ./features --namespace ghcr.io/shokkunrf/devcontainer-features
```

### Build and push images

```sh
for dir in ./images/*/; do
    name=$(basename "$dir")
    devcontainer build --workspace-folder "$dir" --image-name "ghcr.io/shokkunrf/devcontainer-images/$name:latest" --push
done
```
