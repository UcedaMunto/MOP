FROM postgis/postgis:16-3.4-alpine

# Instalar dependencias adicionales para PostGIS
RUN apk update && apk add --no-cache \
    postgresql-contrib \
    && rm -rf /var/cache/apk/*

# Copiamos nuestro entrypoint y le damos permisos
# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh

# Por convención, el entrypoint oficial se llama "docker-entrypoint.sh"
# Nuestro script lo invocará, así que no lo removemos.
# ENTRYPOINT ["entrypoint.sh"]

# El CMD por defecto del contenedor postgres
CMD ["postgres"]
