"""
URL configuration for mop_project project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.http import JsonResponse
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView, SpectacularRedocView
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

def api_info(request):
    """Información general de la API"""
    return JsonResponse({
        'api_name': 'MOP - Microservicio de Eventos de Tráfico',
        'version': '1.0.0',
        'description': 'API REST para gestión de eventos de tráfico',
        'documentation': {
            'swagger': '/docs/',
            'redoc': '/redoc/',
            'schema': '/api/schema/',
        },
        'endpoints': {
            'eventos': '/eventos/api/',
            'admin': '/admin/',
            'health': '/eventos/health/',
            'api_auth': '/api-auth/'
        },
        'test_endpoints': {
            'tipos_evento': '/eventos/api/tipos-evento/',
            'niveles_gravedad': '/eventos/api/niveles-gravedad/',
            'estados_evento': '/eventos/api/estados-evento/',
            'eventos_trafico': '/eventos/api/eventos/',
            'rutas_afectadas': '/eventos/api/rutas-afectadas/',
        }
    })

urlpatterns = [
    # Admin
    path('admin/', admin.site.urls),
    
    # Home principal
    path('', include(('microservicios_eventos.urls', 'microservicios_eventos'), namespace='home')),
    
    # API de eventos 
    path('eventos/', include(('microservicios_eventos.urls', 'microservicios_eventos'), namespace='eventos')),
    
    # JWT Authentication endpoints
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    
    # Documentación de la API
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    path('redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),
    
    # Autenticación de DRF
    path('api-auth/', include('rest_framework.urls')),
    
    # Información general de la API
    path('api/info/', api_info, name='api_info'),
]

# Servir archivos media en desarrollo
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
