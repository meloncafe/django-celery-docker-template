#!/bin/sh

until cd /app
do
    echo "Waiting for server volume..."
done

if [ "$1" = "worker" ]; then
    celery -A backend worker --loglevel=info
elif [ "$1" = "beat" ]; then
    celery -A backend beat --loglevel=info
elif [ "$1" = "flower" ]; then
    celery -A backend flower
else
    echo "Unknown command"
fi
