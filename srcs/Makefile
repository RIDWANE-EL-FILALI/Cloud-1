all:
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	@docker-compose -f ./docker-compose.yml up -d

down:
	@docker-compose -f ./docker-compose.yml down

re:
	@docker-compose -f ./docker-compose.yml up --build -d

clean:
	@docker system prune -af
	@docker volume rm wp db

fclean:
	@sudo rm -rf $(HOME)/data/wordpress
	@sudo rm -rf $(HOME)/data/mariadb

.PHONY: all re down clean
