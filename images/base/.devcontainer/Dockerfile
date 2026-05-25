FROM buildpack-deps:trixie-curl

RUN apt-get update \
    && apt-get install -y --no-install-recommends tmux \
    && rm -rf /var/lib/apt/lists/*

# Default Prettier configuration (fallback for projects without .prettierrc)
COPY .prettierrc /workspaces/.prettierrc
