#!/bin/bash

# =============================================================================
# SCRIPT DE BACKUP MEJORADO PARA POSTGRESQL - PROYECTO MOP
# =============================================================================
# Este script crea backups de PostgreSQL usando las credenciales del .env
# y genera backups con nombres descriptivos para usarlos como semilla del proyecto
# =============================================================================

set -euo pipefail  # Salir en caso de error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para logging
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Función para cargar variables de .env
load_env() {
    local env_file="$1"
    if [ ! -f "$env_file" ]; then
        log_error "Archivo .env no encontrado: $env_file"
        exit 1
    fi
    
    log "Cargando configuración desde: $env_file"
    
    # Cargar variables del .env (ignorando comentarios y líneas vacías)
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Ignorar comentarios y líneas vacías
        if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "${line// }" ]]; then
            continue
        fi
        
        # Exportar variable si tiene formato correcto
        if [[ "$line" =~ ^[[:space:]]*([a-zA-Z_][a-zA-Z0-9_]*)=(.*)$ ]]; then
            export "${BASH_REMATCH[1]}"="${BASH_REMATCH[2]}"
        fi
    done < "$env_file"
}

# Función para verificar que el contenedor esté ejecutándose
check_container() {
    local container_name="$1"
    if ! docker ps --format "table {{.Names}}" | grep -q "^${container_name}$"; then
        log_error "El contenedor '$container_name' no está ejecutándose"
        log "Inicia los servicios con: docker-compose up -d"
        exit 1
    fi
    log_success "Contenedor '$container_name' está ejecutándose"
}

# Función para crear backup de una base de datos específica
backup_database() {
    local db_name="$1"
    local backup_type="${2:-seed}"  # seed, full, or specific
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    # Crear nombre del archivo basado en el tipo
    local filename_prefix
    case "$backup_type" in
        "seed")
            filename_prefix="${db_name}_seed"
            ;;
        "full")
            filename_prefix="${db_name}_full_backup_${timestamp}"
            ;;
        *)
            filename_prefix="${db_name}_backup_${timestamp}"
            ;;
    esac
    
    local backup_file_sql="$BACKUP_DIR/${filename_prefix}.sql"
    local backup_file_custom="$BACKUP_DIR/${filename_prefix}.dump"
    
    log "Creando backup de la base de datos: $db_name"
    log "Archivo SQL: $(basename "$backup_file_sql")"
    log "Archivo CUSTOM: $(basename "$backup_file_custom")"
    
    # Backup en formato SQL plano (más legible, para Git)
    if docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dump -U "$POSTGRES_USER" -h localhost -p 5432 \
        --verbose --clean --no-owner --no-privileges \
        --format=plain --encoding=UTF8 \
        --no-tablespaces --no-unlogged-table-data \
        "$db_name" > "$backup_file_sql" 2>/dev/null; then
        
        log_success "Backup SQL completado: $(basename "$backup_file_sql")"
        log "Tamaño: $(du -h "$backup_file_sql" | cut -f1)"
    else
        log_error "Error al crear backup SQL de $db_name"
        return 1
    fi
    
    # Backup en formato custom (más compacto, para restauración)
    if docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dump -U "$POSTGRES_USER" -h localhost -p 5432 \
        --verbose --clean --no-owner --no-privileges \
        --format=custom --compress=9 \
        --no-tablespaces --no-unlogged-table-data \
        "$db_name" > "$backup_file_custom" 2>/dev/null; then
        
        log_success "Backup CUSTOM completado: $(basename "$backup_file_custom")"
        log "Tamaño: $(du -h "$backup_file_custom" | cut -f1)"
    else
        log_error "Error al crear backup CUSTOM de $db_name"
        return 1
    fi
    
    # Crear archivo de metadata
    create_metadata_file "$db_name" "$backup_type" "$timestamp"
    
    echo ""
    return 0
}

