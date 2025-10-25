FROM postgres:16-alpine

# Copiamos nuestro entrypoint y le damos permisos
# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh

# Por convención, el entrypoint oficial se llama "docker-entrypoint.sh"
# Nuestro script lo invocará, así que no lo removemos.
# ENTRYPOINT ["entrypoint.sh"]

# El CMD por defecto del contenedor postgres
CMD ["postgres"]
