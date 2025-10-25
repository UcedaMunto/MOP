# 🚀 RUTAS DE PRUEBA - API de Eventos de Tráfico

## 📋 URLs de Documentación

### Documentación Interactiva
- **Swagger UI**: http://localhost:8000/docs/
- **ReDoc**: http://localhost:8000/redoc/
- **Schema OpenAPI**: http://localhost:8000/api/schema/
- **Información General**: http://localhost:8000/

## 🔗 Endpoints Principales para Testing

### Base URL: `http://localhost:8000/eventos/api/`

---

## 1. 📂 **CATÁLOGOS** (Requieren permisos de staff para modificar)

### Tipos de Evento
```bash
# Listar tipos activos
GET http://localhost:8000/eventos/api/tipos-evento/

# Crear nuevo tipo (requiere staff)
POST http://localhost:8000/eventos/api/tipos-evento/
Content-Type: application/json

{
  "codigo": "OBRA",
  "nombre": "Obra en vía pública",
  "descripcion": "Trabajos de construcción o mantenimiento vial",
  "activo": true
}

# Obtener tipo específico
GET http://localhost:8000/eventos/api/tipos-evento/1/

# Listar tipos inactivos
GET http://localhost:8000/eventos/api/tipos-evento/inactivos/

# Activar tipo
POST http://localhost:8000/eventos/api/tipos-evento/1/activar/

# Desactivar tipo
POST http://localhost:8000/eventos/api/tipos-evento/1/desactivar/
```

### Niveles de Gravedad
```bash
# Listar niveles
GET http://localhost:8000/eventos/api/niveles-gravedad/

# Crear nivel (requiere staff)
POST http://localhost:8000/eventos/api/niveles-gravedad/
Content-Type: application/json

{
  "codigo": "CRITICA",
  "nombre": "Crítica",
  "orden": 5
}

# Filtrar por orden
GET http://localhost:8000/eventos/api/niveles-gravedad/?orden_min=3&orden_max=5
```

### Estados de Evento
```bash
# Listar estados
GET http://localhost:8000/eventos/api/estados-evento/

# Crear estado (requiere staff)
POST http://localhost:8000/eventos/api/estados-evento/
Content-Type: application/json

{
  "codigo": "RESUELTO",
  "nombre": "Resuelto"
}
```

---

## 2. 🚦 **EVENTOS DE TRÁFICO** (Principal)

### Operaciones Básicas
```bash
# Listar eventos con paginación
GET http://localhost:8000/eventos/api/eventos/

# Crear evento (requiere autenticación)
POST http://localhost:8000/eventos/api/eventos/
Content-Type: application/json
Authorization: Basic dXNlcjpwYXNz

{
  "titulo": "Accidente vehicular Av. Insurgentes",
  "descripcion": "Choque múltiple bloquea dos carriles norte",
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

# Obtener evento específico con detalles completos
GET http://localhost:8000/eventos/api/eventos/1/

# Actualizar evento parcialmente
PATCH http://localhost:8000/eventos/api/eventos/1/
Content-Type: application/json
Authorization: Basic dXNlcjpwYXNz

{
  "estado": 2,
  "descripcion": "Accidente resuelto, tráfico normalizado"
}
```

### Endpoints Especiales
```bash
# Solo eventos activos/vigentes
GET http://localhost:8000/eventos/api/eventos/activos/

# Eventos cerca de una ubicación (CDMX Centro)
GET http://localhost:8000/eventos/api/eventos/por_ubicacion/?lat=19.4326&lng=-99.1332&radio=1000

# Estadísticas generales
GET http://localhost:8000/eventos/api/eventos/estadisticas/

# Marcar evento como resuelto
POST http://localhost:8000/eventos/api/eventos/1/marcar_resuelto/
Authorization: Basic dXNlcjpwYXNz
```

### Filtros Avanzados
```bash
# Por tipo de evento
GET http://localhost:8000/eventos/api/eventos/?tipo_codigo=ACCIDENTE

# Por estado
GET http://localhost:8000/eventos/api/eventos/?estado_codigo=ACTIVO

# Por gravedad
GET http://localhost:8000/eventos/api/eventos/?gravedad_codigo=ALTA

# Por rango de fechas
GET http://localhost:8000/eventos/api/eventos/?fecha_ocurrencia_desde=2024-10-01T00:00:00Z&fecha_ocurrencia_hasta=2024-10-31T23:59:59Z

# Por ubicación (área rectangular)
GET http://localhost:8000/eventos/api/eventos/?latitud_min=19.0&latitud_max=20.0&longitud_min=-99.5&longitud_max=-99.0

# Solo eventos vigentes
GET http://localhost:8000/eventos/api/eventos/?vigentes=true

# Eventos de hoy
GET http://localhost:8000/eventos/api/eventos/?hoy=true

# Eventos de esta semana
GET http://localhost:8000/eventos/api/eventos/?esta_semana=true

# Eventos cerca de coordenadas específicas
GET http://localhost:8000/eventos/api/eventos/?cerca_de=19.4326,-99.1332,2000

# Búsqueda de texto
GET http://localhost:8000/eventos/api/eventos/?search=accidente

# Combinación de filtros
GET http://localhost:8000/eventos/api/eventos/?tipo_codigo=ACCIDENTE&vigentes=true&gravedad_orden_min=3&search=insurgentes

# Con paginación personalizada
GET http://localhost:8000/eventos/api/eventos/?page=1&page_size=10

# Ordenamiento
GET http://localhost:8000/eventos/api/eventos/?ordering=-fecha_ocurrencia
GET http://localhost:8000/eventos/api/eventos/?ordering=gravedad__orden
GET http://localhost:8000/eventos/api/eventos/?ordering=tipo__nombre
```

---

## 3. 🛣️ **RUTAS AFECTADAS**

```bash
# Listar rutas afectadas
GET http://localhost:8000/eventos/api/rutas-afectadas/

# Crear asociación ruta-evento
POST http://localhost:8000/eventos/api/rutas-afectadas/
Content-Type: application/json
Authorization: Basic dXNlcjpwYXNz

{
  "evento": 1,
  "sistema_origen": "SIG",
  "ruta_id_externo": "L1_METRO",
  "ruta_codigo": "L1",
  "ruta_nombre": "Línea 1 Metro",
  "relevancia": "PRINCIPAL"
}

# Filtrar por evento específico
GET http://localhost:8000/eventos/api/rutas-afectadas/?evento=1

# Filtrar por sistema origen
GET http://localhost:8000/eventos/api/rutas-afectadas/?sistema_origen=SIG

# Filtrar por relevancia
GET http://localhost:8000/eventos/api/rutas-afectadas/?relevancia=PRINCIPAL
```

---

## 4. 🔧 **SISTEMA Y SALUD**

```bash
# Estado de salud del servicio
GET http://localhost:8000/eventos/health/

# Información general de la API
GET http://localhost:8000/

# Autenticación web (navegador)
GET http://localhost:8000/api-auth/login/
```

---

## 🧪 **EJEMPLOS DE TESTING COMPLETO**

