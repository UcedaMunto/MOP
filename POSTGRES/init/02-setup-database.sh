#!/bin/bash
# Script de inicialización que usa variables de entorno del .env
# Se ejecuta automáticamente la primera vez que se levanta el contenedor

set -e

# Usar la variable POSTGRES_DB del archivo .env
DB_NAME="${POSTGRES_DB:-appdb}"

echo "Inicializando base de datos: $DB_NAME"

# El contenedor de PostgreSQL ya crea automáticamente la base de datos
# especificada en POSTGRES_DB, así que aquí solo configuramos cosas adicionales

# Conectar a la base de datos y ejecutar configuraciones iniciales
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$DB_NAME" <<-EOSQL
    -- Crear esquemas o tablas iniciales si es necesario
    -- CREATE SCHEMA IF NOT EXISTS app_schema;
    -- CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name VARCHAR(100));
    
    -- Mensaje de confirmación
    SELECT 'Base de datos $DB_NAME inicializada correctamente' as mensaje;
EOSQL

echo "Base de datos $DB_NAME configurada exitosamente"