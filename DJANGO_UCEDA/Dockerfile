FROM python:3.12-slim

# Actualizar los paquetes del sistema e instalar dependencias necesarias para compilar pycairo
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    pkg-config \
    libcairo2-dev \
    libgirepository1.0-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --upgrade pip setuptools
RUN pip install coreapi
RUN pip install django
# para el uso de la politica de cors origenes cruzados con otros dominios
RUN pip install django-cors-headers
RUN pip install setuptools
# Utilidades para Django rest framework
RUN pip install djangorestframework
RUN pip install djangorestframework_jsonschema
RUN pip install djangorestframework-jsonapi
RUN pip install djangorestframework-jsonapi['django-filter']
RUN pip install djangorestframework-jsonapi['django-polymorphic']
RUN pip install djangorestframework-jsonapi['openapi']
# Markdown support for the browsable API.
RUN pip install markdown       
# Filtering support
RUN pip install django-filter  
# Documentación oficial
RUN pip install drf-jsonschema-serializer
# Para configurar multitenencia
RUN pip install django-tenants
RUN pip install pyyaml uritemplate
# SERVIDOR DE DJANGO UTIL SOLO EN PRODUCCION
RUN pip install gunicorn
# PARA LA BASE DE DATOS POSTGRES
RUN pip install psycopg2-binary
# RUN pip install PyJWT
RUN pip install djangorestframework-simplejwt
# Para manejar el archivo .env con django
RUN pip install python-decouple
# Para usar Redis como cache y sesiones en Django
RUN pip install django-redis redis
RUN pip freeze
RUN pip install django-url-filter
RUN pip install xhtml2pdf
RUN pip install num2words
RUN pip install pytest-django
RUN pip install python-dateutil
COPY . /app
WORKDIR /app

# Copia el archivo requirements.txt y los archivos del proyecto al directorio de trabajo
COPY requirements.txt /app/
COPY . /app/

# Instala las dependencias del proyecto
RUN pip install -r requirements.txt

RUN pip install pymongo
RUN pip install reportlab

RUN pip install drf-yasg
RUN pip install openpyxl
RUN pip install django-simple-history

RUN pip install python-barcode
RUN pip install "python-barcode[images]"
RUN pip install -U channels

RUN pip install django-debug-toolbar
RUN pip install SQLAlchemy
# Pinto
RUN pip install sqlalchemy-hana
# Fin Pinto

# Expon el puerto 8000 para Django
EXPOSE 8000

# Comando de entrada para ejecutar el servidor de desarrollo de Django
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

COPY ./entrypoint.sh .
ENTRYPOINT [ "sh", "/app/entrypoint.sh" ]