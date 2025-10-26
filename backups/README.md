# BACKUPS - PROYECTO MOP

Este directorio contiene los backups de base de datos del proyecto MOP (Ministerio de Obras Públicas).

## 📋 Estructura de Backups

### Backups Semilla (Seed Backups)
Los backups semilla están incluidos en Git y son esenciales para la inicialización del proyecto:

```
backups/postgres/
├── appdb_seed.sql                    # Base de datos principal (formato SQL)
├── appdb_seed.dump                   # Base de datos principal (formato custom)
├── appdb_seed_metadata.txt           # Metadata del backup de appdb
├── eventos_trafico_seed.sql          # Base de datos de eventos de tráfico
├── eventos_trafico_seed.dump         # Base de datos de eventos de tráfico (custom)
├── eventos_trafico_seed_metadata.txt # Metadata del backup de eventos
├── rutas_viajes_seed.sql             # Base de datos de rutas y viajes
├── rutas_viajes_seed.dump            # Base de datos de rutas y viajes (custom)
├── rutas_viajes_seed_metadata.txt    # Metadata del backup de rutas
├── cluster_complete_seed.sql         # Backup completo del cluster PostgreSQL
└── cluster_complete_seed_metadata.txt # Metadata del cluster completo
```

### Backups Automáticos (Excluidos de Git)
Los backups con timestamps son generados automáticamente y NO se incluyen en Git:
- `*_backup_YYYYMMDD_HHMMSS.sql`
- `*_backup_YYYYMMDD_HHMMSS.dump`
- `full_backup_*.sql`

## 🚀 Uso de Backups

### Para Desarrolladores Nuevos

1. **Clonar el repositorio**:
   ```bash
   git clone <repository_url>
   cd MOP
   ```

2. **Levantar los servicios**:
   ```bash
   docker-compose up -d
   ```

3. **Restaurar los backups semilla**:
   ```bash
   # Restaurar todas las bases de datos desde el cluster completo
   docker exec -i postgres_17 psql -U admin_user -h localhost < backups/postgres/cluster_complete_seed.sql
   
   # O restaurar base por base (alternativo):
   docker exec -i postgres_17 psql -U admin_user -d appdb < backups/postgres/appdb_seed.sql
   docker exec -i postgres_17 psql -U admin_user -d eventos_trafico < backups/postgres/eventos_trafico_seed.sql
   docker exec -i postgres_17 psql -U admin_user -d rutas_viajes < backups/postgres/rutas_viajes_seed.sql
   ```

### Para Crear Nuevos Backups

```bash
# Crear backup semilla (para Git)
./create_seed_backup.sh seed

# Crear backup completo con timestamp
./create_seed_backup.sh full

# Crear backup de una base específica
./create_seed_backup.sh --database eventos_trafico
```

## 🔧 Scripts de Backup

### `create_seed_backup.sh`
Script mejorado que:
- ✅ Usa credenciales del `.env`
- ✅ Genera backups con nombres consistentes
- ✅ Crea metadata descriptiva
- ✅ Soporta múltiples formatos (SQL y Custom)
- ✅ Logging detallado con colores
- ✅ Validaciones de seguridad

### Backups Antiguos
- `backup_postgres.sh` - Script original (mantener como referencia)
- `quick_backup.sh` - Script rápido para backups temporales

## 📊 Información de las Bases de Datos

### `appdb`
- **Propósito**: Base de datos principal del sistema
- **Contenido**: Configuraciones, usuarios, datos generales
- **Tamaño aprox**: ~40KB

### `eventos_trafico`
- **Propósito**: Gestión de eventos de tráfico en tiempo real
- **Contenido**: Eventos, tipos, estados, niveles de gravedad
- **Tamaño aprox**: ~56KB

### `rutas_viajes`
- **Propósito**: Gestión de rutas y planificación de viajes
- **Contenido**: Rutas, waypoints, información geográfica
- **Tamaño aprox**: ~44KB

## 🔐 Seguridad

- ❌ Los archivos `.env` NO están en Git (credenciales sensibles)
- ✅ Los backups semilla SÍ están en Git (datos de inicialización)
- ❌ Los backups con timestamp NO están en Git (demasiado grandes)

## 📝 Notas Importantes

1. **Credenciales**: Asegúrate de tener el archivo `.env` correcto antes de ejecutar backups
2. **Docker**: Los contenedores deben estar ejecutándose para crear/restaurar backups
3. **Espacio**: Los backups semilla ocupan aproximadamente 516KB en total
4. **Formatos**: 
   - `.sql` - Formato plano, legible, mejor para Git
   - `.dump` - Formato custom comprimido, mejor para restauración rápida

## 🆘 Troubleshooting

### Error: "Contenedor no está ejecutándose"
```bash
docker-compose up -d
docker ps  # Verificar que postgres_17 esté UP
```

### Error: "Base de datos no existe"
```bash
# Verificar bases de datos existentes
docker exec -e PGPASSWORD="tu_password" postgres_17 psql -U admin_user -d appdb -c "\l"
```

### Error: "Permiso denegado"
```bash
chmod +x create_seed_backup.sh
```

---

**Proyecto**: MOP (Ministerio de Obras Públicas)  
**Fecha de creación**: 2025-10-26  
**Versión**: 1.0.0