#!/bin/bash

# Script para restaurar backups de PostgreSQL
# Fecha: $(date +"%Y-%m-%d %H:%M:%S")

# Configuración
CONTAINER_NAME="postgres_17"
POSTGRES_USER="admin_user"
POSTGRES_PASSWORD="ChangeMe_SuperSeguro_2025!"
BACKUP_DIR="./backups/postgres"

echo "=== Script de Restauración PostgreSQL ==="
echo "Fecha: $(date)"
echo "Contenedor: $CONTAINER_NAME"
echo ""

# Función para listar backups disponibles
list_backups() {
    echo "📁 Backups disponibles en $BACKUP_DIR:"
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
        ls -lah "$BACKUP_DIR" | grep -E '\.(sql|backup|custom)$' | while read -r line; do
            echo "   $line"
        done
    else
        echo "   ❌ No hay backups disponibles en $BACKUP_DIR"
        return 1
    fi
    echo ""
}

# Función para restaurar backup completo (pg_dumpall)
restore_full_backup() {
    local backup_file=$1
    
    if [ ! -f "$backup_file" ]; then
        echo "❌ Archivo de backup no encontrado: $backup_file"
        return 1
    fi
    
    echo "⚠️  ADVERTENCIA: Esta operación eliminará todas las bases de datos existentes"
    echo "   y las reemplazará con el contenido del backup."
    echo ""
    read -p "¿Estás seguro de continuar? (escribe 'SI' para confirmar): " confirm
    
    if [ "$confirm" != "SI" ]; then
        echo "❌ Operación cancelada"
        return 1
    fi
    
    echo "🔄 Restaurando backup completo desde: $backup_file"
    
    # Restaurar usando psql
    docker exec -i -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        psql -U "$POSTGRES_USER" -h localhost -p 5432 -d postgres < "$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "✅ Backup completo restaurado exitosamente"
    else
        echo "❌ Error al restaurar el backup completo"
        return 1
    fi
}

# Función para restaurar backup de base de datos específica (pg_dump)
restore_database_backup() {
    local backup_file=$1
    local target_db=$2
    
    if [ ! -f "$backup_file" ]; then
        echo "❌ Archivo de backup no encontrado: $backup_file"
        return 1
    fi
    
    if [ -z "$target_db" ]; then
        echo "❌ Nombre de base de datos destino requerido"
        return 1
    fi
    
    echo "🔄 Restaurando backup de base de datos desde: $backup_file"
    echo "   Base de datos destino: $target_db"
    
    # Verificar si la base de datos existe, si no, crearla
    db_exists=$(docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        psql -U "$POSTGRES_USER" -h localhost -p 5432 -t -c \
        "SELECT 1 FROM pg_database WHERE datname='$target_db';" | xargs)
    
    if [ "$db_exists" != "1" ]; then
        echo "📊 Creando base de datos: $target_db"
        docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
            createdb -U "$POSTGRES_USER" -h localhost -p 5432 "$target_db"
    fi
    
    # Determinar el tipo de archivo y restaurar apropiadamente
    if [[ "$backup_file" == *.custom ]] || [[ "$backup_file" == *.backup ]]; then
        # Formato custom - usar pg_restore
        docker exec -i -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
            pg_restore -U "$POSTGRES_USER" -h localhost -p 5432 \
            --clean --if-exists -d "$target_db" < "$backup_file"
    else
        # Formato SQL - usar psql
        docker exec -i -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
            psql -U "$POSTGRES_USER" -h localhost -p 5432 -d "$target_db" < "$backup_file"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✅ Backup de base de datos restaurado exitosamente en: $target_db"
    else
        echo "❌ Error al restaurar el backup de la base de datos"
        return 1
    fi
}

# Función para mostrar menú
show_menu() {
    echo "Selecciona el tipo de restauración:"
    echo "1) Restaurar backup completo (pg_dumpall - REEMPLAZA TODO)"
    echo "2) Restaurar backup de base de datos específica"
    echo "3) Listar backups disponibles"
    echo "4) Salir"
}

# Función principal
main() {
    # Verificar que el contenedor esté ejecutándose
    if ! docker ps | grep -q "$CONTAINER_NAME"; then
        echo "❌ El contenedor $CONTAINER_NAME no está ejecutándose"
        echo "Inicia los servicios con: docker-compose up -d"
        exit 1
    fi
    
    if [ $# -eq 0 ]; then
        # Modo interactivo
        list_backups
        show_menu
        read -p "Opción: " choice
        
        case $choice in
            1)
                list_backups
                read -p "Nombre del archivo de backup completo: " backup_file
                if [[ "$backup_file" != /* ]]; then
                    backup_file="$BACKUP_DIR/$backup_file"
                fi
                restore_full_backup "$backup_file"
                ;;
            2)
                list_backups
                read -p "Nombre del archivo de backup: " backup_file
                read -p "Nombre de la base de datos destino: " target_db
                if [[ "$backup_file" != /* ]]; then
                    backup_file="$BACKUP_DIR/$backup_file"
                fi
                restore_database_backup "$backup_file" "$target_db"
                ;;
            3)
                list_backups
                ;;
            4)
                echo "Saliendo..."
                exit 0
                ;;
            *)
                echo "Opción inválida"
                exit 1
                ;;
        esac
    else
        # Modo por argumentos
        case $1 in
            --full|-f)
                if [ -z "$2" ]; then
                    echo "Error: Especifica el archivo de backup"
                    echo "Uso: $0 --full archivo_backup.sql"
                    exit 1
                fi
                restore_full_backup "$2"
                ;;
            --database|-d)
                if [ -z "$2" ] || [ -z "$3" ]; then
                    echo "Error: Especifica el archivo de backup y la base de datos destino"
                    echo "Uso: $0 --database archivo_backup.sql nombre_db"
                    exit 1
                fi
                restore_database_backup "$2" "$3"
                ;;
            --list|-l)
                list_backups
                ;;
            --help|-h)
                echo "Uso: $0 [OPCIÓN] [ARGUMENTOS]"
                echo ""
                echo "Opciones:"
                echo "  -f, --full FILE         Restaurar backup completo"
                echo "  -d, --database FILE DB  Restaurar backup de base de datos específica"
                echo "  -l, --list              Listar backups disponibles"
                echo "  -h, --help              Mostrar esta ayuda"
                echo ""
                echo "Sin argumentos: Modo interactivo"
                exit 0
                ;;
            *)
                echo "Opción desconocida: $1"
                echo "Usa $0 --help para ver las opciones disponibles"
                exit 1
                ;;
        esac
    fi
    
    echo ""
    echo "=== Operación completada ==="
    echo "Fecha: $(date)"
}

# Ejecutar función principal con todos los argumentos
main "$@"