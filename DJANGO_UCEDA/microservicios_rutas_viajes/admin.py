from django.contrib import admin
from .models import (
    EmpresaTransporte, Piloto, Autobus, Ruta, RutaGeopunto, Parada,
    AsignacionAutobusRuta, ViajeAutobus, PosicionAutobus
)


@admin.register(EmpresaTransporte)
class EmpresaTransporteAdmin(admin.ModelAdmin):
    list_display = ['codigo', 'nombre', 'contacto', 'activo', 'creado_en']
    list_filter = ['activo', 'creado_en']
    search_fields = ['codigo', 'nombre', 'contacto']
    ordering = ['codigo']


@admin.register(Piloto)
class PilotoAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'empresa', 'documento', 'licencia_numero', 'activo']
    list_filter = ['empresa', 'activo', 'licencia_categoria']
    search_fields = ['nombre', 'documento', 'licencia_numero']
    ordering = ['nombre']


@admin.register(Autobus)
class AutobusAdmin(admin.ModelAdmin):
    list_display = ['codigo', 'placa', 'empresa', 'capacidad', 'activo']
    list_filter = ['empresa', 'activo']
    search_fields = ['codigo', 'placa']
    ordering = ['codigo']


@admin.register(Ruta)
class RutaAdmin(admin.ModelAdmin):
    list_display = ['codigo', 'nombre', 'empresa', 'activo', 'creado_en']
    list_filter = ['empresa', 'activo', 'creado_en']
    search_fields = ['codigo', 'nombre']
    ordering = ['codigo']


@admin.register(RutaGeopunto)
class RutaGeopuntoAdmin(admin.ModelAdmin):
    list_display = ['ruta', 'orden', 'latitud', 'longitud']
    list_filter = ['ruta']
    ordering = ['ruta', 'orden']


@admin.register(Parada)
class ParadaAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'ruta', 'sentido', 'orden', 'activo']
    list_filter = ['ruta', 'sentido', 'activo']
    search_fields = ['nombre']
    ordering = ['ruta', 'sentido', 'orden']


@admin.register(AsignacionAutobusRuta)
class AsignacionAutobusRutaAdmin(admin.ModelAdmin):
    list_display = ['autobus', 'ruta', 'piloto', 'fecha', 'estado']
    list_filter = ['fecha', 'estado', 'autobus__empresa']
    ordering = ['-fecha', 'hora_inicio']


@admin.register(ViajeAutobus)
class ViajeAutobusAdmin(admin.ModelAdmin):
    list_display = ['autobus', 'ruta', 'numero_viaje', 'estado', 'inicio_en']
    list_filter = ['estado', 'autobus__empresa', 'inicio_en']
    ordering = ['-inicio_en']


@admin.register(PosicionAutobus)
class PosicionAutobusAdmin(admin.ModelAdmin):
    list_display = ['autobus', 'viaje', 'latitud', 'longitud', 'capturado_en', 'fuente']
    list_filter = ['fuente', 'capturado_en', 'autobus']
    ordering = ['-capturado_en']
    readonly_fields = ['recibido_en', 'creado_en']