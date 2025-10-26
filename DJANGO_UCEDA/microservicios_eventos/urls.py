from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

app_name = 'microservicios_eventos'

# Router para las APIs REST
router = DefaultRouter()
router.register(r'tipos-evento', views.TipoEventoViewSet, basename='tipoeventos')
router.register(r'niveles-gravedad', views.NivelGravedadViewSet, basename='nivelogravedad')
router.register(r'estados-evento', views.EstadoEventoViewSet, basename='estadoevento')
router.register(r'eventos', views.EventoTraficoViewSet, basename='eventos')
router.register(r'rutas-afectadas', views.EventoRutaAfectadaViewSet, basename='rutasafectadas')

# URLs para API directa
api_urlpatterns = [
    # API REST endpoints directos (sin prefijo 'api/')
    path('', include(router.urls)),
    
    # Endpoint de salud (fuera del router)
    path('health/', views.health_check, name='health_check'),
    
    # Endpoint de registro de usuarios
    path('register/', views.register_user, name='register_user'),
]

# URLs por defecto
urlpatterns = api_urlpatterns