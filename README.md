# Workspace

This repository contains a Docker-based development workspace for running OpenCode in a reproducible devcontainer environment.

## What Is Included

- Devcontainer configuration for VS Code and compatible tools.
- Docker Compose setup for running the workspace container.
- Base Ubuntu 24.04 workspace image with common CLI tools.
- Java-enabled workspace image with JDK 8, JDK 21, and Maven.
- OpenCode configuration and bundled agent skills.
- GitHub Actions workflows for publishing Docker images.

## Images

The workflows publish these Docker images:

- `songhuangcn/workspace:latest`
- `songhuangcn/workspace:commit-<short-sha>`
- `songhuangcn/workspace-java:latest`
- `songhuangcn/workspace-java:commit-<short-sha>`

## Local Usage

Create a local environment file from the sample if needed:

```bash
cp .devcontainer/.env.sample .devcontainer/.env
```

Start the container and OpenCode web server:

```bash
make start
```

Open an interactive shell in the container:

```bash
make bash
```

Follow container logs:

```bash
make logs
```

Stop the container:

```bash
make stop
```

Update the local image and restart:

```bash
make update
```

## Configuration

Important tracked files:

- `.devcontainer/devcontainer.json`: devcontainer entrypoint configuration.
- `.devcontainer/docker-compose.yml`: container image, ports, and mounted config directories.
- `.devcontainer/Dockerfile`: base workspace image definition.
- `.devcontainer/Dockerfile.java`: Java workspace image definition.
- `.devcontainer/config/opencode/opencode.jsonc`: OpenCode runtime configuration.
- `.github/workflows/build-devcontainer.yml`: base image publishing workflow.
- `.github/workflows/build-devcontainer-java.yml`: Java image publishing workflow.

## Local Data And Secrets

The repository intentionally ignores local runtime data and secrets, including:

- `.devcontainer/.env`
- `.devcontainer/config/.ssh/*`
- `.devcontainer/config/gh/*`
- `.devcontainer/data/opencode/*`

Keep credentials and generated data out of Git.
