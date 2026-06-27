COMPOSE = docker compose -f docker-compose.yml

.PHONY: run
run:
	$(COMPOSE) up -d
	$(COMPOSE) exec app opencode web --port 4096 --hostname 0.0.0.0

.PHONY: start
start:
	$(COMPOSE) up -d
	$(COMPOSE) exec -d app opencode web --port 4096 --hostname 0.0.0.0

.PHONY: start-opencode
start-opencode:
	$(COMPOSE) exec -d app opencode web --port 4096 --hostname 0.0.0.0

.PHONY: restart-opencode
restart-opencode:
	$(COMPOSE) exec app sh -c "lsof -ti tcp:4096 | xargs -r kill || true"
	$(COMPOSE) exec -d app opencode web --port 4096 --hostname 0.0.0.0

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
	$(COMPOSE) exec app bash

.PHONY: update
update: pull down start

.PHONY: pull
pull:
	$(COMPOSE) pull app

.PHONY: build
build:
	$(COMPOSE) build

.PHONY: down
down:
	$(COMPOSE) down

.PHONY: destroy
destroy:
	$(COMPOSE) down --volumes --rmi all
