-- Crear la base de datos usando la variable POSTGRES_DB del .env
-- Este script se ejecuta automáticamente la primera vez que se levanta el contenedor
-- La variable POSTGRES_DB se pasa automáticamente desde el .env

-- Crear esquemas o tablas iniciales si es necesario
-- CREATE SCHEMA IF NOT EXISTS app_schema;
-- CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name VARCHAR(100));

-- Mensaje de confirmación
SELECT 'Base de datos ' || current_database() || ' inicializada correctamente' as mensaje;