import django_filters
from django.db.models import Q
from django.utils import timezone
from decimal import Decimal
from .models import TipoEvento, NivelGravedad, EstadoEvento, EventoTrafico, EventoRutaAfectada


class TipoEventoFilter(django_filters.FilterSet):
    """Filtros para TipoEvento"""
    codigo = django_filters.CharFilter(lookup_expr='icontains')
    nombre = django_filters.CharFilter(lookup_expr='icontains')
    activo = django_filters.BooleanFilter()
    creado_desde = django_filters.DateTimeFilter(field_name='creado_en', lookup_expr='gte')
    creado_hasta = django_filters.DateTimeFilter(field_name='creado_en', lookup_expr='lte')

    class Meta:
        model = TipoEvento
        fields = ['codigo', 'nombre', 'activo', 'creado_desde', 'creado_hasta']


class NivelGravedadFilter(django_filters.FilterSet):
    """Filtros para NivelGravedad"""
    codigo = django_filters.CharFilter(lookup_expr='icontains')
    nombre = django_filters.CharFilter(lookup_expr='icontains')
    orden_min = django_filters.NumberFilter(field_name='orden', lookup_expr='gte')
    orden_max = django_filters.NumberFilter(field_name='orden', lookup_expr='lte')

    class Meta:
        model = NivelGravedad
        fields = ['codigo', 'nombre', 'orden_min', 'orden_max']


class EstadoEventoFilter(django_filters.FilterSet):
    """Filtros para EstadoEvento"""
    codigo = django_filters.CharFilter(lookup_expr='icontains')
    nombre = django_filters.CharFilter(lookup_expr='icontains')

    class Meta:
        model = EstadoEvento
        fields = ['codigo', 'nombre']


