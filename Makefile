.PHONY: run stop

run:
	docker compose -f .devcontainer/docker-compose.yml up -d --build
	docker compose -f .devcontainer/docker-compose.yml exec app opencode web --port 4096 --host 0.0.0.0

stop:
	docker compose -f .devcontainer/docker-compose.yml down
