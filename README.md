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

## 🔗 PRUEBAS DE FUNCIONAMIENTO - Endpoints de API

### Endpoints Requeridos

Esta sección documenta los endpoints principales de la API según los requerimientos del sistema:

#### **Autenticación**

##### POST /register
**Descripción**: Público. Crea un nuevo usuario en el sistema.
**URL**: `http://localhost:8000/api/register/`
**Método**: POST
**Headers**: `Content-Type: application/json`
**Parámetros en JSON**:
```json
{
    "username": "usuario123",
    "email": "usuario@email.com",
    "password": "contraseña123",
    "password_confirm": "contraseña123"
}
```
**Respuesta exitosa (201)**:
```json
{
    "message": "Usuario registrado exitosamente",
    "user": {
        "id": 1,
        "username": "usuario123",
        "email": "usuario@email.com",
        "date_joined": "2024-01-01T12:00:00Z",
        "is_active": true
    }
}
```

##### POST /login
**Descripción**: Público. Autentica al usuario y retorna tokens JWT.
**URL**: `http://localhost:8000/api/login/`
**Método**: POST
**Headers**: `Content-Type: application/json`
**Parámetros en JSON**:
```json
{
    "username": "usuario123",
    "password": "contraseña123"
}
```
**Respuesta exitosa (200)**:
```json
{
    "access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
    "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
}
```

#### **Puntos de Georeferencia**

##### GET /points
**Descripción**: Protegido. Retorna lista de puntos de georeferencia con filtrado opcional.
**URL**: `http://localhost:8000/api/points/`
**Método**: GET
**Headers**: `Authorization: Bearer {access_token}`
**Parámetros de consulta opcionales**:
- `type`: Filtrar por tipo de evento (ej. `ACCIDENTE`, `CONSTRUCCION`)
- `lat`: Latitud para filtrar por proximidad (debe usarse con `long` y `radius`)
- `long`: Longitud para filtrar por proximidad (debe usarse con `lat` y `radius`)  
- `radius`: Radio en kilómetros para filtrar eventos cercanos

**Ejemplos de consulta**:
```bash
# Todos los puntos
GET http://localhost:8000/api/points/

# Filtrar por tipo de accidente
GET http://localhost:8000/api/points/?type=ACCIDENTE

# Puntos cercanos a una ubicación (radio de 10km)
GET http://localhost:8000/api/points/?lat=40.7128&long=-74.0060&radius=10
```

**Respuesta exitosa (200)**:
```json
{
    "count": 25,
    "results": [
        {
            "id": 1,
            "titulo": "Accidente vehicular Av. Insurgentes",
            "descripcion": "Choque múltiple bloquea dos carriles norte",
            "type": "ACC",
            "type_name": "Accidente",
            "severity": "ALTA",
            "severity_name": "Alta",
            "severity_level": 3,
            "status": "ACTIVO",
            "status_name": "Activo",
            "lat": "19.432608",
            "long": "-99.133209",
            "radius_meters": 500,
            "occurred_at": "2024-10-25T10:30:00Z",
            "reported_at": "2024-10-25T10:35:00Z",
            "expires_at": "2024-10-25T18:00:00Z",
            "created_by": "usuario123",
            "created_by_id": 1,
            "created_at": "2024-10-25T10:35:00Z"
        }
    ]
}
```

##### GET /points/:id
**Descripción**: Protegido. Retorna un punto específico por ID.
**URL**: `http://localhost:8000/api/points/{id}/`
**Método**: GET
**Headers**: `Authorization: Bearer {access_token}`
**Parámetros de ruta**: 
- `id`: ID del punto a consultar

**Respuesta exitosa (200)**: Mismo formato que un elemento individual del array anterior.

##### POST /points
**Descripción**: Protegido. Crea un nuevo punto de georeferencia. **Nota**: Actualmente implementado a través del endpoint `/api/eventos/`.
**URL**: `http://localhost:8000/api/eventos/` (usar este endpoint para crear puntos)
**Método**: POST
**Headers**: 
- `Content-Type: application/json`
- `Authorization: Bearer {access_token}`

**Parámetros en JSON**:
```json
{
    "titulo": "Nuevo evento de tráfico",
    "descripcion": "Descripción detallada del evento",
    "tipo": 1,
    "gravedad": 2,
    "estado": 1,
    "latitud": "19.432608",
    "longitud": "-99.133209", 
    "radio_metros": 500,
    "fecha_ocurrencia": "2024-10-25T10:30:00Z",
    "expira_en": "2024-10-25T18:00:00Z"
}
```

