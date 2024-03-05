# build using docker comnpose




all: up

up:
	docker-compose up

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

#problem
fclean:
	@echo "Cleaning Docker resources..."
	docker stop $$(docker ps -a -q) || true
	docker rm $$(docker ps -a -q) || true
	docker rmi $$(docker images -q) || true
	docker network prune -f
	docker volume prune -f

re: fclean all

git:
	git add .
	git status
	git commit -m "push"
	git push

.PHONY: