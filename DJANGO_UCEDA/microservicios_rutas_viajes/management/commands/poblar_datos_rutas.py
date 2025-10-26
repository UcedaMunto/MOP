from django.core.management.base import BaseCommand
from django.db import transaction
from microservicios_rutas_viajes.models import (
    EmpresaTransporte, Piloto, Autobus, Ruta, Parada, RutaGeopunto
)
from decimal import Decimal
import uuid


class Command(BaseCommand):
    help = 'Poblar datos de ejemplo para el microservicio de rutas y viajes'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('Iniciando población de datos de rutas y viajes...'))
        
        with transaction.atomic():
            # Crear empresas de transporte
            empresas = self.crear_empresas_transporte()
            
            # Crear pilotos
            self.crear_pilotos(empresas)
            
            # Crear autobuses
            self.crear_autobuses(empresas)
            
            # Crear rutas
            rutas = self.crear_rutas(empresas)
            
            # Crear paradas
            self.crear_paradas(rutas)
            
            # Crear geo-puntos para rutas
            self.crear_geopuntos_rutas(rutas)
        
        self.stdout.write(self.style.SUCCESS('Datos de rutas y viajes creados exitosamente!'))

    def crear_empresas_transporte(self):
        self.stdout.write('Creando empresas de transporte...')
        
        empresas_data = [
            {
                'nombre': 'Transporte Metropolitano S.A.',
                'codigo': 'TRAMESA',
                'contacto': 'María González',
                'telefono': '2234-5678'
            },
            {
                'nombre': 'Buses del Centro',
                'codigo': 'BUSCENTRO',
                'contacto': 'Carlos Martínez',
                'telefono': '2345-6789'
            },
            {
                'nombre': 'Ruta Express',
                'codigo': 'RUTEXP',
                'contacto': 'Ana Rodríguez',
                'telefono': '2456-7890'
            },
            {
                'nombre': 'Transporte Unido',
                'codigo': 'TRANSU',
                'contacto': 'Luis Hernández',
                'telefono': '2567-8901'
            }
        ]
        
        empresas = []
        for empresa_data in empresas_data:
            empresa, created = EmpresaTransporte.objects.get_or_create(
                codigo=empresa_data['codigo'],
                defaults={
                    'nombre': empresa_data['nombre'],
                    'contacto': empresa_data['contacto'],
                    'telefono': empresa_data['telefono']
                }
            )
            if created:
                self.stdout.write(f'  ✓ Creada: {empresa}')
            else:
                self.stdout.write(f'  - Ya existe: {empresa}')
            empresas.append(empresa)
        
        return empresas

    def crear_pilotos(self, empresas):
        self.stdout.write('Creando pilotos...')
        
        pilotos_data = [
            # TRAMESA
            {
                'empresa': empresas[0],
                'nombre': 'Juan Carlos Pérez López',
                'documento': '01234567-8',
                'licencia_numero': 'LIC123456',
                'licencia_categoria': 'PESADA',
                'telefono': '7890-1234'
            },
            {
                'empresa': empresas[0],
                'nombre': 'Roberto Martín Castro',
                'documento': '02345678-9',
                'licencia_numero': 'LIC234567',
                'licencia_categoria': 'PESADA',
                'telefono': '7901-2345'
            },
            # BUSCENTRO
            {
                'empresa': empresas[1],
                'nombre': 'Sandra Elena Morales',
                'documento': '03456789-0',
                'licencia_numero': 'LIC345678',
                'licencia_categoria': 'PESADA',
                'telefono': '7012-3456'
            },
            {
                'empresa': empresas[1],
                'nombre': 'Miguel Ángel Rivera',
                'documento': '04567890-1',
                'licencia_numero': 'LIC456789',
                'licencia_categoria': 'PESADA',
                'telefono': '7123-4567'
            },
            # RUTEXP
            {
                'empresa': empresas[2],
                'nombre': 'Carmen Rosa Jiménez',
                'documento': '05678901-2',
                'licencia_numero': 'LIC567890',
                'licencia_categoria': 'PESADA',
                'telefono': '7234-5678'
            },
            # TRANSU
            {
                'empresa': empresas[3],
                'nombre': 'David Antonio Flores',
                'documento': '06789012-3',
                'licencia_numero': 'LIC678901',
                'licencia_categoria': 'PESADA',
                'telefono': '7345-6789'
            }
        ]
        
        for piloto_data in pilotos_data:
            piloto, created = Piloto.objects.get_or_create(
                documento=piloto_data['documento'],
                defaults=piloto_data
            )
            if created:
                self.stdout.write(f'  ✓ Creado: {piloto}')
            else:
                self.stdout.write(f'  - Ya existe: {piloto}')

    def crear_autobuses(self, empresas):
        self.stdout.write('Creando autobuses...')
        
        autobuses_data = [
            # TRAMESA
            {
                'empresa': empresas[0],
                'codigo': 'TRA-001',
                'placa': 'P123-456',
                'capacidad': 45
            },
            {
                'empresa': empresas[0],
                'codigo': 'TRA-002',
                'placa': 'P234-567',
                'capacidad': 45
            },
            {
                'empresa': empresas[0],
                'codigo': 'TRA-003',
                'placa': 'P345-678',
                'capacidad': 50
            },
            # BUSCENTRO
            {
                'empresa': empresas[1],
                'codigo': 'BC-001',
                'placa': 'B456-789',
                'capacidad': 40
            },
            {
                'empresa': empresas[1],
                'codigo': 'BC-002',
                'placa': 'B567-890',
                'capacidad': 40
            },
            # RUTEXP
            {
                'empresa': empresas[2],
                'codigo': 'RX-001',
                'placa': 'R678-901',
                'capacidad': 55
            },
            {
                'empresa': empresas[2],
                'codigo': 'RX-002',
                'placa': 'R789-012',
                'capacidad': 55
            },
            # TRANSU
            {
                'empresa': empresas[3],
                'codigo': 'TU-001',
                'placa': 'T890-123',
                'capacidad': 48
            }
        ]
        
        for autobus_data in autobuses_data:
            autobus, created = Autobus.objects.get_or_create(
                codigo=autobus_data['codigo'],
                defaults=autobus_data
            )
            if created:
                self.stdout.write(f'  ✓ Creado: {autobus}')
            else:
                self.stdout.write(f'  - Ya existe: {autobus}')

    def crear_rutas(self, empresas):
        self.stdout.write('Creando rutas...')
        
        rutas_data = [
            {
                'empresa': empresas[0],
                'codigo': 'R-01',
                'nombre': 'Centro - Terminal',
                'descripcion': 'Ruta desde el centro de la ciudad hasta la Terminal de Buses'
            },
            {
                'empresa': empresas[0],
                'codigo': 'R-02',
                'nombre': 'Universidad - Hospital',
                'descripcion': 'Conecta la zona universitaria con el Hospital Nacional'
            },
            {
                'empresa': empresas[1],
                'codigo': 'R-03',
                'nombre': 'Mercado - Colonia Escalón',
                'descripcion': 'Desde el Mercado Central hasta Colonia Escalón'
            },
            {
                'empresa': empresas[2],
                'codigo': 'R-04',
                'nombre': 'Aeropuerto - Centro',
                'descripcion': 'Ruta expresa del Aeropuerto al Centro de San Salvador'
            },
            {
                'empresa': empresas[3],
                'codigo': 'R-05',
                'nombre': 'Soyapango - Metrocentro',
                'descripcion': 'Conexión desde Soyapango hasta Metrocentro'
            }
        ]
        
        rutas = []
        for ruta_data in rutas_data:
            ruta, created = Ruta.objects.get_or_create(
                codigo=ruta_data['codigo'],
                defaults=ruta_data
            )
            if created:
                self.stdout.write(f'  ✓ Creada: {ruta}')
            else:
                self.stdout.write(f'  - Ya existe: {ruta}')
            rutas.append(ruta)
        
        return rutas

    def crear_paradas(self, rutas):
        self.stdout.write('Creando paradas...')
        
        # Paradas para Ruta R-01 (Centro - Terminal)
        paradas_r01 = [
            # IDA
            {'nombre': 'Plaza Barrios', 'orden': 1, 'sentido': 'IDA', 'lat': 13.6929, 'lng': -89.2182},
            {'nombre': 'Catedral Metropolitana', 'orden': 2, 'sentido': 'IDA', 'lat': 13.6938, 'lng': -89.2191},
            {'nombre': 'Teatro Nacional', 'orden': 3, 'sentido': 'IDA', 'lat': 13.6951, 'lng': -89.2205},
            {'nombre': 'Hospital Rosales', 'orden': 4, 'sentido': 'IDA', 'lat': 13.6975, 'lng': -89.2234},
            {'nombre': 'Terminal de Occidente', 'orden': 5, 'sentido': 'IDA', 'lat': 13.7012, 'lng': -89.2267},
            # VUELTA
            {'nombre': 'Terminal de Occidente', 'orden': 1, 'sentido': 'VUELTA', 'lat': 13.7012, 'lng': -89.2267},
            {'nombre': 'Hospital Rosales', 'orden': 2, 'sentido': 'VUELTA', 'lat': 13.6975, 'lng': -89.2234},
            {'nombre': 'Teatro Nacional', 'orden': 3, 'sentido': 'VUELTA', 'lat': 13.6951, 'lng': -89.2205},
            {'nombre': 'Catedral Metropolitana', 'orden': 4, 'sentido': 'VUELTA', 'lat': 13.6938, 'lng': -89.2191},
            {'nombre': 'Plaza Barrios', 'orden': 5, 'sentido': 'VUELTA', 'lat': 13.6929, 'lng': -89.2182}
        ]
        
        # Paradas para Ruta R-02 (Universidad - Hospital)
        paradas_r02 = [
            # IDA
            {'nombre': 'UES - Entrada Principal', 'orden': 1, 'sentido': 'IDA', 'lat': 13.7147, 'lng': -89.2039},
            {'nombre': 'Boulevard Universitario', 'orden': 2, 'sentido': 'IDA', 'lat': 13.7089, 'lng': -89.2078},
            {'nombre': 'Redondel Masferrer', 'orden': 3, 'sentido': 'IDA', 'lat': 13.7023, 'lng': -89.2134},
            {'nombre': 'Hospital Nacional', 'orden': 4, 'sentido': 'IDA', 'lat': 13.6987, 'lng': -89.2198},
            # VUELTA  
            {'nombre': 'Hospital Nacional', 'orden': 1, 'sentido': 'VUELTA', 'lat': 13.6987, 'lng': -89.2198},
            {'nombre': 'Redondel Masferrer', 'orden': 2, 'sentido': 'VUELTA', 'lat': 13.7023, 'lng': -89.2134},
            {'nombre': 'Boulevard Universitario', 'orden': 3, 'sentido': 'VUELTA', 'lat': 13.7089, 'lng': -89.2078},
            {'nombre': 'UES - Entrada Principal', 'orden': 4, 'sentido': 'VUELTA', 'lat': 13.7147, 'lng': -89.2039}
        ]
        
        # Crear paradas por ruta
        for i, ruta in enumerate(rutas[:2]):  # Solo las primeras 2 rutas
            paradas_data = paradas_r01 if i == 0 else paradas_r02
            
            for parada_data in paradas_data:
                parada, created = Parada.objects.get_or_create(
                    ruta=ruta,
                    orden=parada_data['orden'],
                    sentido=parada_data['sentido'],
                    defaults={
                        'nombre': parada_data['nombre'],
                        'latitud': Decimal(str(parada_data['lat'])),
                        'longitud': Decimal(str(parada_data['lng']))
                    }
                )
                if created:
                    self.stdout.write(f'  ✓ Creada parada: {parada}')
                else:
                    self.stdout.write(f'  - Ya existe parada: {parada}')

    def crear_geopuntos_rutas(self, rutas):
        self.stdout.write('Creando geo-puntos para rutas...')
        
        # Geo-puntos para Ruta R-01 (Centro - Terminal)
        geopuntos_r01 = [
            {'orden': 1, 'lat': 13.6929, 'lng': -89.2182},
            {'orden': 2, 'lat': 13.6935, 'lng': -89.2187},
            {'orden': 3, 'lat': 13.6942, 'lng': -89.2195},
            {'orden': 4, 'lat': 13.6955, 'lng': -89.2210},
            {'orden': 5, 'lat': 13.6970, 'lng': -89.2225},
            {'orden': 6, 'lat': 13.6985, 'lng': -89.2240},
            {'orden': 7, 'lat': 13.7000, 'lng': -89.2255},
            {'orden': 8, 'lat': 13.7012, 'lng': -89.2267}
        ]
        
        # Geo-puntos para Ruta R-02 (Universidad - Hospital)  
        geopuntos_r02 = [
            {'orden': 1, 'lat': 13.7147, 'lng': -89.2039},
            {'orden': 2, 'lat': 13.7130, 'lng': -89.2055},
            {'orden': 3, 'lat': 13.7110, 'lng': -89.2070},
            {'orden': 4, 'lat': 13.7090, 'lng': -89.2090},
            {'orden': 5, 'lat': 13.7050, 'lng': -89.2115},
            {'orden': 6, 'lat': 13.7020, 'lng': -89.2140},
            {'orden': 7, 'lat': 13.7000, 'lng': -89.2170},
            {'orden': 8, 'lat': 13.6987, 'lng': -89.2198}
        ]
        
        # Crear geo-puntos por ruta
        for i, ruta in enumerate(rutas[:2]):  # Solo las primeras 2 rutas
            geopuntos_data = geopuntos_r01 if i == 0 else geopuntos_r02
            
            for geopunto_data in geopuntos_data:
                geopunto, created = RutaGeopunto.objects.get_or_create(
                    ruta=ruta,
                    orden=geopunto_data['orden'],
                    defaults={
                        'latitud': Decimal(str(geopunto_data['lat'])),
                        'longitud': Decimal(str(geopunto_data['lng']))
                    }
                )
                if created:
                    self.stdout.write(f'  ✓ Creado geo-punto: {geopunto}')
                else:
                    self.stdout.write(f'  - Ya existe geo-punto: {geopunto}')