from setuptools import setup

import backend

install_requires = [
    'mysqlclient',
    'requests',

    'redis',
    'celery',
    'django',
    'django-redis-cache',
    'django-celery-beat',
    'django-redis>=5.2.0,<6.0.0',
    'flower',

    'django-ipware',
    'django-request-logging',

    'django-environ',
    'environ',

    'gunicorn',
]

setup(
    name='Django Template',
    version=backend.__version__,
    packages=['backend'],
    url='https://github.com/meloncafe/django-celery-docker-template',
    license='MIT',
    author='M.Cafe',
    author_email='',
    description='Django Template',
    install_requires=install_requires,
    python_requires='~=3.9',
    zip_safe=False,
    include_package_data=True
)
