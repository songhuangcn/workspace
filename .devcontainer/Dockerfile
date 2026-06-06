FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# Install basic development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository --yes universe \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    clang \
    git \
    pkg-config \
    procps \
    sudo \
    unzip \
    gnupg2 \
    vim \
    curl \
    ca-certificates \
    make \
    less \
    lsof \
    man-db \
    jq \
    tree \
    gh \
    libssl-dev \
    openssh-client \
    locales \
    sqlite3 \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu

WORKDIR /workspace

ENV TZ=Asia/Shanghai \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh \
    LC_ALL=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PATH=/home/ubuntu/.local/bin:/home/ubuntu/.local/share/mise/shims:$PATH \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN curl https://mise.run/bash | sh

RUN mise use --global \
    node@22 \
    python@3.13 \
    opencode@1.15.10 \
    npm:@openai/codex@0.137 \
    kubectl@1.35 \
    uv@0 \
    rg@15 \
    npm:@larksuite/cli@1.0 \
    && mise cache clear

RUN python -m pip install --no-cache-dir requests~=2.32.5 urllib3~=2.6.3 pymupdf

# keep permissions
RUN mkdir -p ~/.vscode-server

CMD ["sleep", "infinity"]
