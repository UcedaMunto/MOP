from django.contrib import admin
from .models import TipoEvento, NivelGravedad, EstadoEvento, EventoTrafico, EventoRutaAfectada


@admin.register(TipoEvento)
class TipoEventoAdmin(admin.ModelAdmin):
    """
    Configuración del admin para TipoEvento
    """
    list_display = [
        'codigo',
        'nombre',
        'activo',
        'creado_en'
    ]
    list_filter = [
        'activo',
        'creado_en'
    ]
    search_fields = [
        'codigo',
        'nombre',
        'descripcion'
    ]
    readonly_fields = [
        'creado_en',
        'actualizado_en'
    ]


@admin.register(NivelGravedad)
class NivelGravedadAdmin(admin.ModelAdmin):
    """
    Configuración del admin para NivelGravedad
    """
    list_display = [
        'codigo',
        'nombre',
        'orden',
        'creado_en'
    ]
    list_filter = [
        'orden',
        'creado_en'
    ]
    search_fields = [
        'codigo',
        'nombre'
    ]
    readonly_fields = [
        'creado_en',
        'actualizado_en'
    ]
    ordering = ['orden']


@admin.register(EstadoEvento)
class EstadoEventoAdmin(admin.ModelAdmin):
    """
    Configuración del admin para EstadoEvento
    """
    list_display = [
        'codigo',
        'nombre',
        'creado_en'
    ]
    list_filter = [
        'creado_en'
    ]
    search_fields = [
        'codigo',
        'nombre'
    ]
    readonly_fields = [
        'creado_en',
        'actualizado_en'
    ]


@admin.register(EventoTrafico)
class EventoTraficoAdmin(admin.ModelAdmin):
    """
    Configuración del admin para EventoTrafico
    """
    list_display = [
        'id',
        'titulo',
        'tipo',
        'gravedad',
        'estado',
        'fecha_ocurrencia',
        'creado_por_username'
    ]
    list_filter = [
        'tipo',
        'gravedad',
        'estado',
        'fecha_ocurrencia',
        'fecha_reporte',
        'creado_en'
    ]
    search_fields = [
        'titulo',
        'descripcion',
        'viaje_id_externo',
        'vehiculo_id_externo'
    ]
    readonly_fields = [
        'correlacion_id',
        'creado_en',
        'actualizado_en'
    ]
    fieldsets = (
        ('Información Básica', {
            'fields': (
                'titulo',
                'descripcion',
                'tipo',
                'gravedad',
                'estado'
            )
        }),
        ('Ubicación', {
            'fields': (
                'latitud',
                'longitud',
                'radio_metros'
            )
        }),
        ('Fechas', {
            'fields': (
                'fecha_ocurrencia',
                'fecha_reporte',
                'expira_en'
            )
        }),
        ('Referencias Externas', {
            'fields': (
                'viaje_id_externo',
                'viaje_sistema_origen',
                'vehiculo_id_externo',
                'conductor_id_externo',
                'correlacion_id'
            ),
            'classes': ('collapse',)
        }),
        ('Metadatos', {
            'fields': (
                'creado_por_id_externo',
                'creado_por_username',
                'actualizado_por_id_externo',
                'actualizado_por_username',
                'creado_en',
                'actualizado_en',
                'eliminado_en'
            )
        }),
    )
    
    def save_model(self, request, obj, form, change):
        if not change:  # Si es un nuevo objeto
            obj.creado_por_id_externo = str(request.user.id)
            obj.creado_por_username = request.user.username
        obj.actualizado_por_id_externo = str(request.user.id)
        obj.actualizado_por_username = request.user.username
        super().save_model(request, obj, form, change)


@admin.register(EventoRutaAfectada)
class EventoRutaAfectadaAdmin(admin.ModelAdmin):
    """
    Configuración del admin para EventoRutaAfectada
    """
    list_display = [
        'evento',
        'sistema_origen',
        'ruta_codigo',
        'ruta_nombre',
        'relevancia',
        'creado_en'
    ]
    list_filter = [
        'sistema_origen',
        'relevancia',
        'creado_en'
    ]
    search_fields = [
        'ruta_id_externo',
        'ruta_codigo',
        'ruta_nombre'
    ]
    readonly_fields = [
        'creado_en',
        'actualizado_en'
    ]