# build using docker comnpose




all: up

up:
	docker-compose up --build 
# default docker-compose up builds image if it dosent exist if i made changes to it
#it dosnt rebuild it

down:
	docker-compose down

debug:


list:
	@echo "            ___________IMAGES___________            "
	docker images
	@echo "            _________CONTAINERS_________            "
	docker ps

volume:
	docker volume ls

network:
	docker network ls

clean :
	docker system prune -af
	docker volume prune -af
	docker network prune -f

fclean:
	@echo "Cleaning Docker resources..."
	docker stop $$(docker ps -a -q) || true
	docker rm $$(docker ps -a -q) || true
	docker rmi $$(docker images -q) || true

re: fclean all

git:
	git add .
	git status
	git commit -m "push"
	git push

.PHONY: