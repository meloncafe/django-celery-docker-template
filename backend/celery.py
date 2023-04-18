import os
from datetime import timedelta

import environ
from celery import Celery
# set the default Django settings module for the 'celery' program.
from django.apps import apps
from django.conf import settings

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

env = environ.Env(
    # set casting, default value
    DEBUG=(bool, False),
    SECRET_KEY=(str, "wow I'm a really bad default secret key")
)
# reading .env file
environ.Env.read_env(os.path.join(os.path.join(BASE_DIR, 'config'), '.env'))

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')

app = Celery('backend')

app.conf.humanize(with_defaults=False, censored=True)
# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object(settings)
app.conf.enable_utc = False
app.conf.timezone = 'Asia/Seoul'
app.conf.broker_url = 'redis://{}:{}/0'.format(env('REDIS_HOST'), env('REDIS_PORT'))

# Load task modules from all registered Django app configs.
app.autodiscover_tasks(lambda: [n.name for n in apps.get_app_configs()])
