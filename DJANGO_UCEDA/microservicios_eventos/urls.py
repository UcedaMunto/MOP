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

urlpatterns = [
    # Home page
    path('', views.home, name='home'),
    
    # API REST endpoints
    path('api/', include(router.urls)),
    
    # Endpoint de salud (fuera del router)
    path('health/', views.health_check, name='health_check'),
    
    # Documentación de la API (si se quiere agregar)
    # path('api/docs/', include('rest_framework.urls')),
]

# URLs generadas automáticamente por el router:
# GET/POST /api/tipos-evento/
# GET/PUT/PATCH/DELETE /api/tipos-evento/{id}/
# GET /api/tipos-evento/inactivos/
# POST /api/tipos-evento/{id}/activar/
# POST /api/tipos-evento/{id}/desactivar/

# GET/POST /api/niveles-gravedad/
# GET/PUT/PATCH/DELETE /api/niveles-gravedad/{id}/

# GET/POST /api/estados-evento/
# GET/PUT/PATCH/DELETE /api/estados-evento/{id}/

# GET/POST /api/eventos/
# GET/PUT/PATCH/DELETE /api/eventos/{id}/
# GET /api/eventos/activos/
# GET /api/eventos/por_ubicacion/?lat=X&lng=Y&radio=Z
# GET /api/eventos/estadisticas/
# POST /api/eventos/{id}/marcar_resuelto/

# GET/POST /api/rutas-afectadas/
# GET/PUT/PATCH/DELETE /api/rutas-afectadas/{id}/