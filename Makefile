all:
	@sudo sh -c 'echo "127.0.0.1		rel-fila.42.fr" >> /etc/hosts'
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:
	@docker system prune -af
	@docker volume rm wp db

fclean:
	@sudo rm -rf $(HOME)/data/wordpress
	@sudo rm -rf $(HOME)/data/mariadb

.PHONY: all re down clean