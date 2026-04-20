FROM ubuntu:24.04

# Install basic development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
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
    openssh-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu

WORKDIR /workspace

ENV TZ=Asia/Shanghai \
    SHELL=/bin/bash \
    PATH=/home/ubuntu/.local/bin:/home/ubuntu/.local/share/mise/shims:$PATH \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN curl https://mise.run/bash | sh
RUN mise use --global \
    node@22 \
    python@3.13 \
    opencode@1.4 \
    docker-cli@28 \
    kubectl@1.35 \
    uv@0 \
    rg@15

RUN mise use -g npm:@larksuite/cli@latest

CMD ["sleep", "infinity"]
