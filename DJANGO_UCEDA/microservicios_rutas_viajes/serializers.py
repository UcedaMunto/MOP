from rest_framework import serializers
from decimal import Decimal
from django.utils import timezone
from .models import (
    EmpresaTransporte, Piloto, Autobus, Ruta, RutaGeopunto, Parada,
    AsignacionAutobusRuta, ViajeAutobus, PosicionAutobus
)


class EmpresaTransporteSerializer(serializers.ModelSerializer):
    """
    Serializer para EmpresaTransporte
    """
    class Meta:
        model = EmpresaTransporte
        fields = [
            'id', 'nombre', 'codigo', 'contacto', 'telefono', 'activo',
            'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en']

    def validate_codigo(self, value):
        """Validar que el código no esté vacío y sea único"""
        if not value.strip():
            raise serializers.ValidationError("El código no puede estar vacío.")
        return value.upper().strip()

    def validate_nombre(self, value):
        """Validar que el nombre no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El nombre no puede estar vacío.")
        return value.strip()


class PilotoSerializer(serializers.ModelSerializer):
    """
    Serializer para Piloto
    """
    empresa_nombre = serializers.CharField(source='empresa.nombre', read_only=True)

    class Meta:
        model = Piloto
        fields = [
            'id', 'empresa', 'empresa_nombre', 'nombre', 'documento',
            'licencia_numero', 'licencia_categoria', 'telefono', 'activo',
            'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en', 'empresa_nombre']

    def validate_nombre(self, value):
        """Validar que el nombre no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El nombre no puede estar vacío.")
        return value.strip()

    def validate_documento(self, value):
        """Validar que el documento no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El documento no puede estar vacío.")
        return value.strip()

    def validate_licencia_numero(self, value):
        """Validar que el número de licencia no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El número de licencia no puede estar vacío.")
        return value.strip()


class AutobusSerializer(serializers.ModelSerializer):
    """
    Serializer para Autobus
    """
    empresa_nombre = serializers.CharField(source='empresa.nombre', read_only=True)

    class Meta:
        model = Autobus
        fields = [
            'id', 'empresa', 'empresa_nombre', 'codigo', 'placa', 'capacidad',
            'activo', 'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en', 'empresa_nombre']

    def validate_codigo(self, value):
        """Validar que el código no esté vacío y sea único"""
        if not value.strip():
            raise serializers.ValidationError("El código no puede estar vacío.")
        return value.upper().strip()

    def validate_placa(self, value):
        """Validar que la placa no esté vacía"""
        if not value.strip():
            raise serializers.ValidationError("La placa no puede estar vacía.")
        return value.upper().strip()

    def validate_capacidad(self, value):
        """Validar que la capacidad sea positiva"""
        if value <= 0:
            raise serializers.ValidationError("La capacidad debe ser mayor a 0.")
        return value


class RutaGeopuntoSerializer(serializers.ModelSerializer):
    """
    Serializer para RutaGeopunto
    """
    class Meta:
        model = RutaGeopunto
        fields = ['id', 'ruta', 'orden', 'latitud', 'longitud']
        read_only_fields = ['id']

    def validate_latitud(self, value):
        """Validar rango de latitud"""
        if not (-90.0 <= float(value) <= 90.0):
            raise serializers.ValidationError("La latitud debe estar entre -90.0 y 90.0")
        return value

    def validate_longitud(self, value):
        """Validar rango de longitud"""
        if not (-180.0 <= float(value) <= 180.0):
            raise serializers.ValidationError("La longitud debe estar entre -180.0 y 180.0")
        return value


class RutaSerializer(serializers.ModelSerializer):
    """
    Serializer para Ruta
    """
    empresa_nombre = serializers.CharField(source='empresa.nombre', read_only=True)
    geopuntos = RutaGeopuntoSerializer(many=True, read_only=True)

    class Meta:
        model = Ruta
        fields = [
            'id', 'empresa', 'empresa_nombre', 'codigo', 'nombre', 'descripcion',
            'activo', 'geopuntos', 'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en', 'empresa_nombre']

    def validate_codigo(self, value):
        """Validar que el código no esté vacío y sea único"""
        if not value.strip():
            raise serializers.ValidationError("El código no puede estar vacío.")
        return value.upper().strip()

    def validate_nombre(self, value):
        """Validar que el nombre no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El nombre no puede estar vacío.")
        return value.strip()


class ParadaSerializer(serializers.ModelSerializer):
    """
    Serializer para Parada
    """
    ruta_codigo = serializers.CharField(source='ruta.codigo', read_only=True)
    ruta_nombre = serializers.CharField(source='ruta.nombre', read_only=True)

    class Meta:
        model = Parada
        fields = [
            'id', 'ruta', 'ruta_codigo', 'ruta_nombre', 'nombre', 'orden',
            'sentido', 'latitud', 'longitud', 'activo', 'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en', 'ruta_codigo', 'ruta_nombre']

    def validate_nombre(self, value):
        """Validar que el nombre no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El nombre no puede estar vacío.")
        return value.strip()

    def validate_latitud(self, value):
        """Validar rango de latitud"""
        if not (-90.0 <= float(value) <= 90.0):
            raise serializers.ValidationError("La latitud debe estar entre -90.0 y 90.0")
        return value

    def validate_longitud(self, value):
        """Validar rango de longitud"""
        if not (-180.0 <= float(value) <= 180.0):
            raise serializers.ValidationError("La longitud debe estar entre -180.0 y 180.0")
        return value