# Función para crear archivo de metadata
create_metadata_file() {
    local db_name="$1"
    local backup_type="$2"
    local timestamp="$3"
    
    local metadata_file="$BACKUP_DIR/${db_name}_${backup_type}_metadata.txt"
    
    cat > "$metadata_file" << EOF
# METADATA DEL BACKUP - PROYECTO MOP
# =================================

Base de datos: $db_name
Tipo de backup: $backup_type
Fecha de creación: $(date +'%Y-%m-%d %H:%M:%S')
Timestamp: $timestamp
Usuario PostgreSQL: $POSTGRES_USER
Host: $DB_HOST
Puerto: $DB_PORT
Contenedor: $CONTAINER_NAME

# Archivos generados:
- ${db_name}_${backup_type}.sql (formato SQL plano)
- ${db_name}_${backup_type}.dump (formato custom comprimido)

# Para restaurar:
# Formato SQL:
docker exec -i $CONTAINER_NAME psql -U $POSTGRES_USER -d $db_name < ${db_name}_${backup_type}.sql

# Formato CUSTOM:
docker exec -i $CONTAINER_NAME pg_restore -U $POSTGRES_USER -d $db_name --clean --if-exists ${db_name}_${backup_type}.dump

# Información del sistema:
Versión de PostgreSQL: $(docker exec "$CONTAINER_NAME" postgres --version 2>/dev/null || echo "No disponible")
Sistema operativo: $(uname -a)
Proyecto: MOP (Ministerio de Obras Públicas)
EOF

    log "Metadata creada: $(basename "$metadata_file")"
}

# Función para obtener lista de bases de datos
get_databases() {
    log "Obteniendo lista de bases de datos..."
    
    local databases
    databases=$(docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        psql -U "$POSTGRES_USER" -d appdb -h localhost -p 5432 -t -c \
        "SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('postgres', 'template0', 'template1');" 2>/dev/null)
    
    # Limpiar la salida y filtrar líneas vacías
    databases=$(echo "$databases" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | grep -v '^$')
    
    if [ -z "$databases" ]; then
        log_error "No se encontraron bases de datos para respaldar"
        return 1
    fi
    
    log "Bases de datos encontradas:"
    echo "$databases" | sed 's/^/  - /'
    echo ""
    
    echo "$databases"
}

# Función para crear backup completo del cluster (usuarios, roles, etc.)
backup_cluster() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/cluster_complete_seed.sql"
    
    log "Creando backup completo del cluster PostgreSQL..."
    
    if docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
        pg_dumpall -U "$POSTGRES_USER" -h localhost -p 5432 \
        --verbose --clean > "$backup_file" 2>/dev/null; then
        
        log_success "Backup completo del cluster completado: $(basename "$backup_file")"
        log "Tamaño: $(du -h "$backup_file" | cut -f1)"
        
        # Crear metadata para el cluster
        cat > "$BACKUP_DIR/cluster_complete_seed_metadata.txt" << EOF
# METADATA DEL BACKUP COMPLETO - PROYECTO MOP
# ==========================================

Tipo: Backup completo del cluster PostgreSQL
Fecha de creación: $(date +'%Y-%m-%d %H:%M:%S')
Timestamp: $timestamp
Incluye: Todas las bases de datos, usuarios, roles, permisos
Contenedor: $CONTAINER_NAME

# Para restaurar completamente:
docker exec -i $CONTAINER_NAME psql -U $POSTGRES_USER -h localhost < cluster_complete_seed.sql

# Información del sistema:
Versión de PostgreSQL: $(docker exec "$CONTAINER_NAME" postgres --version 2>/dev/null || echo "No disponible")
Proyecto: MOP (Ministerio de Obras Públicas)
EOF
        
    else
        log_error "Error al crear backup completo del cluster"
        return 1
    fi
    echo ""
}

