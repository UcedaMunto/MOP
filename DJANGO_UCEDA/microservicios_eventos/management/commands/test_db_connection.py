from django.core.management.base import BaseCommand
from django.db import connections
from microservicios_eventos.models import EventoTrafico


class Command(BaseCommand):
    help = 'Prueba la conexión a la base de datos eventos_trafico'

    def handle(self, *args, **options):
        self.stdout.write(
            self.style.SUCCESS('Iniciando pruebas de conexión a base de datos...')
        )
        
        try:
            # Probar conexión a base de datos principal
            conn_default = connections['default']
            with conn_default.cursor() as cursor:
                cursor.execute("SELECT 1")
                result = cursor.fetchone()
                if result:
                    self.stdout.write(
                        self.style.SUCCESS('✓ Conexión a base de datos principal: OK')
                    )
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'✗ Error en conexión principal: {e}')
            )
        
        try:
            # Probar conexión a base de datos eventos_trafico
            conn_eventos = connections['eventos_trafico']
            with conn_eventos.cursor() as cursor:
                cursor.execute("SELECT 1")
                result = cursor.fetchone()
                if result:
                    self.stdout.write(
                        self.style.SUCCESS('✓ Conexión a base de datos eventos_trafico: OK')
                    )
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'✗ Error en conexión eventos_trafico: {e}')
            )
        
        try:
            # Probar creación de modelo de prueba
            evento_test = EventoTrafico(
                tipo_evento='incidente',
                descripcion='Evento de prueba - conexión de base de datos',
                ubicacion='Test Location',
                reportado_por='Sistema de Pruebas'
            )
            # Guardamos usando la base de datos correcta
            evento_test.save(using='eventos_trafico')
            
            self.stdout.write(
                self.style.SUCCESS(
                    f'✓ Evento de prueba creado con ID: {evento_test.id}'
                )
            )
            
            # Eliminar el evento de prueba
            evento_test.delete(using='eventos_trafico')
            self.stdout.write(
                self.style.SUCCESS('✓ Evento de prueba eliminado')
            )
            
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'✗ Error al crear/eliminar evento de prueba: {e}')
            )
        
        self.stdout.write(
            self.style.SUCCESS('Pruebas de conexión completadas.')
        )