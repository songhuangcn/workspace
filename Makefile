# 启动/进入容器走 devcontainer CLI（让镜像 metadata 中的 features 生效）；
# 停止/清理/日志走 docker compose（devcontainer CLI 无 stop/down）。
# 前置：宿主机需安装 devcontainer CLI —— npm install -g @devcontainers/cli（详见 README）。
# COMPOSE_PROJECT_NAME 让 devcontainer up 与 docker compose 命中同一组容器。
export COMPOSE_PROJECT_NAME = workspace-devcontainer

COMPOSE      = docker compose -f docker-compose.yml
DEVCONTAINER = devcontainer
WORKSPACE    = ..

.PHONY: run
run:
	$(DEVCONTAINER) up --workspace-folder $(WORKSPACE)

.PHONY: start
start:
	$(DEVCONTAINER) up --workspace-folder $(WORKSPACE)

.PHONY: start-opencode
start-opencode:
	$(COMPOSE) exec -d app bash .devcontainer/scripts/post-start.sh

.PHONY: restart-opencode
restart-opencode:
	$(COMPOSE) exec app sh -c "lsof -ti tcp:4096 -sTCP:LISTEN | xargs -r kill || true"
	$(COMPOSE) exec -d app bash .devcontainer/scripts/post-start.sh

.PHONY: logs
logs:
	$(COMPOSE) logs -f app

.PHONY: restart
restart: stop start

.PHONY: stop
stop:
	$(COMPOSE) stop

.PHONY: bash
bash:
	$(DEVCONTAINER) exec --workspace-folder $(WORKSPACE) bash

.PHONY: update
update: pull down start

.PHONY: pull
pull:
	$(COMPOSE) pull app

# 本地构建运行镜像（Dockerfile + dind/sshd features），与 CI 一致。compose 同时支持 image 与
# build：平时 `make pull` 拉取预构建镜像，改 Dockerfile 后用 `make build` 本地重建同名镜像。
.PHONY: build
build:
	$(DEVCONTAINER) build --workspace-folder . --config devcontainer.json --image-name songhuangcn/devcontainer:latest

.PHONY: down
down:
	$(COMPOSE) down

.PHONY: destroy
destroy:
	$(COMPOSE) down --volumes --rmi all
