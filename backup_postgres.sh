#!/bin/bash

# Script para crear backup de PostgreSQL
# Fecha: $(date +"%Y-%m-%d %H:%M:%S")

# Configuración
CONTAINER_NAME="postgres_17"
POSTGRES_USER="admin_user"
POSTGRES_PASSWORD="ChangeMe_SuperSeguro_2025!"
BACKUP_DIR="./backups/postgres"
DATE=$(date +%Y%m%d_%H%M%S)

# Crear directorio de backups si no existe
mkdir -p "$BACKUP_DIR"

echo "=== Iniciando backup de PostgreSQL ==="
echo "Fecha: $(date)"
echo "Contenedor: $CONTAINER_NAME"
echo "Directorio de backup: $BACKUP_DIR"
echo ""

# Función para hacer backup de una base de datos específica
backup_database() {
    local db_name=$1
    local backup_file="$BACKUP_DIR/${db_name}_backup_${DATE}.sql"
    
    echo "Creando backup de la base de datos: $db_name"
    
    # Ejecutar pg_dump dentro del contenedor
    docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dump -U "$POSTGRES_USER" -h localhost -p 5432 \
        --verbose --clean --no-owner --no-privileges \
        --format=custom "$db_name" > "${backup_file}.custom"
    
    # También crear un backup en formato SQL plano
    docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dump -U "$POSTGRES_USER" -h localhost -p 5432 \
        --verbose --clean --no-owner --no-privileges \
        --format=plain "$db_name" > "$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "✅ Backup de $db_name completado:"
        echo "   - Formato custom: ${backup_file}.custom"
        echo "   - Formato SQL: $backup_file"
        
        # Mostrar tamaño del archivo
        echo "   - Tamaño custom: $(du -h "${backup_file}.custom" | cut -f1)"
        echo "   - Tamaño SQL: $(du -h "$backup_file" | cut -f1)"
    else
        echo "❌ Error al crear backup de $db_name"
        return 1
    fi
    echo ""
}

# Función para hacer backup de todas las bases de datos
backup_all_databases() {
    echo "Obteniendo lista de bases de datos..."
    
    # Obtener lista de bases de datos (excluyendo las del sistema)
    databases=$(docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        psql -U "$POSTGRES_USER" -h localhost -p 5432 -t -c \
        "SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('postgres', 'template0', 'template1');")
    
    if [ -z "$databases" ]; then
        echo "❌ No se encontraron bases de datos para respaldar"
        return 1
    fi
    
    echo "Bases de datos encontradas:"
    echo "$databases" | sed 's/^/ - /'
    echo ""
    
    # Hacer backup de cada base de datos
    for db in $databases; do
        # Limpiar espacios en blanco
        db=$(echo "$db" | xargs)
        if [ ! -z "$db" ]; then
            backup_database "$db"
        fi
    done
}

# Función para hacer backup completo del cluster
backup_full_cluster() {
    local backup_file="$BACKUP_DIR/full_cluster_backup_${DATE}.sql"
    
    echo "Creando backup completo del cluster PostgreSQL..."
    
    docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dumpall -U "$POSTGRES_USER" -h localhost -p 5432 \
        --verbose --clean > "$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "✅ Backup completo del cluster completado: $backup_file"
        echo "   - Tamaño: $(du -h "$backup_file" | cut -f1)"
    else
        echo "❌ Error al crear backup completo del cluster"
        return 1
    fi
    echo ""
}

# Mostrar menú de opciones
show_menu() {
    echo "Selecciona el tipo de backup:"
    echo "1) Backup de todas las bases de datos (individual)"
    echo "2) Backup completo del cluster (incluye usuarios y roles)"
    echo "3) Backup de una base de datos específica"
    echo "4) Ambos (recomendado)"
    echo "5) Salir"
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
        show_menu
        read -p "Opción: " choice
        
        case $choice in
            1)
                backup_all_databases
                ;;
            2)
                backup_full_cluster
                ;;
            3)
                read -p "Nombre de la base de datos: " db_name
                backup_database "$db_name"
                ;;
            4)
                backup_all_databases
                backup_full_cluster
                ;;
            5)
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
            --all|-a)
                backup_all_databases
                ;;
            --cluster|-c)
                backup_full_cluster
                ;;
            --database|-d)
                if [ -z "$2" ]; then
                    echo "Error: Especifica el nombre de la base de datos"
                    echo "Uso: $0 --database nombre_db"
                    exit 1
                fi
                backup_database "$2"
                ;;
            --full|-f)
                backup_all_databases
                backup_full_cluster
                ;;
            --help|-h)
                echo "Uso: $0 [OPCIÓN] [ARGUMENTOS]"
                echo ""
                echo "Opciones:"
                echo "  -a, --all           Backup de todas las bases de datos"
                echo "  -c, --cluster       Backup completo del cluster"
                echo "  -d, --database DB   Backup de una base de datos específica"
                echo "  -f, --full          Backup completo (todas las DBs + cluster)"
                echo "  -h, --help          Mostrar esta ayuda"
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
    
    echo "=== Backup completado ==="
    echo "Archivos guardados en: $BACKUP_DIR"
    echo "Fecha: $(date)"
}

# Ejecutar función principal con todos los argumentos
main "$@"