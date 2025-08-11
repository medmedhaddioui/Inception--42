DIR="./srcs/docker-compose.yml"

up:
	@docker compose -f $(DIR) up --build -d
down:
	@docker compose -f $(DIR) down
restart:
	@docker compose -f $(DIR) down && docker compose -f $(DIR) up
fclean:
	@docker system prune -a --volumes -f
