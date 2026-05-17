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
    locales \
    sqlite3 \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

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

# VS Code Server broken
# https://gist.github.com/b01/0a16b6645ab7921b0910603dfb85e4fb
ADD scripts/vscode-server-install.sh /tmp/vscode-server-install.sh
RUN bash /tmp/vscode-server-install.sh 072586267e68ece9a47aa43f8c108e0dcbf44622 && sudo rm -rf /tmp/*
# RUN curl -sSL https://gist.githubusercontent.com/b01/0a16b6645ab7921b0910603dfb85e4fb/raw/b0375bb5dd390199518a6cdf91a909ed27807119/download-vs-code-server.sh | bash -s -- linux

RUN curl https://mise.run/bash | sh

RUN mise use --global \
    node@22 \
    python@3.13 \
    opencode@1.14.46 \
    docker-cli@28 \
    kubectl@1.35 \
    uv@0 \
    rg@15 \
    java@zulu-8.92.0.21 \
    java@zulu-21.40.17.0 \
    maven@3.9.9 \
    && mise cache clear

RUN pip install requests~=2.32.5 urllib3~=2.6.3 pymupdf

# keep permissions
RUN mkdir -p ~/.vscode-server

CMD ["sleep", "infinity"]
