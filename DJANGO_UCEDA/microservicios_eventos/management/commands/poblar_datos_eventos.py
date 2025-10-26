from django.core.management.base import BaseCommand
from django.db import transaction
from microservicios_eventos.models import TipoEvento, NivelGravedad, EstadoEvento


class Command(BaseCommand):
    help = 'Poblar datos de ejemplo para el microservicio de eventos'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('Iniciando población de datos de eventos...'))
        
        with transaction.atomic():
            # Crear tipos de evento
            self.crear_tipos_evento()
            
            # Crear niveles de gravedad
            self.crear_niveles_gravedad()
            
            # Crear estados de evento
            self.crear_estados_evento()
        
        self.stdout.write(self.style.SUCCESS('Datos de eventos creados exitosamente!'))

    def crear_tipos_evento(self):
        self.stdout.write('Creando tipos de evento...')
        
        tipos_evento = [
            {
                'codigo': 'ACC',
                'nombre': 'Accidente',
                'descripcion': 'Accidente de tráfico con vehículos involucrados'
            },
            {
                'codigo': 'CON',
                'nombre': 'Construcción',
                'descripcion': 'Trabajos de construcción o mantenimiento vial'
            },
            {
                'codigo': 'CA',
                'nombre': 'Caída de Árbol',
                'descripcion': 'Árbol caído que bloquea la vía'
            },
            {
                'codigo': 'EMER',
                'nombre': 'Situación de Emergencia',
                'descripcion': 'Eventos que requieren atención inmediata'
            },
            {
                'codigo': 'DER',
                'nombre': 'Derrumbe',
                'descripcion': 'Derrumbe o deslizamiento que afecta la vía'
            },
            {
                'codigo': 'CONG',
                'nombre': 'Congestión',
                'descripcion': 'Congestión vehicular severa'
            },
            {
                'codigo': 'INUND',
                'nombre': 'Inundación',
                'descripcion': 'Inundación que afecta el tránsito vehicular'
            },
            {
                'codigo': 'MANT',
                'nombre': 'Mantenimiento',
                'descripcion': 'Trabajos de mantenimiento programado'
            }
        ]
        
        for tipo_data in tipos_evento:
            tipo_evento, created = TipoEvento.objects.get_or_create(
                codigo=tipo_data['codigo'],
                defaults={
                    'nombre': tipo_data['nombre'],
                    'descripcion': tipo_data['descripcion']
                }
            )
            if created:
                self.stdout.write(f'  ✓ Creado: {tipo_evento}')
            else:
                self.stdout.write(f'  - Ya existe: {tipo_evento}')

    def crear_niveles_gravedad(self):
        self.stdout.write('Creando niveles de gravedad...')
        
        niveles_gravedad = [
            {
                'codigo': 'BAJA',
                'nombre': 'Baja',
                'orden': 1
            },
            {
                'codigo': 'MEDIA',
                'nombre': 'Media',
                'orden': 2
            },
            {
                'codigo': 'ALTA',
                'nombre': 'Alta',
                'orden': 3
            },
            {
                'codigo': 'CRITICA',
                'nombre': 'Crítica',
                'orden': 4
            },
            {
                'codigo': 'SEVERA',
                'nombre': 'Severa',
                'orden': 5
            }
        ]
        
        for nivel_data in niveles_gravedad:
            nivel, created = NivelGravedad.objects.get_or_create(
                codigo=nivel_data['codigo'],
                defaults={
                    'nombre': nivel_data['nombre'],
                    'orden': nivel_data['orden']
                }
            )
            if created:
                self.stdout.write(f'  ✓ Creado: {nivel}')
            else:
                self.stdout.write(f'  - Ya existe: {nivel}')

    def crear_estados_evento(self):
        self.stdout.write('Creando estados de evento...')
        
        estados_evento = [
            {
                'codigo': 'NUEVO',
                'nombre': 'Nuevo'
            },
            {
                'codigo': 'ACTIVO',
                'nombre': 'Activo'
            },
            {
                'codigo': 'EN_PROCESO',
                'nombre': 'En Proceso'
            },
            {
                'codigo': 'RESUELTO',
                'nombre': 'Resuelto'
            },
            {
                'codigo': 'CERRADO',
                'nombre': 'Cerrado'
            },
            {
                'codigo': 'CANCELADO',
                'nombre': 'Cancelado'
            }
        ]
        
        for estado_data in estados_evento:
            estado, created = EstadoEvento.objects.get_or_create(
                codigo=estado_data['codigo'],
                defaults={
                    'nombre': estado_data['nombre']
                }
            )
            if created:
                self.stdout.write(f'  ✓ Creado: {estado}')
            else:
                self.stdout.write(f'  - Ya existe: {estado}')