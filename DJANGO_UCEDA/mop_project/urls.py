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
from microservicios_eventos.urls import api_urlpatterns
from microservicios_eventos import views as eventos_views

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
            'api_principal': '/api/',
            'health': '/api/health/',
            'api_auth': '/api-auth/'
        },
        'api_endpoints': {
            'tipos_evento': '/api/tipos-evento/',
            'niveles_gravedad': '/api/niveles-gravedad/',
            'estados_evento': '/api/estados-evento/',
            'eventos_trafico': '/api/eventos/',
            'rutas_afectadas': '/api/rutas-afectadas/',
        }
    })

urlpatterns = [
    # Home principal
    path('', eventos_views.home, name='home'),
    
    # API de eventos
    path('api/', include((api_urlpatterns, 'microservicios_eventos'), namespace='api')),
    
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