class EventoTraficoFilter(django_filters.FilterSet):
    """Filtros avanzados para EventoTrafico"""
    
    # Filtros por texto
    titulo = django_filters.CharFilter(lookup_expr='icontains')
    descripcion = django_filters.CharFilter(lookup_expr='icontains')
    
    # Filtros por relaciones
    tipo = django_filters.ModelChoiceFilter(queryset=TipoEvento.objects.filter(activo=True))
    tipo_codigo = django_filters.CharFilter(field_name='tipo__codigo', lookup_expr='exact')
    gravedad = django_filters.ModelChoiceFilter(queryset=NivelGravedad.objects.all())
    gravedad_codigo = django_filters.CharFilter(field_name='gravedad__codigo', lookup_expr='exact')
    gravedad_orden_min = django_filters.NumberFilter(field_name='gravedad__orden', lookup_expr='gte')
    gravedad_orden_max = django_filters.NumberFilter(field_name='gravedad__orden', lookup_expr='lte')
    estado = django_filters.ModelChoiceFilter(queryset=EstadoEvento.objects.all())
    estado_codigo = django_filters.CharFilter(field_name='estado__codigo', lookup_expr='exact')
    
    # Filtros por fechas
    fecha_ocurrencia = django_filters.DateTimeFilter()
    fecha_ocurrencia_desde = django_filters.DateTimeFilter(field_name='fecha_ocurrencia', lookup_expr='gte')
    fecha_ocurrencia_hasta = django_filters.DateTimeFilter(field_name='fecha_ocurrencia', lookup_expr='lte')
    fecha_reporte_desde = django_filters.DateTimeFilter(field_name='fecha_reporte', lookup_expr='gte')
    fecha_reporte_hasta = django_filters.DateTimeFilter(field_name='fecha_reporte', lookup_expr='lte')
    
    # Filtros por ubicación
    latitud_min = django_filters.NumberFilter(field_name='latitud', lookup_expr='gte')
    latitud_max = django_filters.NumberFilter(field_name='latitud', lookup_expr='lte')
    longitud_min = django_filters.NumberFilter(field_name='longitud', lookup_expr='gte')
    longitud_max = django_filters.NumberFilter(field_name='longitud', lookup_expr='lte')
    radio_metros_min = django_filters.NumberFilter(field_name='radio_metros', lookup_expr='gte')
    radio_metros_max = django_filters.NumberFilter(field_name='radio_metros', lookup_expr='lte')
    
    # Filtros por referencias externas
    viaje_id_externo = django_filters.CharFilter(lookup_expr='exact')
    viaje_sistema_origen = django_filters.CharFilter(lookup_expr='icontains')
    vehiculo_id_externo = django_filters.CharFilter(lookup_expr='exact')
    conductor_id_externo = django_filters.CharFilter(lookup_expr='exact')
    correlacion_id = django_filters.UUIDFilter()
    
    # Filtros por usuarios
    creado_por_id_externo = django_filters.CharFilter(lookup_expr='exact')
    creado_por_username = django_filters.CharFilter(lookup_expr='icontains')
    actualizado_por_id_externo = django_filters.CharFilter(lookup_expr='exact')
    actualizado_por_username = django_filters.CharFilter(lookup_expr='icontains')
    
    # Filtros especiales
    vigentes = django_filters.BooleanFilter(method='filter_vigentes')
    eliminados = django_filters.BooleanFilter(method='filter_eliminados')
    hoy = django_filters.BooleanFilter(method='filter_hoy')
    esta_semana = django_filters.BooleanFilter(method='filter_esta_semana')
    este_mes = django_filters.BooleanFilter(method='filter_este_mes')
    
    # Filtro por proximidad geográfica
    cerca_de = django_filters.CharFilter(method='filter_cerca_de')
    
    class Meta:
        model = EventoTrafico
        fields = [
            'titulo', 'descripcion',
            'tipo', 'tipo_codigo',
            'gravedad', 'gravedad_codigo', 'gravedad_orden_min', 'gravedad_orden_max',
            'estado', 'estado_codigo',
            'fecha_ocurrencia', 'fecha_ocurrencia_desde', 'fecha_ocurrencia_hasta',
            'fecha_reporte_desde', 'fecha_reporte_hasta',
            'latitud_min', 'latitud_max', 'longitud_min', 'longitud_max',
            'radio_metros_min', 'radio_metros_max',
            'viaje_id_externo', 'viaje_sistema_origen',
            'vehiculo_id_externo', 'conductor_id_externo', 'correlacion_id',
            'creado_por_id_externo', 'creado_por_username',
            'actualizado_por_id_externo', 'actualizado_por_username',
            'vigentes', 'eliminados', 'hoy', 'esta_semana', 'este_mes', 'cerca_de'
        ]

    def filter_vigentes(self, queryset, name, value):
        """Filtrar eventos vigentes (no expirados)"""
        if value:
            return queryset.filter(
                Q(expira_en__isnull=True) | Q(expira_en__gt=timezone.now())
            )
        elif value is False:
            return queryset.filter(expira_en__lte=timezone.now())
        return queryset

    def filter_eliminados(self, queryset, name, value):
        """Filtrar eventos eliminados"""
        if value:
            return queryset.filter(eliminado_en__isnull=False)
        elif value is False:
            return queryset.filter(eliminado_en__isnull=True)
        return queryset

    def filter_hoy(self, queryset, name, value):
        """Filtrar eventos de hoy"""
        if value:
            hoy = timezone.now().date()
            return queryset.filter(fecha_ocurrencia__date=hoy)
        return queryset

    def filter_esta_semana(self, queryset, name, value):
        """Filtrar eventos de esta semana"""
        if value:
            ahora = timezone.now()
            inicio_semana = ahora - timezone.timedelta(days=ahora.weekday())
            inicio_semana = inicio_semana.replace(hour=0, minute=0, second=0, microsecond=0)
            return queryset.filter(fecha_ocurrencia__gte=inicio_semana)
        return queryset

    def filter_este_mes(self, queryset, name, value):
        """Filtrar eventos de este mes"""
        if value:
            ahora = timezone.now()
            inicio_mes = ahora.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
            return queryset.filter(fecha_ocurrencia__gte=inicio_mes)
        return queryset

    def filter_cerca_de(self, queryset, name, value):
        """
        Filtrar eventos cerca de una ubicación
        Formato esperado: "lat,lng,radio" (radio en metros)
        Ejemplo: "19.4326,-99.1332,1000"
        """
        if not value:
            return queryset
        
        try:
            parts = value.split(',')
            if len(parts) != 3:
                return queryset
            
            lat, lng, radio = Decimal(parts[0]), Decimal(parts[1]), Decimal(parts[2])
            
            # Conversión básica: 1 grado ≈ 111km
            radio_grados = radio / Decimal('111000')
            
            return queryset.filter(
                latitud__range=[lat - radio_grados, lat + radio_grados],
                longitud__range=[lng - radio_grados, lng + radio_grados]
            )
        except (ValueError, TypeError, IndexError):
            return queryset


class EventoRutaAfectadaFilter(django_filters.FilterSet):
    """Filtros para EventoRutaAfectada"""
    
    evento = django_filters.ModelChoiceFilter(queryset=EventoTrafico.objects.all())
    evento_id = django_filters.NumberFilter(field_name='evento__id')
    sistema_origen = django_filters.CharFilter(lookup_expr='icontains')
    ruta_id_externo = django_filters.CharFilter(lookup_expr='exact')
    ruta_codigo = django_filters.CharFilter(lookup_expr='icontains')
    ruta_nombre = django_filters.CharFilter(lookup_expr='icontains')
    relevancia = django_filters.ChoiceFilter(choices=EventoRutaAfectada.RELEVANCIA_CHOICES)
    
    # Filtros por fechas
    creado_desde = django_filters.DateTimeFilter(field_name='creado_en', lookup_expr='gte')
    creado_hasta = django_filters.DateTimeFilter(field_name='creado_en', lookup_expr='lte')
    
    class Meta:
        model = EventoRutaAfectada
        fields = [
            'evento', 'evento_id', 'sistema_origen', 'ruta_id_externo',
            'ruta_codigo', 'ruta_nombre', 'relevancia',
            'creado_desde', 'creado_hasta'
        ]