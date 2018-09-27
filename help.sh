#!/bin/bash

readonly NAME="liho"
readonly REPO_NAME="liho-docker-image-php-fpm"
readonly REPO="https://github.com/lehungio/$NAME"
readonly LIHO_PATH="/code"
readonly PUBLIC_PATH="/code/public_html"
readonly LOCALHOST="127.0.0.1"

helps() {
	case $1 in
		all|*) allhelps ;;
	esac
}

allhelps() {
cat <<EOF
💡 Usage: ./help.sh COMMAND
[help|usage|build|init|up|down|restart|status|logs|ssh]

[CLI]
  build        Build docker service
  up or start  Run docker-compose as daemon (or up)
  down or stop Terminate all docker containers run by docker-compose (or down)
  restart      Restart docker-compose containers
  status       View docker containers status
  logs         View docker containers logs
  ssh          ssh cli
EOF
}

# Usage
usage() {
	echo "Usage:"
	echo "${0} [help|usage|build|init|up|down|restart|status|logs|ssh]"
}

# Docker compose build
build() {
	docker-compose build
}

# Docker compose up
start() {
	docker-compose up -d
}

# Docker compose down
stop() {
	docker-compose down
}

# Docker compose restart
restart() {
	docker-compose restart
}

# Docker compose status
status() {
	docker-compose ps
}

# Docker compose logs
logs() {
	case $1 in
		liho|*) docker-compose logs ;;
	esac
}

# ssh cli
run_ssh() {
	case $1 in
		php-test|php_test) 
			docker-compose exec php_test /bin/bash 
		;;
		liho|*) 
			docker-compose exec ${NAME} /bin/bash 
		;;
	esac
}

case $1 in
	init) 
		init ${2:-v2}
	;;

	build) 
		build 
	;;

	start|up) 
		start 
	;;

	stop|down) 
		stop 
	;;

	restart|reboot) 
		restart
	;;

	status|ps)
		status
	;;

	logs)
		logs ${2:-all}
	;;

	ssh)
		run_ssh ${2:-php}
	;;
	
	*)
		helps
	;;
esac
