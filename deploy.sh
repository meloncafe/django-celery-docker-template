#!/bin/bash

# Docker image build
sh build.sh

RUNNING_APPLICATION=$(docker ps | grep blue)
DEFAULT_CONF="docker/config/nginx/app.conf"

if [ -n "$RUNNING_APPLICATION"  ];then
	echo "Django App Green Deploy..."
	docker-compose pull django-app-green
	docker-compose up -d django-app-green

	while [ 1 == 1 ]; do
		echo "Django App Green Health Check...."
		REQUEST=$(docker exec django-web curl http://django-app-green:8000)
		echo $REQUEST
		if [ -n "$REQUEST" ]; then
			break ;
		fi
		sleep 3
	done;

	sed -i 's/blue/green/g' $DEFAULT_CONF
	docker exec django-web service nginx reload
	docker-compose stop django-app-blue
else
	echo "Django App Blue Deploy..."
	docker-compose pull django-app-blue
  docker-compose up -d django-app-blue

	while [ 1 == 1 ]; do
		echo "Django App Blue Health Check...."
                REQUEST=$(docker exec django-web curl http://django-app-blue:8000)
                echo $REQUEST
		if [ -n "$REQUEST" ]; then
            break ;
        fi
		sleep 3
    done;

	sed -i 's/green/blue/g' $DEFAULT_CONF
    docker exec django-web service nginx reload
	docker-compose stop django-app-green
fi