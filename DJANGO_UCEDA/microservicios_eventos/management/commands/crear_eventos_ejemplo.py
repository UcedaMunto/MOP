from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone
from django.contrib.gis.geos import Point
from microservicios_eventos.models import (
    TipoEvento, NivelGravedad, EstadoEvento, EventoTrafico
)
from datetime import datetime, timedelta
import uuid


class Command(BaseCommand):
    help = 'Crear eventos de tráfico de ejemplo'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('Creando eventos de tráfico de ejemplo...'))
        
        with transaction.atomic():
            self.crear_eventos_ejemplo()
        
        self.stdout.write(self.style.SUCCESS('Eventos de tráfico creados exitosamente!'))

    def crear_eventos_ejemplo(self):
        self.stdout.write('Creando eventos de ejemplo...')
        
        # Obtener catálogos
        tipo_accidente = TipoEvento.objects.get(codigo='ACC')
        tipo_construccion = TipoEvento.objects.get(codigo='CON')
        tipo_congestion = TipoEvento.objects.get(codigo='CONG')
        
        gravedad_alta = NivelGravedad.objects.get(codigo='ALTA')
        gravedad_media = NivelGravedad.objects.get(codigo='MEDIA')
        gravedad_baja = NivelGravedad.objects.get(codigo='BAJA')
        
        estado_activo = EstadoEvento.objects.get(codigo='ACTIVO')
        estado_proceso = EstadoEvento.objects.get(codigo='EN_PROCESO')
        estado_nuevo = EstadoEvento.objects.get(codigo='NUEVO')
        
        # Coordenadas de San Salvador
        eventos_data = [
            {
                'titulo': 'Accidente vehicular en Av. Masferrer',
                'descripcion': 'Colisión entre dos vehículos en el carril izquierdo de Av. Masferrer Norte, a la altura del Centro Comercial San Luis. Se requiere grúa.',
                'tipo': tipo_accidente,
                'gravedad': gravedad_alta,
                'estado': estado_activo,
                'latitud': 13.7089,
                'longitud': -89.2078,
                'radio_metros': 500,
                'fecha_ocurrencia': timezone.now() - timedelta(hours=2),
                'expira_en': timezone.now() + timedelta(hours=4)
            },
            {
                'titulo': 'Obras de mantenimiento en Boulevard del Ejército',
                'descripcion': 'Trabajos de repavimentación programados en Boulevard del Ejército, desde la rotonda hasta el Hospital Militar. Reducción a un carril.',
                'tipo': tipo_construccion,
                'gravedad': gravedad_media,
                'estado': estado_proceso,
                'latitud': 13.6876,
                'longitud': -89.2357,
                'radio_metros': 1000,
                'fecha_ocurrencia': timezone.now() - timedelta(days=1),
                'expira_en': timezone.now() + timedelta(days=3)
            },
            {
                'titulo': 'Congestión vehicular intensa en Autopista Sur',
                'descripcion': 'Tráfico extremadamente lento en Autopista Sur en ambas direcciones debido a hora pico. Tiempo estimado de atravesar: 45 minutos.',
                'tipo': tipo_congestion,
                'gravedad': gravedad_baja,
                'estado': estado_nuevo,
                'latitud': 13.6542,
                'longitud': -89.2756,
                'radio_metros': 2000,
                'fecha_ocurrencia': timezone.now() - timedelta(minutes=30),
                'expira_en': timezone.now() + timedelta(hours=2)
            }
        ]
        
        for evento_data in eventos_data:
            # Crear ubicación geográfica usando PostGIS Point
            ubicacion = Point(evento_data['longitud'], evento_data['latitud'], srid=4326)
            
            evento = EventoTrafico.objects.create(
                titulo=evento_data['titulo'],
                descripcion=evento_data['descripcion'],
                tipo=evento_data['tipo'],
                gravedad=evento_data['gravedad'],
                estado=evento_data['estado'],
                ubicacion=ubicacion,
                latitud=evento_data['latitud'],
                longitud=evento_data['longitud'],
                radio_metros=evento_data['radio_metros'],
                fecha_ocurrencia=evento_data['fecha_ocurrencia'],
                fecha_reporte=timezone.now(),
                expira_en=evento_data['expira_en'],
                correlacion_id=uuid.uuid4(),
                creado_por_id_externo=1,
                creado_por_username='admin'
            )
            
            self.stdout.write(f'  ✓ Creado evento: {evento.titulo}')