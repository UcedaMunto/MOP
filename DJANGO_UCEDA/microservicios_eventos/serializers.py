from rest_framework import serializers
from decimal import Decimal
from django.utils import timezone
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from .models import TipoEvento, NivelGravedad, EstadoEvento, EventoTrafico, EventoRutaAfectada


class TipoEventoSerializer(serializers.ModelSerializer):
    """
    Serializer para TipoEvento
    """
    class Meta:
        model = TipoEvento
        fields = [
            'id', 'codigo', 'nombre', 'descripcion', 'activo',
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


class NivelGravedadSerializer(serializers.ModelSerializer):
    """
    Serializer para NivelGravedad
    """
    class Meta:
        model = NivelGravedad
        fields = [
            'id', 'codigo', 'nombre', 'orden',
            'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en']

    def validate_codigo(self, value):
        """Validar que el código no esté vacío y sea único"""
        if not value or not value.strip():
            raise serializers.ValidationError("El código no puede estar vacío.")
        
        # Verificar unicidad excluyendo el objeto actual en caso de actualización
        queryset = NivelGravedad.objects.filter(codigo=value.upper().strip())
        if self.instance:
            queryset = queryset.exclude(pk=self.instance.pk)
        
        if queryset.exists():
            raise serializers.ValidationError("Ya existe un nivel de gravedad con este código.")
        
        return value.upper().strip()

    def validate_nombre(self, value):
        """Validar que el nombre no esté vacío"""
        if not value or not value.strip():
            raise serializers.ValidationError("El nombre no puede estar vacío.")
        return value.strip()

    def validate_orden(self, value):
        """Validar que el orden sea positivo"""
        if value is None or value <= 0:
            raise serializers.ValidationError("El orden debe ser un número positivo.")
        
        # Verificar unicidad del orden excluyendo el objeto actual en caso de actualización
        queryset = NivelGravedad.objects.filter(orden=value)
        if self.instance:
            queryset = queryset.exclude(pk=self.instance.pk)
        
        if queryset.exists():
            raise serializers.ValidationError("Ya existe un nivel de gravedad con este orden.")
        
        return value


class EstadoEventoSerializer(serializers.ModelSerializer):
    """
    Serializer para EstadoEvento
    """
    class Meta:
        model = EstadoEvento
        fields = [
            'id', 'codigo', 'nombre',
            'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en']

    def validate_codigo(self, value):
        """Validar que el código no esté vacío y sea único"""
        if not value.strip():
            raise serializers.ValidationError("El código no puede estar vacío.")
        return value.upper().strip()


class EventoRutaAfectadaSerializer(serializers.ModelSerializer):
    """
    Serializer para EventoRutaAfectada
    """
    class Meta:
        model = EventoRutaAfectada
        fields = [
            'id', 'evento', 'sistema_origen', 'ruta_id_externo',
            'ruta_codigo', 'ruta_nombre', 'relevancia',
            'creado_en', 'actualizado_en'
        ]
        read_only_fields = ['id', 'creado_en', 'actualizado_en']

    def validate_sistema_origen(self, value):
        """Validar que el sistema origen no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El sistema origen no puede estar vacío.")
        return value.strip()

    def validate_ruta_id_externo(self, value):
        """Validar que el ID externo de ruta no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El ID externo de ruta no puede estar vacío.")
        return value.strip()


class EventoTraficoSerializer(serializers.ModelSerializer):
    """
    Serializer para EventoTrafico con información completa
    """
    # Campos anidados para mostrar información de las relaciones
    tipo_info = TipoEventoSerializer(source='tipo', read_only=True)
    gravedad_info = NivelGravedadSerializer(source='gravedad', read_only=True)
    estado_info = EstadoEventoSerializer(source='estado', read_only=True)
    rutas_afectadas = EventoRutaAfectadaSerializer(many=True, read_only=True)
    
    # Campos calculados
    dias_desde_ocurrencia = serializers.SerializerMethodField()
    esta_vigente = serializers.SerializerMethodField()

    class Meta:
        model = EventoTrafico
        fields = [
            'id', 'titulo', 'descripcion',
            'tipo', 'tipo_info',
            'gravedad', 'gravedad_info',
            'estado', 'estado_info',
            'latitud', 'longitud', 'radio_metros',
            'fecha_ocurrencia', 'fecha_reporte', 'expira_en',
            'viaje_id_externo', 'viaje_sistema_origen',
            'vehiculo_id_externo', 'conductor_id_externo',
            'correlacion_id',
            'creado_por_id_externo', 'creado_por_username',
            'actualizado_por_id_externo', 'actualizado_por_username',
            'creado_en', 'actualizado_en', 'eliminado_en',
            'rutas_afectadas',
            'dias_desde_ocurrencia', 'esta_vigente'
        ]
        read_only_fields = [
            'id', 'correlacion_id', 'creado_en', 'actualizado_en',
            'rutas_afectadas', 'dias_desde_ocurrencia', 'esta_vigente'
        ]

    def get_dias_desde_ocurrencia(self, obj):
        """Calcular días desde la ocurrencia del evento"""
        if obj.fecha_ocurrencia:
            delta = timezone.now() - obj.fecha_ocurrencia
            return delta.days
        return None

    def get_esta_vigente(self, obj):
        """Verificar si el evento está vigente"""
        if obj.expira_en:
            return timezone.now() <= obj.expira_en
        return True  # Si no tiene fecha de expiración, se considera vigente

    def validate_titulo(self, value):
        """Validar que el título no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El título no puede estar vacío.")
        return value.strip()

    def validate_descripcion(self, value):
        """Validar que la descripción no esté vacía"""
        if not value.strip():
            raise serializers.ValidationError("La descripción no puede estar vacía.")
        return value.strip()

    def validate_latitud(self, value):
        """Validar que la latitud esté en el rango válido"""
        if not (-90 <= value <= 90):
            raise serializers.ValidationError("La latitud debe estar entre -90 y 90.")
        return value

    def validate_longitud(self, value):
        """Validar que la longitud esté en el rango válido"""
        if not (-180 <= value <= 180):
            raise serializers.ValidationError("La longitud debe estar entre -180 y 180.")
        return value

    def validate_radio_metros(self, value):
        """Validar que el radio sea positivo"""
        if value <= 0:
            raise serializers.ValidationError("El radio debe ser un número positivo.")
        return value

    def validate(self, data):
        """Validaciones a nivel de objeto"""
        # Validar que la fecha de ocurrencia no sea futura
        if data.get('fecha_ocurrencia') and data['fecha_ocurrencia'] > timezone.now():
            raise serializers.ValidationError({
                'fecha_ocurrencia': 'La fecha de ocurrencia no puede ser futura.'
            })

        # Validar que la fecha de expiración sea posterior a la ocurrencia
        if (data.get('expira_en') and data.get('fecha_ocurrencia') and 
            data['expira_en'] <= data['fecha_ocurrencia']):
            raise serializers.ValidationError({
                'expira_en': 'La fecha de expiración debe ser posterior a la fecha de ocurrencia.'
            })

        return data


class EventoTraficoSimpleSerializer(serializers.ModelSerializer):
    """
    Serializer simplificado para EventoTrafico para listados
    """
    tipo_nombre = serializers.CharField(source='tipo.nombre', read_only=True)
    gravedad_nombre = serializers.CharField(source='gravedad.nombre', read_only=True)
    estado_nombre = serializers.CharField(source='estado.nombre', read_only=True)
    esta_vigente = serializers.SerializerMethodField()

    class Meta:
        model = EventoTrafico
        fields = [
            'id', 'titulo', 'tipo_nombre', 'gravedad_nombre', 'estado_nombre',
            'latitud', 'longitud', 'fecha_ocurrencia', 'expira_en',
            'esta_vigente', 'creado_en'
        ]

    def get_esta_vigente(self, obj):
        """Verificar si el evento está vigente"""
        if obj.expira_en:
            return timezone.now() <= obj.expira_en
        return True


class EventoTraficoCreateUpdateSerializer(serializers.ModelSerializer):
    """
    Serializer para crear y actualizar EventoTrafico sin campos anidados
    """
    class Meta:
        model = EventoTrafico
        fields = [
            'titulo', 'descripcion',
            'tipo', 'gravedad', 'estado',
            'latitud', 'longitud', 'radio_metros',
            'fecha_ocurrencia', 'fecha_reporte', 'expira_en',
            'viaje_id_externo', 'viaje_sistema_origen',
            'vehiculo_id_externo', 'conductor_id_externo',
            'creado_por_id_externo', 'creado_por_username',
            'actualizado_por_id_externo', 'actualizado_por_username'
        ]

    def validate_titulo(self, value):
        """Validar que el título no esté vacío"""
        if not value.strip():
            raise serializers.ValidationError("El título no puede estar vacío.")
        return value.strip()

    def validate_descripcion(self, value):
        """Validar que la descripción no esté vacía"""
        if not value.strip():
            raise serializers.ValidationError("La descripción no puede estar vacía.")
        return value.strip()

    def validate_latitud(self, value):
        """Validar que la latitud esté en el rango válido"""
        if not (-90 <= value <= 90):
            raise serializers.ValidationError("La latitud debe estar entre -90 y 90.")
        return value

    def validate_longitud(self, value):
        """Validar que la longitud esté en el rango válido"""
        if not (-180 <= value <= 180):
            raise serializers.ValidationError("La longitud debe estar entre -180 y 180.")
        return value

    def validate_radio_metros(self, value):
        """Validar que el radio sea positivo"""
        if value <= 0:
            raise serializers.ValidationError("El radio debe ser un número positivo.")
        return value

    def validate(self, data):
        """Validaciones a nivel de objeto"""
        # Validar que la fecha de ocurrencia no sea futura
        if data.get('fecha_ocurrencia') and data['fecha_ocurrencia'] > timezone.now():
            raise serializers.ValidationError({
                'fecha_ocurrencia': 'La fecha de ocurrencia no puede ser futura.'
            })

        # Validar que la fecha de expiración sea posterior a la ocurrencia
        if (data.get('expira_en') and data.get('fecha_ocurrencia') and 
            data['expira_en'] <= data['fecha_ocurrencia']):
            raise serializers.ValidationError({
                'expira_en': 'La fecha de expiración debe ser posterior a la fecha de ocurrencia.'
            })

        return data


class UserRegistrationSerializer(serializers.ModelSerializer):
    """
    Serializer para el registro de nuevos usuarios
    """
    password = serializers.CharField(
        write_only=True,
        min_length=8,
        help_text="Contraseña (mínimo 8 caracteres)"
    )
    password_confirm = serializers.CharField(
        write_only=True,
        help_text="Confirmación de contraseña"
    )

    class Meta:
        model = User
        fields = ["id", "username", "email", "password", "password_confirm", "date_joined"]
        read_only_fields = ["id", "date_joined"]

    def validate_username(self, value):
        """Validar que el username no esté vacío y sea único"""
        if not value or not value.strip():
            raise serializers.ValidationError("El nombre de usuario no puede estar vacío.")
        
        value = value.strip().lower()
        
        # Verificar que no exista otro usuario con el mismo username
        if User.objects.filter(username=value).exists():
            raise serializers.ValidationError("Este nombre de usuario ya está en uso.")
        
        return value

    def validate_email(self, value):
        """Validar que el email sea válido y único"""
        if not value or not value.strip():
            raise serializers.ValidationError("El email es requerido.")
        
        value = value.strip().lower()
        
        # Verificar que no exista otro usuario con el mismo email
        if User.objects.filter(email=value).exists():
            raise serializers.ValidationError("Este email ya está registrado.")
        
        return value

    def validate_password(self, value):
        """Validar la contraseña usando los validadores de Django"""
        validate_password(value)
        return value

    def validate(self, data):
        """Validar que las contraseñas coincidan"""
        if data["password"] != data["password_confirm"]:
            raise serializers.ValidationError({
                "password_confirm": "Las contraseñas no coinciden."
            })
        return data

    def create(self, validated_data):
        """Crear un nuevo usuario"""
        # Remover password_confirm del diccionario
        validated_data.pop("password_confirm", None)
        
        # Crear el usuario con contraseña hasheada
        user = User.objects.create_user(
            username=validated_data["username"],
            email=validated_data["email"],
            password=validated_data["password"]
        )
        
        return user


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer para mostrar información del usuario (sin password)
    """
    class Meta:
        model = User
        fields = ["id", "username", "email", "date_joined", "is_active"]
        read_only_fields = ["id", "date_joined", "is_active"]


class PointSerializer(serializers.ModelSerializer):
    """
    Serializer específico para el endpoint /points
    Retorna eventos de tráfico como puntos de georeferencia
    """
    type = serializers.CharField(source='tipo.codigo', read_only=True)
    type_name = serializers.CharField(source='tipo.nombre', read_only=True)
    severity = serializers.CharField(source='gravedad.codigo', read_only=True)
    severity_name = serializers.CharField(source='gravedad.nombre', read_only=True)
    severity_level = serializers.IntegerField(source='gravedad.orden', read_only=True)
    status = serializers.CharField(source='estado.codigo', read_only=True)
    status_name = serializers.CharField(source='estado.nombre', read_only=True)
    lat = serializers.DecimalField(source='latitud', max_digits=9, decimal_places=6, read_only=True)
    long = serializers.DecimalField(source='longitud', max_digits=9, decimal_places=6, read_only=True)
    radius_meters = serializers.IntegerField(source='radio_metros', read_only=True)
    occurred_at = serializers.DateTimeField(source='fecha_ocurrencia', read_only=True)
    reported_at = serializers.DateTimeField(source='fecha_reporte', read_only=True)
    expires_at = serializers.DateTimeField(source='expira_en', read_only=True)
    
    class Meta:
        model = EventoTrafico
        fields = [
            'id', 'titulo', 'descripcion',
            'type', 'type_name',
            'severity', 'severity_name', 'severity_level',
            'status', 'status_name',
            'lat', 'long', 'radius_meters',
            'occurred_at', 'reported_at', 'expires_at'
        ]
        read_only_fields = fields
