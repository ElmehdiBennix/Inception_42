# build using docker comnpose




all:

run:

up:
	docker-compose up

down:
	docker-compose down

debug:

list:

volumes:

clean:

git:
	git add .
	git status
	git commit -m "push"
	git push

.PHONY: