import django_filters
from .models import (
    EmpresaTransporte, Piloto, Autobus, Ruta, Parada,
    AsignacionAutobusRuta, ViajeAutobus, PosicionAutobus
)


class EmpresaTransporteFilter(django_filters.FilterSet):
    """Filtros para EmpresaTransporte"""
    nombre = django_filters.CharFilter(lookup_expr='icontains')
    codigo = django_filters.CharFilter(lookup_expr='icontains')
    
    class Meta:
        model = EmpresaTransporte
        fields = ['activo', 'nombre', 'codigo']


class PilotoFilter(django_filters.FilterSet):
    """Filtros para Piloto"""
    nombre = django_filters.CharFilter(lookup_expr='icontains')
    documento = django_filters.CharFilter(lookup_expr='icontains')
    
    class Meta:
        model = Piloto
        fields = ['empresa', 'activo', 'licencia_categoria', 'nombre', 'documento']


class AutobusFilter(django_filters.FilterSet):
    """Filtros para Autobus"""
    codigo = django_filters.CharFilter(lookup_expr='icontains')
    placa = django_filters.CharFilter(lookup_expr='icontains')
    capacidad_min = django_filters.NumberFilter(field_name='capacidad', lookup_expr='gte')
    capacidad_max = django_filters.NumberFilter(field_name='capacidad', lookup_expr='lte')
    
    class Meta:
        model = Autobus
        fields = ['empresa', 'activo', 'codigo', 'placa']


class RutaFilter(django_filters.FilterSet):
    """Filtros para Ruta"""
    codigo = django_filters.CharFilter(lookup_expr='icontains')
    nombre = django_filters.CharFilter(lookup_expr='icontains')
    
    class Meta:
        model = Ruta
        fields = ['empresa', 'activo', 'codigo', 'nombre']


class ParadaFilter(django_filters.FilterSet):
    """Filtros para Parada"""
    nombre = django_filters.CharFilter(lookup_expr='icontains')
    
    class Meta:
        model = Parada
        fields = ['ruta', 'sentido', 'activo', 'nombre']


class AsignacionAutobusRutaFilter(django_filters.FilterSet):
    """Filtros para AsignacionAutobusRuta"""
    fecha_desde = django_filters.DateFilter(field_name='fecha', lookup_expr='gte')
    fecha_hasta = django_filters.DateFilter(field_name='fecha', lookup_expr='lte')
    
    class Meta:
        model = AsignacionAutobusRuta
        fields = ['autobus', 'ruta', 'piloto', 'fecha', 'estado']


class ViajeAutobusFilter(django_filters.FilterSet):
    """Filtros para ViajeAutobus"""
    inicio_desde = django_filters.DateTimeFilter(field_name='inicio_en', lookup_expr='gte')
    inicio_hasta = django_filters.DateTimeFilter(field_name='inicio_en', lookup_expr='lte')
    
    class Meta:
        model = ViajeAutobus
        fields = ['asignacion', 'autobus', 'ruta', 'piloto', 'estado']


class PosicionAutobusFilter(django_filters.FilterSet):
    """Filtros para PosicionAutobus"""
    capturado_desde = django_filters.DateTimeFilter(field_name='capturado_en', lookup_expr='gte')
    capturado_hasta = django_filters.DateTimeFilter(field_name='capturado_en', lookup_expr='lte')
    
    class Meta:
        model = PosicionAutobus
        fields = ['viaje', 'autobus', 'fuente']