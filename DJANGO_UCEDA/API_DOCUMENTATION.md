# API REST - Microservicio de Eventos de Tráfico

## Descripción
API REST completa para el mantenimiento de eventos de tráfico usando Django REST Framework.

## Base URL
```
http://localhost:8000/eventos/api/
```

## Autenticación
- **Session Authentication**: Para usuarios web
- **Basic Authentication**: Para aplicaciones
- La mayoría de endpoints permiten lectura sin autenticación
- Las operaciones de escritura requieren autenticación

## Endpoints Principales

### 1. Tipos de Evento
**Base URL**: `/api/tipos-evento/`

#### Operaciones CRUD
- `GET /api/tipos-evento/` - Lista todos los tipos de evento activos
- `POST /api/tipos-evento/` - Crea un nuevo tipo de evento (requiere staff)
- `GET /api/tipos-evento/{id}/` - Obtiene un tipo de evento específico
- `PUT /api/tipos-evento/{id}/` - Actualiza completamente (requiere staff)
- `PATCH /api/tipos-evento/{id}/` - Actualiza parcialmente (requiere staff)
- `DELETE /api/tipos-evento/{id}/` - Elimina (requiere staff)

#### Endpoints especiales
- `GET /api/tipos-evento/inactivos/` - Lista tipos de evento inactivos
- `POST /api/tipos-evento/{id}/activar/` - Activa un tipo de evento
- `POST /api/tipos-evento/{id}/desactivar/` - Desactiva un tipo de evento

#### Filtros disponibles
- `?codigo=ACCIDENTE` - Filtrar por código
- `?nombre=accidente` - Filtrar por nombre (parcial)
- `?activo=true` - Filtrar por estado activo
- `?creado_desde=2024-01-01` - Eventos creados desde fecha
- `?search=tráfico` - Búsqueda en código, nombre y descripción
- `?ordering=codigo` - Ordenar por campo

### 2. Niveles de Gravedad
**Base URL**: `/api/niveles-gravedad/`

#### Operaciones CRUD
- `GET /api/niveles-gravedad/` - Lista todos los niveles
- `POST /api/niveles-gravedad/` - Crea nuevo nivel (requiere staff)
- `GET /api/niveles-gravedad/{id}/` - Obtiene nivel específico
- `PUT/PATCH /api/niveles-gravedad/{id}/` - Actualiza (requiere staff)
- `DELETE /api/niveles-gravedad/{id}/` - Elimina (requiere staff)

#### Filtros disponibles
- `?codigo=ALTA` - Filtrar por código
- `?nombre=alta` - Filtrar por nombre
- `?orden_min=1` - Niveles con orden mínimo
- `?orden_max=5` - Niveles con orden máximo
- `?ordering=orden` - Ordenar por orden de gravedad

### 3. Estados de Evento
**Base URL**: `/api/estados-evento/`

#### Operaciones CRUD
- `GET /api/estados-evento/` - Lista todos los estados
- `POST /api/estados-evento/` - Crea nuevo estado (requiere staff)
- `GET /api/estados-evento/{id}/` - Obtiene estado específico
- `PUT/PATCH /api/estados-evento/{id}/` - Actualiza (requiere staff)
- `DELETE /api/estados-evento/{id}/` - Elimina (requiere staff)

#### Filtros disponibles
- `?codigo=ACTIVO` - Filtrar por código
- `?nombre=activo` - Filtrar por nombre
- `?search=resuelto` - Búsqueda en código y nombre

### 4. Eventos de Tráfico (Principal)
**Base URL**: `/api/eventos/`

#### Operaciones CRUD
- `GET /api/eventos/` - Lista eventos (con paginación)
- `POST /api/eventos/` - Crea nuevo evento (requiere auth)
- `GET /api/eventos/{id}/` - Obtiene evento específico con detalles completos
- `PUT /api/eventos/{id}/` - Actualiza completamente (requiere auth)
- `PATCH /api/eventos/{id}/` - Actualiza parcialmente (requiere auth)
- `DELETE /api/eventos/{id}/` - Eliminación lógica (requiere auth/staff)

#### Endpoints especiales
- `GET /api/eventos/activos/` - Solo eventos vigentes (no expirados)
- `GET /api/eventos/estadisticas/` - Estadísticas de eventos
- `GET /api/eventos/por_ubicacion/?lat=19.4326&lng=-99.1332&radio=1000` - Eventos cerca de ubicación
- `POST /api/eventos/{id}/marcar_resuelto/` - Marca evento como resuelto

#### Filtros avanzados
```bash
# Por tipo y estado
?tipo_codigo=ACCIDENTE&estado_codigo=ACTIVO

# Por fechas
?fecha_ocurrencia_desde=2024-01-01T00:00:00Z
?fecha_ocurrencia_hasta=2024-12-31T23:59:59Z

# Por ubicación
?latitud_min=19.0&latitud_max=20.0&longitud_min=-99.5&longitud_max=-99.0

# Por gravedad
?gravedad_codigo=ALTA&gravedad_orden_min=3

# Por referencias externas
?viaje_id_externo=12345&vehiculo_id_externo=VEH001

# Filtros especiales
?vigentes=true           # Solo eventos vigentes
?hoy=true               # Solo eventos de hoy
?esta_semana=true       # Solo eventos de esta semana
?este_mes=true          # Solo eventos de este mes
?cerca_de=19.4326,-99.1332,1000  # Eventos cerca de lat,lng,radio_metros

# Búsqueda
?search=accidente       # Busca en título, descripción, tipo y estado

# Ordenamiento
?ordering=-fecha_ocurrencia    # Más recientes primero
?ordering=gravedad__orden      # Por gravedad
?ordering=tipo__nombre         # Por tipo alfabético
```

#### Paginación
```bash
?page=1&page_size=20
```

#### Ejemplo de respuesta
```json
{
  "pagination": {
    "count": 150,
    "next": "http://localhost:8000/eventos/api/eventos/?page=2",
    "previous": null,
    "page_size": 20,
    "current_page": 1,
    "total_pages": 8
  },
  "results": [
    {
      "id": 1,
      "titulo": "Accidente vehicular Av. Reforma",
      "tipo_nombre": "Accidente",
      "gravedad_nombre": "Alta",
      "estado_nombre": "Activo",
      "latitud": "19.432608",
      "longitud": "-99.133209",
      "fecha_ocurrencia": "2024-10-25 10:30:00",
      "expira_en": null,
      "esta_vigente": true,
      "creado_en": "2024-10-25 10:35:00"
    }
  ]
}
```

### 5. Rutas Afectadas
**Base URL**: `/api/rutas-afectadas/`

#### Operaciones CRUD
- `GET /api/rutas-afectadas/` - Lista rutas afectadas
- `POST /api/rutas-afectadas/` - Asocia ruta a evento (requiere auth)
- `GET /api/rutas-afectadas/{id}/` - Obtiene ruta afectada específica
- `PUT/PATCH /api/rutas-afectadas/{id}/` - Actualiza (requiere auth)
- `DELETE /api/rutas-afectadas/{id}/` - Elimina asociación (requiere auth)

#### Filtros disponibles
```bash
?evento=1                    # Rutas afectadas por evento específico
?sistema_origen=SIG          # Por sistema origen
?ruta_codigo=L1              # Por código de ruta
?relevancia=PRINCIPAL        # Por relevancia (PRINCIPAL/SECUNDARIA)
```

## Formato de datos

### Crear evento
```json
{
  "titulo": "Accidente en Av. Insurgentes",
  "descripcion": "Choque múltiple bloquea dos carriles",
  "tipo": 1,
  "gravedad": 2,
  "estado": 1,
  "latitud": "19.432608",
  "longitud": "-99.133209",
  "radio_metros": 500,
  "fecha_ocurrencia": "2024-10-25T10:30:00Z",
  "expira_en": "2024-10-25T18:00:00Z",
  "viaje_id_externo": "V12345",
  "vehiculo_id_externo": "VEH001"
}
```

### Crear tipo de evento
```json
{
  "codigo": "OBRA",
  "nombre": "Obra en vía pública",
  "descripcion": "Trabajos de construcción o mantenimiento",
  "activo": true
}
```

## Códigos de respuesta HTTP
- `200 OK` - Operación exitosa
- `201 Created` - Recurso creado exitosamente
- `204 No Content` - Eliminación exitosa
- `400 Bad Request` - Datos inválidos
- `401 Unauthorized` - No autenticado
- `403 Forbidden` - Sin permisos
- `404 Not Found` - Recurso no encontrado
- `500 Internal Server Error` - Error del servidor

## Permisos
- **Lectura**: Disponible para todos
- **Catálogos** (tipos, niveles, estados): Solo staff puede modificar
- **Eventos**: Usuarios autenticados pueden crear/modificar
- **Eliminar eventos**: Solo creador o staff
- **Rutas afectadas**: Usuarios autenticados pueden gestionar

## Endpoints adicionales
- `GET /eventos/health/` - Estado de salud del servicio
- `GET /` - Información general de la API
- `GET /api-auth/` - Login/logout para navegador web

## Ejemplos de uso

### Obtener eventos activos cerca de una ubicación
```bash
curl "http://localhost:8000/eventos/api/eventos/activos/?cerca_de=19.4326,-99.1332,1000"
```

### Crear un nuevo evento
```bash
curl -X POST http://localhost:8000/eventos/api/eventos/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Basic dXNlcjpwYXNz" \
  -d '{
    "titulo": "Manifestación Zócalo",
    "descripcion": "Cierre temporal por evento cívico",
    "tipo": 1,
    "gravedad": 2,
    "estado": 1,
    "latitud": "19.4326",
    "longitud": "-99.1332",
    "radio_metros": 200
  }'
```

### Filtrar eventos por fecha y tipo
```bash
curl "http://localhost:8000/eventos/api/eventos/?tipo_codigo=ACCIDENTE&fecha_ocurrencia_desde=2024-10-01&vigentes=true"
```

Esta API REST proporciona un sistema completo para la gestión de eventos de tráfico con capacidades avanzadas de filtrado, búsqueda, paginación y permisos granulares.