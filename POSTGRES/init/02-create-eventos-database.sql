-- Crear la base de datos eventos_trafico
-- Este script se ejecuta automáticamente la primera vez que se levanta el contenedor

-- Crear la nueva base de datos
CREATE DATABASE eventos_trafico;

-- Crear un usuario específico para esta base de datos (opcional)
-- CREATE USER eventos_user WITH PASSWORD 'eventos_password_2025!';

-- Otorgar permisos al usuario admin_user sobre la nueva base de datos
GRANT ALL PRIVILEGES ON DATABASE eventos_trafico TO admin_user;

-- Conectar a la nueva base de datos para crear esquemas iniciales
\c eventos_trafico;

-- Crear esquemas o tablas iniciales si es necesario
-- CREATE SCHEMA IF NOT EXISTS eventos_schema;

-- Mensaje de confirmación
SELECT 'Base de datos eventos_trafico creada e inicializada correctamente' as mensaje;