class AsignacionAutobusRutaSerializer(serializers.ModelSerializer):
    """
    Serializer para AsignacionAutobusRuta
    """
    autobus_codigo = serializers.CharField(source='autobus.codigo', read_only=True)
    ruta_codigo = serializers.CharField(source='ruta.codigo', read_only=True)
    piloto_nombre = serializers.CharField(source='piloto.nombre', read_only=True)

    class Meta:
        model = AsignacionAutobusRuta
        fields = [
            'id', 'autobus', 'autobus_codigo', 'ruta', 'ruta_codigo',
            'piloto', 'piloto_nombre', 'fecha', 'hora_inicio', 'hora_fin',
            'estado', 'creado_en', 'actualizado_en'
        ]
        read_only_fields = [
            'id', 'creado_en', 'actualizado_en', 'autobus_codigo',
            'ruta_codigo', 'piloto_nombre'
        ]

    def validate(self, data):
        """Validar que la hora de inicio sea anterior a la de fin"""
        if data.get('hora_inicio') and data.get('hora_fin'):
            if data['hora_inicio'] >= data['hora_fin']:
                raise serializers.ValidationError(
                    "La hora de inicio debe ser anterior a la hora de fin."
                )
        return data


class ViajeAutobusSerializer(serializers.ModelSerializer):
    """
    Serializer para ViajeAutobus
    """
    autobus_codigo = serializers.CharField(source='autobus.codigo', read_only=True)
    ruta_codigo = serializers.CharField(source='ruta.codigo', read_only=True)
    piloto_nombre = serializers.CharField(source='piloto.nombre', read_only=True)
    parada_inicio_nombre = serializers.CharField(source='parada_inicio.nombre', read_only=True)
    parada_fin_nombre = serializers.CharField(source='parada_fin.nombre', read_only=True)

    class Meta:
        model = ViajeAutobus
        fields = [
            'id', 'asignacion', 'autobus', 'autobus_codigo', 'ruta', 'ruta_codigo',
            'piloto', 'piloto_nombre', 'numero_viaje', 'estado', 'inicio_en', 'fin_en',
            'parada_inicio', 'parada_inicio_nombre', 'parada_fin', 'parada_fin_nombre',
            'distancia_km', 'duracion_min', 'velocidad_media_kmh',
            'creado_en', 'actualizado_en'
        ]
        read_only_fields = [
            'id', 'creado_en', 'actualizado_en', 'autobus_codigo', 'ruta_codigo',
            'piloto_nombre', 'parada_inicio_nombre', 'parada_fin_nombre'
        ]

    def validate(self, data):
        """Validar fechas y otros campos relacionados"""
        if data.get('inicio_en') and data.get('fin_en'):
            if data['inicio_en'] >= data['fin_en']:
                raise serializers.ValidationError(
                    "La fecha de inicio debe ser anterior a la fecha de fin."
                )
        
        if data.get('distancia_km') and data['distancia_km'] < 0:
            raise serializers.ValidationError("La distancia no puede ser negativa.")
        
        if data.get('velocidad_media_kmh') and data['velocidad_media_kmh'] < 0:
            raise serializers.ValidationError("La velocidad no puede ser negativa.")
        
        return data


class PosicionAutobusSerializer(serializers.ModelSerializer):
    """
    Serializer para PosicionAutobus
    """
    autobus_codigo = serializers.CharField(source='autobus.codigo', read_only=True)
    viaje_numero = serializers.IntegerField(source='viaje.numero_viaje', read_only=True)

    class Meta:
        model = PosicionAutobus
        fields = [
            'id', 'viaje', 'viaje_numero', 'autobus', 'autobus_codigo',
            'latitud', 'longitud', 'velocidad_kmh', 'rumbo_grados',
            'precision_m', 'fuente', 'capturado_en', 'recibido_en', 'creado_en'
        ]
        read_only_fields = [
            'id', 'recibido_en', 'creado_en', 'autobus_codigo', 'viaje_numero'
        ]

    def validate_latitud(self, value):
        """Validar rango de latitud"""
        if not (-90.0 <= float(value) <= 90.0):
            raise serializers.ValidationError("La latitud debe estar entre -90.0 y 90.0")
        return value

    def validate_longitud(self, value):
        """Validar rango de longitud"""
        if not (-180.0 <= float(value) <= 180.0):
            raise serializers.ValidationError("La longitud debe estar entre -180.0 y 180.0")
        return value

    def validate_velocidad_kmh(self, value):
        """Validar que la velocidad no sea negativa"""
        if value is not None and value < 0:
            raise serializers.ValidationError("La velocidad no puede ser negativa.")
        return value

    def validate_rumbo_grados(self, value):
        """Validar rango de rumbo"""
        if value is not None and not (0 <= float(value) <= 360):
            raise serializers.ValidationError("El rumbo debe estar entre 0 y 360 grados.")
        return value

    def validate_precision_m(self, value):
        """Validar que la precisión no sea negativa"""
        if value is not None and value < 0:
            raise serializers.ValidationError("La precisión no puede ser negativa.")
        return value


# Serializers simplificados para listados
class EmpresaTransporteListSerializer(serializers.ModelSerializer):
    """Serializer simplificado para listados de empresa"""
    class Meta:
        model = EmpresaTransporte
        fields = ['id', 'codigo', 'nombre', 'activo']


class AutobusListSerializer(serializers.ModelSerializer):
    """Serializer simplificado para listados de autobús"""
    empresa_nombre = serializers.CharField(source='empresa.nombre', read_only=True)
    
    class Meta:
        model = Autobus
        fields = ['id', 'codigo', 'placa', 'empresa_nombre', 'activo']


class RutaListSerializer(serializers.ModelSerializer):
    """Serializer simplificado para listados de ruta"""
    empresa_nombre = serializers.CharField(source='empresa.nombre', read_only=True)
    
    class Meta:
        model = Ruta
        fields = ['id', 'codigo', 'nombre', 'empresa_nombre', 'activo']