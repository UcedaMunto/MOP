#!/bin/sh
set -e

CONF_DIR="/etc/postgresql/custom"
PGDATA="${PGDATA:-/var/lib/postgresql/data}"

mkdir -p "$CONF_DIR"

# Plantillas base si no existen
[ -f "$CONF_DIR/postgresql.conf" ] || cat > "$CONF_DIR/postgresql.conf" <<'EOC'
listen_addresses = '*'
port = 5432
max_connections = 200
shared_buffers = 256MB
effective_cache_size = 768MB
work_mem = 16MB
maintenance_work_mem = 64MB
logging_collector = on
log_destination = 'stderr'
log_min_duration_statement = 1000
log_connections = on
log_disconnections = on
EOC

[ -f "$CONF_DIR/pg_hba.conf" ] || cat > "$CONF_DIR/pg_hba.conf" <<'EOC'
# Abierto para pruebas; restringe por firewall y/o cambia redes permitidas
host    all             all             0.0.0.0/0               md5
host    all             all             ::/0                    md5
local   all             all                                     trust
EOC

chown -R postgres:postgres "$CONF_DIR"

# Si es primer arranque (no existe PG_VERSION), deja que initdb cree todo
# y luego sustituimos las configs por las nuestras.
if [ ! -f "$PGDATA/PG_VERSION" ]; then
  # Deja que el entrypoint oficial inicialice (no arranca el servidor aún)
  docker-entrypoint.sh -c 'shared_buffers=128MB' -c 'max_connections=100' --help >/dev/null 2>&1 || true

  # Copiamos nuestras configs al PGDATA
  cp -f "$CONF_DIR/postgresql.conf" "$PGDATA/postgresql.conf"
  cp -f "$CONF_DIR/pg_hba.conf"     "$PGDATA/pg_hba.conf"
  chown postgres:postgres "$PGDATA/postgresql.conf" "$PGDATA/pg_hba.conf"
else
  # Limpieza defensiva: si alguien metió include_dir por ALTER SYSTEM, bórralo
  if [ -f "$PGDATA/postgresql.auto.conf" ]; then
    sed -i '/^[[:space:]]*include_dir[[:space:]]*=.*/d' "$PGDATA/postgresql.auto.conf"
  fi
  # Opcional: forzar nuestras configs en cada arranque
  cp -f "$CONF_DIR/postgresql.conf" "$PGDATA/postgresql.conf"
  cp -f "$CONF_DIR/pg_hba.conf"     "$PGDATA/pg_hba.conf"
  chown postgres:postgres "$PGDATA/postgresql.conf" "$PGDATA/pg_hba.conf"
fi

# Asegurar que las variables de entorno estén disponibles para el entrypoint oficial
export POSTGRES_USER="${POSTGRES_USER:-postgres}"
export POSTGRES_PASSWORD="${POSTGRES_PASSWORD}"
export POSTGRES_DB="${POSTGRES_DB:-postgres}"

# Arrancar con el entrypoint oficial **sin** pasar -c de config_file/hba_file
# (esto evita que "include_dir" se interprete como GUC)
exec docker-entrypoint.sh postgres
