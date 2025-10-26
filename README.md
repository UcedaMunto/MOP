# Sistema MOP - Ministerio de Obras Públicas

## 📑 Índice

1. [Contexto de la Aplicación](#contexto-de-la-aplicación)
2. [Documentación de Archivos Clave](#documentación-de-archivos-clave)
3. [Variables de Entorno](#variables-de-entorno)
4. [Instrucciones de Despliegue](#instrucciones-de-despliegue)
   - [Clonar el Repositorio](#clonar-el-repositorio)
   - [Levantar los Contenedores Docker](#levantar-los-contenedores-docker)
   - [Crear Bases de Datos](#crear-bases-de-datos)
   - [Ejecutar Migraciones](#ejecutar-migraciones)
5. [Diagrama de Arquitectura](#diagrama-de-arquitectura)
6. [Documentación de Tablas](#documentación-de-tablas)
7. [Pruebas de Funcionamiento](#pruebas-de-funcionamiento)

---

## 🏗️ Contexto de la Aplicación

El **Sistema MOP** es una plataforma integral desarrollada para el Ministerio de Obras Públicas que gestiona eventos de tráfico y rutas de transporte público. El sistema está diseñado con una arquitectura de microservicios utilizando Django REST Framework, PostgreSQL con extensiones geoespaciales (PostGIS), y Redis para caché y sesiones.

### Características Principales:

- **Gestión de Eventos de Tráfico**: Registro, seguimiento y análisis de incidentes viales
- **Sistema de Rutas de Transporte**: Administración de rutas, paradas y viajes de transporte público
- **Geolocalización Avanzada**: Integración con PostGIS para manejo de datos geoespaciales
- **API REST Completa**: Endpoints documentados con Swagger/OpenAPI
- **Arquitectura de Microservicios**: Separación de responsabilidades en módulos independientes
- **Sistema de Caché**: Redis para optimización de rendimiento
- **Containerización**: Despliegue completo con Docker Compose

### Tecnologías Utilizadas:

- **Backend**: Django 5.0 + Django REST Framework
- **Base de Datos**: PostgreSQL 16 + PostGIS 3.4
- **Caché**: Redis 7
- **Containerización**: Docker + Docker Compose
- **Geolocalización**: GeoDjango + Leaflet
- **Documentación API**: drf-spectacular (Swagger/OpenAPI)

---

## 📋 Documentación de Archivos Clave

### Estructura del Proyecto

```
MOP/
├── .env                          # Variables de entorno centralizadas
├── docker-compose.yml           # Orquestación de contenedores
├── arquitectura_mop.puml        # Diagrama PlantUML de arquitectura
├── DEPLOYMENT_GUIDE.md          # Guía detallada de despliegue
├── backups/                     # Scripts y respaldos de BD
├── DJANGO_UCEDA/               # Aplicación Django principal
│   ├── manage.py
│   ├── requirements.txt
│   ├── Dockerfile
│   ├── mop_project/           # Configuración del proyecto
│   │   ├── settings.py        # Configuraciones Django
│   │   ├── urls.py           # URLs principales
│   │   └── db_router.py      # Router de bases de datos
│   ├── microservicios_eventos/      # MS de eventos de tráfico
│   │   ├── models.py         # Modelos de eventos
│   │   ├── views.py          # Vistas API
│   │   ├── serializers.py    # Serializadores DRF
│   │   └── urls.py           # URLs del microservicio
│   └── microservicios_rutas_viajes/ # MS de rutas y viajes
│       ├── models.py         # Modelos de transporte
│       ├── views.py          # Vistas API
│       ├── serializers.py    # Serializadores DRF
│       └── urls.py           # URLs del microservicio
├── POSTGRES/                  # Configuración PostgreSQL
│   ├── Dockerfile
│   ├── conf/                 # Archivos de configuración
│   └── init/                 # Scripts de inicialización
└── REDIS/                    # Configuración Redis
    ├── Dockerfile
    └── conf/                 # Archivos de configuración
```

### Archivos Importantes

#### `docker-compose.yml`
Orquesta tres servicios principales:
- **postgres**: PostgreSQL 16 + PostGIS (172.28.0.10:5432)
- **redis**: Redis 7 para caché (172.28.0.11:6379)  
- **central**: Aplicación Django (172.28.0.12:8000)

#### `DJANGO_UCEDA/mop_project/settings.py`
Configuración principal de Django con:
- Configuración de bases de datos múltiples
- Integración con PostGIS/GeoDjango
- Configuración de caché Redis
- APIs REST con DRF
- Autenticación JWT

#### Microservicios
- **microservicios_eventos**: Gestión de eventos de tráfico
- **microservicios_rutas_viajes**: Administración de transporte público

---

## 🔧 Variables de Entorno

El archivo `.env` contiene todas las configuraciones necesarias:

### Configuración Django
```bash
DEBUG=False                           # Modo debug (True/False)
SECRET_KEY=django-insecure-ecao!...   # Clave secreta Django
ALLOWED_HOSTS=localhost,127.0.0.1,... # Hosts permitidos
```

### Base de Datos PostgreSQL
```bash
DB_ENGINE=django.db.backends.postgresql
DB_NAME=appdb                         # Nombre base de datos principal
DB_USER=admin_user                    # Usuario PostgreSQL
DB_PASSWORD=ChangeMe_SuperSeguro_2025! # Contraseña PostgreSQL
DB_HOST=172.28.0.10                   # IP contenedor PostgreSQL
DB_PORT=5432                          # Puerto PostgreSQL
```

### Redis Configuration
```bash
REDIS_HOST=172.28.0.11               # IP contenedor Redis
REDIS_PORT=6379                      # Puerto Redis
REDIS_PASSWORD=redis_mop_uceda       # Contraseña Redis
REDIS_DB=1                           # Base de datos Redis
```

### Configuración de Caché
```bash
CACHE_BACKEND=django_redis.cache.RedisCache
CACHE_LOCATION=redis://:redis_mop_uceda@172.28.0.11:6379/1
```

### Configuración Regional
```bash
TIME_ZONE=America/El_Salvador        # Zona horaria
LANGUAGE_CODE=es-es                  # Idioma por defecto
```

### CORS y Seguridad
```bash
CORS_ALLOW_ALL_ORIGINS=False         # Configuración CORS
```

---

## 🚀 Instrucciones de Despliegue

### Clonar el Repositorio

```bash
# Clonar el repositorio
git clone https://github.com/UcedaMunto/MOP.git
cd MOP

# Verificar la estructura
ls -la
```

### Levantar los Contenedores Docker

```bash
# Construir y levantar todos los servicios
docker-compose up -d --build

# Verificar que los contenedores estén corriendo
docker-compose ps

# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f central
docker-compose logs -f postgres
docker-compose logs -f redis
```

### Crear Bases de Datos

Las bases de datos se crean automáticamente mediante los scripts en `POSTGRES/init/`:

```bash
# Verificar la creación de bases de datos
docker-compose exec postgres psql -U admin_user -d appdb -c "\l"

# Conectar a la base de datos principal
docker-compose exec postgres psql -U admin_user -d appdb

# Verificar extensiones PostGIS
docker-compose exec postgres psql -U admin_user -d appdb -c "\dx"
```

**Bases de datos creadas automáticamente:**
- `appdb` - Base de datos principal
- `eventos_trafico` - Microservicio de eventos
- `rutas_viajes` - Microservicio de rutas y viajes

### Ejecutar Migraciones

```bash
# Ejecutar migraciones en el contenedor Django
docker-compose exec central python manage.py migrate

# Crear superusuario
docker-compose exec central python manage.py createsuperuser

# Cargar datos iniciales (si existen fixtures)
docker-compose exec central python manage.py loaddata initial_data.json

# Verificar migraciones aplicadas
docker-compose exec central python manage.py showmigrations
```

### Verificación del Despliegue

```bash
# Verificar que los servicios respondan
curl http://localhost:8000/
curl http://localhost:8000/admin/
curl http://localhost:8000/docs/

# Verificar conectividad a PostgreSQL
docker-compose exec postgres pg_isready -U admin_user

# Verificar Redis
docker-compose exec redis redis-cli -a redis_mop_uceda ping
```

---

## 📊 Diagrama de Arquitectura

El diagrama de arquitectura se encuentra en el archivo `arquitectura_mop.puml` y puede visualizarse con PlantUML:

### Componentes Principales:

1. **Red Docker**: `mop_net (172.28.0.0/24)` con IPs estáticas
2. **PostgreSQL 16 + PostGIS**: Base de datos principal con extensiones geoespaciales
3. **Redis 7**: Sistema de caché y gestión de sesiones
4. **Django Central**: Aplicación principal con microservicios integrados

### Visualizar el Diagrama:

```bash
# Usando PlantUML
plantuml arquitectura_mop.puml

# O usando extensiones de VS Code
# PlantUML extension para VS Code
```

---

## 🗃️ Documentación de Tablas

### Microservicio de Eventos (`microservicios_eventos`)

#### Tablas de Catálogos:
- **`tipo_evento`**: Tipos de eventos de tráfico (accidentes, obras, etc.)
- **`nivel_gravedad`**: Niveles de gravedad (bajo, medio, alto, crítico)
- **`estado_evento`**: Estados del evento (activo, resuelto, cerrado)

#### Tabla Principal:
- **`evento_trafico`**: 
  - Eventos de tráfico con geolocalización
  - Campos PostGIS: `ubicacion` (Point), `area_afectacion` (Geometry)
  - Referencias externas a otros microservicios
  - Campos de auditoría y trazabilidad

### Microservicio de Rutas y Viajes (`microservicios_rutas_viajes`)

#### Tablas Principales:
- **`empresa_transporte`**: Operadores de transporte público
- **`piloto`**: Conductores de autobuses
- **`autobus`**: Vehículos de transporte
- **`ruta`**: Rutas de transporte público
- **`ruta_geopunto`**: Puntos geográficos que definen rutas
- **`parada`**: Paradas de autobuses en las rutas
- **`viaje`**: Viajes programados y ejecutados
- **`parada_viaje`**: Control de paradas durante viajes

#### Características Especiales:
- **Geolocalización**: Coordenadas GPS para rutas y paradas
- **Relaciones Complejas**: FK entre empresas, pilotos, autobuses y rutas
- **Control Temporal**: Horarios, frecuencias y seguimiento de viajes
- **Estados Dinámicos**: Control de estados de viajes en tiempo real

### Índices y Optimizaciones:
- Índices en campos de búsqueda frecuente
- Índices geoespaciales para consultas de ubicación
- Índices compuestos para consultas complejas

---

## 🧪 Pruebas de Funcionamiento

### URLs de Acceso

#### Documentación API:
- **Swagger UI**: http://localhost:8000/docs/
- **ReDoc**: http://localhost:8000/redoc/
- **Schema OpenAPI**: http://localhost:8000/api/schema/
- **Django Admin**: http://localhost:8000/admin/

#### APIs de Microservicios:
- **Eventos**: http://localhost:8000/eventos/api/
- **Rutas y Viajes**: http://localhost:8000/rutas/api/

### Pruebas Básicas con cURL

#### Verificar APIs de Eventos:
```bash
# Listar tipos de evento
curl -X GET "http://localhost:8000/eventos/api/tipos-evento/"

# Listar eventos de tráfico
curl -X GET "http://localhost:8000/eventos/api/eventos-trafico/"

# Crear un evento (requiere autenticación)
curl -X POST "http://localhost:8000/eventos/api/eventos-trafico/" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Accidente en Autopista",
    "descripcion": "Colisión múltiple",
    "tipo": 1,
    "gravedad": 1,
    "estado": 1,
    "latitud": 13.7026,
    "longitud": -89.2243,
    "radio_metros": 500
  }'
```

#### Verificar APIs de Rutas:
```bash
# Listar empresas de transporte
curl -X GET "http://localhost:8000/rutas/api/empresas/"

# Listar rutas
curl -X GET "http://localhost:8000/rutas/api/rutas/"

# Listar viajes
curl -X GET "http://localhost:8000/rutas/api/viajes/"
```

### Pruebas de Conectividad

#### PostgreSQL:
```bash
# Verificar conexión a base de datos
docker-compose exec central python manage.py dbshell

# Ejecutar query de prueba
docker-compose exec postgres psql -U admin_user -d appdb -c "SELECT version();"
```

#### Redis:
```bash
# Verificar caché Redis
docker-compose exec central python manage.py shell
>>> from django.core.cache import cache
>>> cache.set('test_key', 'test_value', 300)
>>> cache.get('test_key')
```

### Pruebas de Geolocalización

```bash
# Consultar eventos por ubicación (cerca de San Salvador)
curl -X GET "http://localhost:8000/eventos/api/eventos-trafico/?lat=13.7026&lng=-89.2243&radius=10000"

# Consultar rutas en área específica
curl -X GET "http://localhost:8000/rutas/api/rutas/?bbox=-89.3,-89.1,13.6,13.8"
```

### Monitoreo y Logs

#### Ver logs de aplicación:
```bash
# Logs de Django
docker-compose logs -f central

# Logs de base de datos
docker-compose logs -f postgres

# Logs de Redis
docker-compose logs -f redis
```

#### Verificar salud de servicios:
```bash
# Health checks
docker-compose ps

# Verificar uso de recursos
docker stats
```

### Pruebas Automatizadas

```bash
# Ejecutar tests unitarios
docker-compose exec central python manage.py test

# Ejecutar tests específicos
docker-compose exec central python manage.py test microservicios_eventos
docker-compose exec central python manage.py test microservicios_rutas_viajes

# Coverage report
docker-compose exec central coverage run --source='.' manage.py test
docker-compose exec central coverage report
```

---

## 📞 Soporte y Documentación Adicional

- **API Documentation**: Ver `DJANGO_UCEDA/API_DOCUMENTATION.md`
- **Testing Guide**: Ver `DJANGO_UCEDA/TESTING_ENDPOINTS.md`
- **Deployment Guide**: Ver `DEPLOYMENT_GUIDE.md`
- **Backup Scripts**: Ver directorio `backups/`

---

**Desarrollado para el Ministerio de Obras Públicas - El Salvador**  
*Sistema de Gestión de Eventos de Tráfico y Transporte Público*
