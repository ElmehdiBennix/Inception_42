

COMPOSE_FILE := ./srcs/docker-compose.yml

all: up

up:
	docker-compose -f $(COMPOSE_FILE) up --build -d
	$(MAKE) logs

down:
	docker-compose -f $(COMPOSE_FILE) down

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

list:
	@echo "            __________NETWORKS__________            \n"
	@docker network ls
	@echo "            ___________VOLUMES___________            \n"
	@docker volume ls
	@echo "            ___________IMAGES___________            \n"
	@docker images
	@echo "            _________CONTAINERS_________            \n"
	@docker ps -a

del_images :
	docker rmi $$(docker images -aq)

del_containers :
	docker stop $$(docker ps -aq) || true
	docker rm $$(docker ps -aq) || true

del_volume_network :
	docker volume prune -af
	docker network prune -f

clean :
	docker system prune -af

fclean : del_volume_network clean

re: fclean all

git:
	git add .
	git status
	git commit -m "push"
	git push

.PHONY: up down logs list del_images del_containers clean fclean re git
