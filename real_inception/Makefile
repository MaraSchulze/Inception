all:
	cd srcs; docker-compose up
down:
	cd srcs; docker-compose down -v
clean: down
	cd srcs; docker rmi `docker images -q`
fclean: clean
	sudo rm -r /home/marschul/data/mariadb/*
	sudo rm -r /home/marschul/data/wordpressfiles/*

.ignore: clean