**Respuesta exitosa (201)**:
```json
{
    "id": 26,
    "titulo": "Nuevo evento de tráfico",
    "descripcion": "Descripción detallada del evento",
    "tipo": {
        "id": 1,
        "codigo": "ACC",
        "nombre": "Accidente"
    },
    "latitud": "19.432608",
    "longitud": "-99.133209",
    "creado_por_username": "usuario123",
    "creado_en": "2024-10-25T11:00:00Z"
}
```

##### PUT /points/:id
**Descripción**: Protegido. Actualiza un punto existente por ID (solo si el usuario es el creador).
**URL**: `http://localhost:8000/api/points/{id}/`
**Método**: PUT
**Headers**:
- `Content-Type: application/json`
- `Authorization: Bearer {access_token}`

**Parámetros de ruta**:
- `id`: ID del punto a actualizar

**Parámetros en JSON** (mismos campos que POST, todos opcionales):
```json
{
    "titulo": "Título actualizado",
    "descripcion": "Nueva descripción",
    "latitud": "19.433000",
    "longitud": "-99.134000"
}
```

**Respuesta exitosa (200)**: Punto actualizado en formato similar a GET.

##### DELETE /points/:id
**Descripción**: Protegido. Elimina un punto por ID (solo si el usuario es el creador).
**URL**: `http://localhost:8000/api/points/{id}/`
**Método**: DELETE
**Headers**: `Authorization: Bearer {access_token}`
**Parámetros de ruta**:
- `id`: ID del punto a eliminar

**Respuesta exitosa (204)**: Sin contenido (eliminación exitosa).

### Ejemplos de Uso con cURL

#### Flujo completo de autenticación y gestión de puntos:

```bash
# 1. Registrar nuevo usuario
curl -X POST http://localhost:8000/api/register/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123",
    "password_confirm": "password123"
  }'

# 2. Iniciar sesión y obtener token
curl -X POST http://localhost:8000/api/login/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "password123"
  }'

# 3. Listar puntos (usando el token obtenido)
curl -X GET http://localhost:8000/api/points/ \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# 4. Crear nuevo punto (vía eventos)
curl -X POST http://localhost:8000/api/eventos/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "titulo": "Accidente Carretera Panamericana",
    "descripcion": "Colisión entre dos vehículos",
    "tipo": 1,
    "gravedad": 3,
    "estado": 1,
    "latitud": "13.702600",
    "longitud": "-89.224300",
    "radio_metros": 300
  }'

# 5. Obtener punto específico
curl -X GET http://localhost:8000/api/points/1/ \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# 6. Actualizar punto
curl -X PUT http://localhost:8000/api/points/1/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "titulo": "Título actualizado",
    "descripcion": "Nueva descripción del evento"
  }'

# 7. Eliminar punto
curl -X DELETE http://localhost:8000/api/points/1/ \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

### Notas Importantes

1. **Autenticación**: Todos los endpoints protegidos requieren el token JWT obtenido del login.
2. **Creación de Puntos**: Aunque se solicita `POST /points`, actualmente está implementado como `POST /eventos` que crea eventos que funcionan como puntos de georeferencia.
3. **Permisos**: Solo el usuario creador de un punto puede modificarlo o eliminarlo.
4. **Filtros geográficos**: Los parámetros `lat`, `long` y `radius` deben usarse juntos para el filtrado por proximidad.
5. **IDs de catálogos**: Los campos `tipo`, `gravedad` y `estado` requieren IDs válidos de los catálogos correspondientes (ver `/api/tipos-evento/`, `/api/niveles-gravedad/`, `/api/estados-evento/`).

---

## 📞 Soporte y Documentación Adicional

- **API Documentation**: Ver `DJANGO_UCEDA/API_DOCUMENTATION.md`
- **Testing Guide**: Ver `DJANGO_UCEDA/TESTING_ENDPOINTS.md`
- **Deployment Guide**: Ver `DEPLOYMENT_GUIDE.md`
- **Backup Scripts**: Ver directorio `backups/`

---

**Desarrollado para el Ministerio de Obras Públicas - El Salvador**  
*Sistema de Gestión de Eventos de Tráfico y Transporte Público*
