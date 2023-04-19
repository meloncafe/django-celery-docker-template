# Django + Celery + Redis + MariaDB + Docker Template

## Include Package
```bash
mysqlclient
requests
redis
celery
django
django-redis-cache
django-celery-beat
django-redis
django-ipware
django-request-logging
django-environ
environ
gunicorn

All packages except 'django-redis' are up to date
django-redis are >=5.2.0,<6.0.0
```

## How to use
> For development, use your own django runserver and use Docker for Production deployment

## Make Superuser
```bash
$ docker-compose exec django-app-green(or blue) bash
$ python manage.py createsuperuser
```
> Migration automatically migrates containers as they run.

## Docker Image Build
```bash
$ build.sh
```

## Production Deploy
```bash
$ deploy.sh
```
- Blue/Green Deployment
- Nginx Port : 8000