#!/bin/bash

# Script simple para backup rápido de PostgreSQL
# Uso: ./quick_backup.sh [nombre_base_datos]

CONTAINER_NAME="postgres_17"
POSTGRES_USER="admin_user"
POSTGRES_PASSWORD="ChangeMe_SuperSeguro_2025!"
BACKUP_DIR="./backups/postgres"
DATE=$(date +%Y%m%d_%H%M%S)

# Crear directorio si no existe
mkdir -p "$BACKUP_DIR"

if [ $# -eq 0 ]; then
    # Sin argumentos: backup de todas las bases de datos
    echo "🔄 Creando backup de todas las bases de datos..."
    
    # Backup completo del cluster
    docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dumpall -U "$POSTGRES_USER" -h localhost -p 5432 \
        --clean > "$BACKUP_DIR/full_backup_${DATE}.sql"
    
    if [ $? -eq 0 ]; then
        echo "✅ Backup completado: $BACKUP_DIR/full_backup_${DATE}.sql"
        echo "📊 Tamaño: $(du -h "$BACKUP_DIR/full_backup_${DATE}.sql" | cut -f1)"
    else
        echo "❌ Error en el backup"
        exit 1
    fi
else
    # Con argumento: backup de base de datos específica
    DATABASE=$1
    echo "🔄 Creando backup de la base de datos: $DATABASE"
    
    docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dump -U "$POSTGRES_USER" -h localhost -p 5432 \
        --clean --format=custom "$DATABASE" > "$BACKUP_DIR/${DATABASE}_backup_${DATE}.backup"
    
    if [ $? -eq 0 ]; then
        echo "✅ Backup completado: $BACKUP_DIR/${DATABASE}_backup_${DATE}.backup"
        echo "📊 Tamaño: $(du -h "$BACKUP_DIR/${DATABASE}_backup_${DATE}.backup" | cut -f1)"
    else
        echo "❌ Error en el backup de $DATABASE"
        exit 1
    fi
fi

echo "📅 Fecha: $(date)"