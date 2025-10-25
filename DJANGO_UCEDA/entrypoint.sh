#!/bin/bash

# Realiza migraciones iniciales y crea la base de datos (si es necesario)
python manage.py makemigrations
python manage.py migrate
#python manage.py clear_cache

# para codigo de barra

# Ejecuta el servidor de desarrollo de Django en modo de escucha
python manage.py runserver 0.0.0.0:8000