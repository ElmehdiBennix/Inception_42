# build using docker comnpose




all: run

run:


up:
	docker-compose up

down:
	docker-compose down

debug:


list:
	@echo "            ___________IMAGES___________            "
	docker images -a
	@echo "            _________CONTAINERS_________            "
	docker ps -a

volumes:
	docker volume ls

clean :
	docker system prune -af

#problem
fclean : clean
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
	docker rmi $(docker images -aq)
	docker volume rm $(docker volume ls -q)
	docker network rm $(docker network ls -q)
# docker-compose down

re: fclean all

git:
	git add .
	git status
	git commit -m "push"
	git push

.PHONY: