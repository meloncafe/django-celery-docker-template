FROM python:3.9-slim

ENV PYTHONUNBUFFERED 1
ARG DEBUG=0

WORKDIR /app

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    libmariadb-dev gcc supervisor git htop

COPY ./backend /app/backend

RUN if [[ ${DEBUG} == 0 ]]; then \
        COPY ./config/.env /app/config/.env; \
    fi

COPY ./manage.py /app/manage.py
COPY ./setup.py /app/setup.py
COPY ./docker/script/server-entrypoint.sh /app/server-entrypoint.sh
COPY ./docker/script/celery-entrypoint.sh /app/celery-entrypoint.sh

RUN chmod +x /app/server-entrypoint.sh \
    && chmod +x /app/celery-entrypoint.sh \
    && pip install -U pip \
    && pip install -e . \
    && python manage.py collectstatic --noinput
