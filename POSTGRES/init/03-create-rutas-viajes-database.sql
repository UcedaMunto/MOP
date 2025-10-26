-- Crear la base de datos rutas_viajes
-- Este script se ejecuta automáticamente la primera vez que se levanta el contenedor

-- Crear la nueva base de datos
CREATE DATABASE rutas_viajes;

-- Crear un usuario específico para esta base de datos (opcional)
-- CREATE USER rutas_user WITH PASSWORD 'rutas_password_2025!';

-- Otorgar permisos al usuario admin_user sobre la nueva base de datos
GRANT ALL PRIVILEGES ON DATABASE rutas_viajes TO admin_user;

-- Conectar a la nueva base de datos para crear esquemas iniciales
\c rutas_viajes;

-- Crear esquemas o tablas iniciales si es necesario
-- CREATE SCHEMA IF NOT EXISTS rutas_schema;

-- Mensaje de confirmación
SELECT 'Base de datos rutas_viajes creada e inicializada correctamente' as mensaje;