# Función principal
main() {
    echo ""
    log "=== BACKUP POSTGRESQL - PROYECTO MOP ==="
    echo ""
    
    # Cargar configuración del .env principal
    load_env ".env"
    
    # También cargar configuración específica de PostgreSQL si existe
    if [ -f "POSTGRES/.env" ]; then
        load_env "POSTGRES/.env"
    fi
    
    # Configuración
    CONTAINER_NAME="${CONTAINER_NAME:-postgres_17}"
    BACKUP_DIR="${BACKUP_DIR:-./backups/postgres}"
    
    # Crear directorio de backups si no existe
    mkdir -p "$BACKUP_DIR"
    log "Directorio de backup: $BACKUP_DIR"
    
    # Verificar contenedor
    check_container "$CONTAINER_NAME"
    
    # Procesar argumentos
    case "${1:-seed}" in
        "seed"|"--seed")
            log "=== CREANDO BACKUP SEMILLA PARA EL PROYECTO ==="
            echo ""
            
            # Obtener bases de datos
            log "Obteniendo lista de bases de datos..."
            
            local database_list
            database_list=$(docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$CONTAINER_NAME" \
                psql -U "$POSTGRES_USER" -d appdb -h localhost -p 5432 -t -c \
                "SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('postgres', 'template0', 'template1');" 2>/dev/null)
            
            # Limpiar la salida y filtrar líneas vacías
            database_list=$(echo "$database_list" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | grep -v '^$')
            
            if [ -z "$database_list" ]; then
                log_error "No se encontraron bases de datos para respaldar"
                exit 1
            fi
            
            log "Bases de datos encontradas:"
            echo "$database_list" | sed 's/^/  - /'
            echo ""
            
            # Hacer backup de cada base de datos como semilla
            while IFS= read -r db; do
                if [ ! -z "$db" ]; then
                    backup_database "$db" "seed"
                fi
            done <<< "$database_list"
            
            # Hacer backup completo del cluster como semilla
            backup_cluster
            
            log_success "=== BACKUP SEMILLA COMPLETADO ==="
            ;;
            
        "full"|"--full")
            log "=== CREANDO BACKUP COMPLETO ==="
            echo ""
            
            databases=$(get_databases)
            
            for db in $databases; do
                db=$(echo "$db" | xargs)
                if [ ! -z "$db" ]; then
                    backup_database "$db" "full"
                fi
            done
            
            backup_cluster
            
            log_success "=== BACKUP COMPLETO FINALIZADO ==="
            ;;
            
        "--database"|"-d")
            if [ -z "${2:-}" ]; then
                log_error "Especifica el nombre de la base de datos"
                echo "Uso: $0 --database nombre_db"
                exit 1
            fi
            backup_database "$2" "specific"
            ;;
            
        "--help"|"-h")
            echo "BACKUP POSTGRESQL - PROYECTO MOP"
            echo ""
            echo "Uso: $0 [OPCIÓN] [ARGUMENTOS]"
            echo ""
            echo "Opciones:"
            echo "  seed, --seed        Crear backup semilla para el proyecto (por defecto)"
            echo "  full, --full        Crear backup completo con timestamp"
            echo "  -d, --database DB   Backup de una base de datos específica"
            echo "  -h, --help          Mostrar esta ayuda"
            echo ""
            echo "El backup semilla es ideal para:"
            echo "  - Inicialización del proyecto"
            echo "  - Control de versiones (Git)"
            echo "  - Despliegue en nuevos entornos"
            echo ""
            exit 0
            ;;
            
        *)
            log_error "Opción desconocida: $1"
            echo "Usa $0 --help para ver las opciones disponibles"
            exit 1
            ;;
    esac
    
    echo ""
    log "=== RESUMEN ==="
    log "Archivos creados en: $BACKUP_DIR"
    log "Total de archivos: $(find "$BACKUP_DIR" -type f | wc -l)"
    log "Espacio utilizado: $(du -sh "$BACKUP_DIR" | cut -f1)"
    log "Fecha: $(date +'%Y-%m-%d %H:%M:%S')"
    echo ""
}

# Ejecutar función principal con todos los argumentos
main "$@"