"""
Configuración de URLs para el proyecto MOP (Microservicio de Eventos de Tráfico).

Este archivo define el mapeo de URLs principales del proyecto, incluyendo:
- Endpoints de la API REST para gestión de eventos de tráfico
- Autenticación JWT (JSON Web Tokens)
- Documentación interactiva de la API (Swagger/ReDoc)
- Vista principal del sistema

La estructura de URLs sigue las mejores prácticas de REST API:
- /api/ - Endpoints principales de la API
- /api/login/ - Autenticación JWT
- /docs/ - Documentación Swagger
- /redoc/ - Documentación ReDoc

Para más información sobre configuración de URLs en Django:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
"""
# Importaciones base de Django
from django.contrib import admin  # Panel de administración de Django
from django.urls import path, include  # Funciones para definir rutas y incluir URLconfs
from django.conf import settings  # Configuraciones del proyecto
from django.conf.urls.static import static  # Para servir archivos estáticos en desarrollo
from django.http import JsonResponse  # Para respuestas JSON

# Importaciones para documentación automática de API con drf-spectacular
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView, SpectacularRedocView

# Importaciones para autenticación JWT con SimpleJWT
from rest_framework_simplejwt.views import (
    TokenObtainPairView,  # Vista para obtener token de acceso y refresh
    TokenRefreshView,     # Vista para renovar token de acceso
    TokenVerifyView,      # Vista para verificar validez de token
)

# Importaciones del módulo de eventos de tráfico
from microservicios_eventos.urls import api_urlpatterns  # URLs de la API de eventos
from microservicios_eventos import views as eventos_views  # Vistas del módulo de eventos

def api_info(request):
    """
    Vista que proporciona información general sobre la API del sistema MOP.
    
    Esta función retorna un JSON con metadatos importantes sobre la API, incluyendo:
    - Información básica (nombre, versión, descripción)
    - Enlaces a documentación (Swagger, ReDoc, Schema)
    - Endpoints principales disponibles
    - Listado de endpoints específicos de la API de eventos
    
    Args:
        request: Objeto HttpRequest de Django
        
    Returns:
        JsonResponse: Respuesta JSON con información de la API
        
    Example:
        GET /api/info/
        Response:
        {
            "api_name": "MOP - Microservicio de Eventos de Tráfico",
            "version": "1.0.0",
            "description": "API REST para gestión de eventos de tráfico",
            ...
        }
    """
    return JsonResponse({
        'api_name': 'MOP - Microservicio de Eventos de Tráfico',
        'version': '1.0.0',
        'description': 'API REST para gestión de eventos de tráfico',
        'documentation': {
            'swagger': '/docs/',      # Documentación interactiva Swagger UI
            'redoc': '/redoc/',       # Documentación ReDoc
            'schema': '/api/schema/', # Schema OpenAPI en formato JSON
        },
        'endpoints': {
            'api_principal': '/api/',     # Punto de entrada principal de la API
            'health': '/api/health/',     # Endpoint de verificación de salud
            'api_auth': '/api-auth/'      # Autenticación de Django REST Framework
        },
        'api_endpoints': {
            'tipos_evento': '/api/tipos-evento/',       # CRUD tipos de evento
            'niveles_gravedad': '/api/niveles-gravedad/', # CRUD niveles de gravedad
            'estados_evento': '/api/estados-evento/',   # CRUD estados de evento
            'eventos_trafico': '/api/eventos/',         # CRUD eventos de tráfico
            'rutas_afectadas': '/api/rutas-afectadas/', # CRUD rutas afectadas
        }
    })

# Configuración principal de URLs del proyecto MOP
urlpatterns = [
    # ==========================================
    # VISTA PRINCIPAL
    # ==========================================
    # Página de inicio del sistema MOP
    path('', eventos_views.home, name='home'),
    
    # ==========================================
    # PANEL DE ADMINISTRACIÓN DJANGO
    # ==========================================
    # Panel de administración web de Django
    path('admin/', admin.site.urls),
    
    # ==========================================
    # API REST - ENDPOINTS PRINCIPALES
    # ==========================================
    # Incluye todas las rutas de la API de eventos de tráfico
    # Namespace 'api' permite referenciar las URLs como 'api:nombre_url'
    path('api/', include((api_urlpatterns, 'microservicios_eventos'), namespace='api')),
    
    # Incluye todas las rutas de la API de rutas y viajes
    path('', include('microservicios_rutas_viajes.urls')),
    
    # ==========================================
    # AUTENTICACIÓN JWT (JSON WEB TOKENS)
    # ==========================================
    # Endpoint para obtener par de tokens (access + refresh)
    # POST /api/login/ con username/password -> retorna access_token y refresh_token
    path('api/login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    
    # Endpoint para renovar token de acceso usando refresh token
    # POST /api/token/refresh/ con refresh_token -> retorna nuevo access_token
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    
    # Endpoint para verificar validez de un token
    # POST /api/token/verify/ con token -> retorna estado de validez
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    
    # ==========================================
    # DOCUMENTACIÓN AUTOMÁTICA DE LA API
    # ==========================================
    # Schema OpenAPI en formato JSON - base para documentación
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    
    # Interfaz Swagger UI - documentación interactiva
    # Permite probar endpoints directamente desde el navegador
    path('docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    
    # Interfaz ReDoc - documentación alternativa más limpia
    path('redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),
    
    # ==========================================
    # AUTENTICACIÓN DJANGO REST FRAMEWORK
    # ==========================================
    # Interfaz web para login/logout de DRF (útil para navegador)
    path('api-auth/', include('rest_framework.urls')),
    
    # ==========================================
    # METADATOS Y INFORMACIÓN DE LA API
    # ==========================================
    # Endpoint que retorna información general sobre la API
    # GET /api/info/ -> metadatos, versión, endpoints disponibles
    path('api/info/', api_info, name='api_info'),
]

# ==========================================
# CONFIGURACIÓN PARA DESARROLLO
# ==========================================
# Servir archivos media (uploads, imágenes, etc.) en modo desarrollo
# En producción, esto debe manejarse por el servidor web (nginx, apache)
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
