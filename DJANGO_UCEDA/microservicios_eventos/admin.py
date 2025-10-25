from django.contrib import admin
from .models import EventoTrafico


@admin.register(EventoTrafico)
class EventoTraficoAdmin(admin.ModelAdmin):
    """
    Configuración del admin para EventoTrafico
    """
    list_display = [
        'id',
        'tipo_evento',
        'ubicacion', 
        'estado',
        'prioridad',
        'fecha_creacion',
        'reportado_por'
    ]
    list_filter = [
        'tipo_evento',
        'estado',
        'prioridad',
        'fecha_creacion',
    ]
    search_fields = [
        'descripcion',
        'ubicacion',
        'reportado_por'
    ]
    readonly_fields = [
        'fecha_creacion',
        'fecha_actualizacion'
    ]
    fieldsets = (
        ('Información Básica', {
            'fields': (
                'tipo_evento',
                'descripcion',
                'prioridad',
                'estado'
            )
        }),
        ('Ubicación', {
            'fields': (
                'ubicacion',
                'latitud',
                'longitud'
            )
        }),
        ('Fechas', {
            'fields': (
                'fecha_creacion',
                'fecha_actualizacion',
                'fecha_resolucion'
            )
        }),
        ('Metadatos', {
            'fields': (
                'reportado_por',
            )
        }),
    )
    
    def save_model(self, request, obj, form, change):
        if not change:  # Si es un nuevo objeto
            obj.reportado_por = request.user.username
        super().save_model(request, obj, form, change)