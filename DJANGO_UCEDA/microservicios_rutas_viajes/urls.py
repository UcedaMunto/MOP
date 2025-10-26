from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    EmpresaTransporteViewSet, PilotoViewSet, AutobusViewSet, RutaViewSet,
    RutaGeopuntoViewSet, ParadaViewSet, AsignacionAutobusRutaViewSet,
    ViajeAutobusViewSet, PosicionAutobusViewSet
)

# Crear el router para las APIs REST
router = DefaultRouter()
router.register(r'empresas', EmpresaTransporteViewSet, basename='empresa')
router.register(r'pilotos', PilotoViewSet, basename='piloto')
router.register(r'autobuses', AutobusViewSet, basename='autobus')
router.register(r'rutas', RutaViewSet, basename='ruta')
router.register(r'ruta-geopuntos', RutaGeopuntoViewSet, basename='ruta-geopunto')
router.register(r'paradas', ParadaViewSet, basename='parada')
router.register(r'asignaciones', AsignacionAutobusRutaViewSet, basename='asignacion')
router.register(r'viajes', ViajeAutobusViewSet, basename='viaje')
router.register(r'posiciones', PosicionAutobusViewSet, basename='posicion')

app_name = 'microservicios_rutas_viajes'

urlpatterns = [
    path('api/v1/rutas-viajes/', include(router.urls)),
]