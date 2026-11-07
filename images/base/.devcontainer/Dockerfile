FROM buildpack-deps:trixie-curl

RUN apt-get update \
    && apt-get install -y --no-install-recommends tmux \
    && rm -rf /var/lib/apt/lists/*

# Prettier plugin loaded by the default configuration
RUN mkdir /usr/local/share/prettier-plugins
ADD --chmod=644 --checksum=sha256:f0290d17ce1bd85a2730f1fdfb813bc3a196ac583459de319b4f32ec1a68ff19 \
    https://github.com/shokkunrf/prettier-plugins/releases/download/minimal-diff/v1.0.0/prettier-plugin-minimal-diff.mjs \
    /usr/local/share/prettier-plugins/

# Default Prettier configuration (fallback for projects without .prettierrc)
COPY prettierrc.json /workspaces/.prettierrc
