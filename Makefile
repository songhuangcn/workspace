COMPOSE = docker compose -f .devcontainer/docker-compose.yml

.PHONY: run
run:
	$(COMPOSE) up -d
	$(COMPOSE) exec app opencode web --port 4096 --hostname 0.0.0.0

.PHONY: start
start:
	$(COMPOSE) up -d
	$(COMPOSE) exec -d app opencode web --port 4096 --hostname 0.0.0.0

.PHONY: logs
logs:
	$(COMPOSE) logs -f app

.PHONY: stop
stop:
	$(COMPOSE) stop

.PHONY: build
build:
	$(COMPOSE) build

.PHONY: down
down:
	$(COMPOSE) down

.PHONY: destroy
destroy:
	$(COMPOSE) down --volumes --rmi all