### Escenario 1: Crear y gestionar un evento completo
```bash
# 1. Crear evento
POST http://localhost:8000/eventos/api/eventos/
Content-Type: application/json
Authorization: Basic dXNlcjpwYXNz

{
  "titulo": "Manifestación Zócalo CDMX",
  "descripcion": "Cierre temporal por evento cívico, desvío por calles alternas",
  "tipo": 1,
  "gravedad": 2,
  "estado": 1,
  "latitud": "19.432608",
  "longitud": "-99.133209",
  "radio_metros": 200,
  "expira_en": "2024-10-25T20:00:00Z"
}

# 2. Asociar ruta afectada
POST http://localhost:8000/eventos/api/rutas-afectadas/
Content-Type: application/json
Authorization: Basic dXNlcjpwYXNz

{
  "evento": 1,
  "sistema_origen": "TRANSPORTE",
  "ruta_id_externo": "CENTRO_01",
  "ruta_codigo": "C1",
  "ruta_nombre": "Centro Histórico - Circuito 1",
  "relevancia": "PRINCIPAL"
}

# 3. Consultar eventos cerca de esa ubicación
GET http://localhost:8000/eventos/api/eventos/por_ubicacion/?lat=19.4326&lng=-99.1332&radio=500

# 4. Marcar como resuelto
POST http://localhost:8000/eventos/api/eventos/1/marcar_resuelto/
Authorization: Basic dXNlcjpwYXNz
```

### Escenario 2: Consultas analíticas
```bash
# Estadísticas generales
GET http://localhost:8000/eventos/api/eventos/estadisticas/

# Eventos activos por tipo
GET http://localhost:8000/eventos/api/eventos/activos/?ordering=tipo__nombre

# Eventos de alta gravedad esta semana
GET http://localhost:8000/eventos/api/eventos/?esta_semana=true&gravedad_orden_min=4

# Buscar accidentes vigentes
GET http://localhost:8000/eventos/api/eventos/?search=accidente&vigentes=true
```

---

## 🔐 **AUTENTICACIÓN PARA TESTING**

### Opción 1: Basic Auth (para testing con herramientas como curl/Postman)
```bash
# Usuario: admin, Password: admin123
Authorization: Basic YWRtaW46YWRtaW4xMjM=

# Usuario: user, Password: pass
Authorization: Basic dXNlcjpwYXNz
```

### Opción 2: Session Auth (para navegador web)
1. Ir a: http://localhost:8000/api-auth/login/
2. Autenticarse con credenciales Django
3. Las APIs mantendrán la sesión automáticamente

---

## 📊 **RESPUESTAS TÍPICAS**

### Lista con paginación:
```json
{
  "pagination": {
    "count": 25,
    "next": "http://localhost:8000/eventos/api/eventos/?page=2",
    "previous": null,
    "page_size": 20,
    "current_page": 1,
    "total_pages": 2
  },
  "results": [...]
}
```

### Evento completo:
```json
{
  "id": 1,
  "titulo": "Accidente Av. Reforma",
  "descripcion": "Choque múltiple...",
  "tipo": 1,
  "tipo_info": {
    "id": 1,
    "codigo": "ACCIDENTE",
    "nombre": "Accidente vehicular"
  },
  "gravedad_info": {
    "id": 2,
    "codigo": "ALTA",
    "nombre": "Alta",
    "orden": 4
  },
  "estado_info": {
    "id": 1,
    "codigo": "ACTIVO",
    "nombre": "Activo"
  },
  "latitud": "19.432608",
  "longitud": "-99.133209",
  "radio_metros": 500,
  "fecha_ocurrencia": "2024-10-25 10:30:00",
  "esta_vigente": true,
  "dias_desde_ocurrencia": 0,
  "rutas_afectadas": [...]
}
```

### Estadísticas:
```json
{
  "total_eventos": 150,
  "eventos_vigentes": 23,
  "por_tipo": {
    "Accidente": 45,
    "Obra": 30,
    "Manifestación": 8
  },
  "por_estado": {
    "Activo": 23,
    "En Proceso": 12,
    "Resuelto": 115
  }
}
```

---

## 🚀 **COMANDOS DE INICIO RÁPIDO**

```bash
# Instalar dependencias
pip install -r requirements.txt

# Ejecutar migraciones
python manage.py migrate

# Crear superusuario
python manage.py createsuperuser

# Ejecutar servidor
python manage.py runserver

# Acceder a documentación
# Swagger: http://localhost:8000/docs/
# ReDoc: http://localhost:8000/redoc/
```

¡La API está lista para ser probada con todas estas rutas! 🎉