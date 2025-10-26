from django.db import models
from django.utils import timezone
from django.core.validators import MinValueValidator, MaxValueValidator, RegexValidator
from decimal import Decimal
import uuid


class EmpresaTransporte(models.Model):
    """
    Operador de transporte público
    """
    id = models.BigAutoField(primary_key=True)
    nombre = models.CharField(max_length=120, help_text="Nombre de la empresa de transporte")
    codigo = models.CharField(max_length=32, unique=True, help_text="Código único de la empresa")
    contacto = models.CharField(max_length=120, blank=True, help_text="Persona de contacto")
    telefono = models.CharField(max_length=32, blank=True, help_text="Teléfono de contacto")
    activo = models.BooleanField(default=True, help_text="Indica si la empresa está activa")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'empresa_transporte'
        verbose_name = 'Empresa de Transporte'
        verbose_name_plural = 'Empresas de Transporte'
        ordering = ['nombre']
        indexes = [
            models.Index(fields=['codigo']),
            models.Index(fields=['activo']),
            models.Index(fields=['nombre']),
        ]

    def __str__(self):
        return f"{self.codigo} - {self.nombre}"


class Piloto(models.Model):
    """
    Conductor de autobús
    """
    id = models.BigAutoField(primary_key=True)
    empresa = models.ForeignKey(
        EmpresaTransporte,
        on_delete=models.CASCADE,
        related_name='pilotos',
        help_text="Empresa que emplea al piloto"
    )
    nombre = models.CharField(max_length=120, help_text="Nombre completo del piloto")
    documento = models.CharField(max_length=32, help_text="Número de documento de identidad")
    licencia_numero = models.CharField(max_length=32, help_text="Número de licencia de conducir")
    licencia_categoria = models.CharField(max_length=16, help_text="Categoría de la licencia")
    telefono = models.CharField(max_length=32, blank=True, help_text="Teléfono del piloto")
    activo = models.BooleanField(default=True, help_text="Indica si el piloto está activo")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'piloto'
        verbose_name = 'Piloto'
        verbose_name_plural = 'Pilotos'
        ordering = ['nombre']
        indexes = [
            models.Index(fields=['empresa', 'activo']),
            models.Index(fields=['documento']),
            models.Index(fields=['licencia_numero']),
        ]

    def __str__(self):
        return f"{self.nombre} - {self.empresa.codigo}"


class Autobus(models.Model):
    """
    Vehículo de transporte público
    """
    id = models.BigAutoField(primary_key=True)
    empresa = models.ForeignKey(
        EmpresaTransporte,
        on_delete=models.CASCADE,
        related_name='autobuses',
        help_text="Empresa que opera el autobús"
    )
    codigo = models.CharField(max_length=32, unique=True, help_text="Código único del autobús")
    placa = models.CharField(
        max_length=16,
        unique=True,
        help_text="Placa del autobús",
        validators=[RegexValidator(
            regex=r'^[A-Za-z0-9\-]+$',
            message='La placa solo puede contener letras, números y guiones'
        )]
    )
    capacidad = models.PositiveIntegerField(
        help_text="Capacidad de pasajeros",
        validators=[MinValueValidator(1)]
    )
    activo = models.BooleanField(default=True, help_text="Indica si el autobús está activo")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'autobus'
        verbose_name = 'Autobús'
        verbose_name_plural = 'Autobuses'
        ordering = ['codigo']
        indexes = [
            models.Index(fields=['empresa', 'activo']),
            models.Index(fields=['codigo']),
            models.Index(fields=['placa']),
        ]

    def __str__(self):
        return f"{self.codigo} - {self.placa}"


class Ruta(models.Model):
    """
    Ruta de transporte público
    """
    id = models.BigAutoField(primary_key=True)
    empresa = models.ForeignKey(
        EmpresaTransporte,
        on_delete=models.CASCADE,
        related_name='rutas',
        help_text="Empresa que administra la ruta"
    )
    codigo = models.CharField(max_length=32, unique=True, help_text="Código único de la ruta")
    nombre = models.CharField(max_length=120, help_text="Nombre de la ruta")
    descripcion = models.TextField(blank=True, help_text="Descripción de la ruta")
    activo = models.BooleanField(default=True, help_text="Indica si la ruta está activa")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'ruta'
        verbose_name = 'Ruta'
        verbose_name_plural = 'Rutas'
        ordering = ['codigo']
        indexes = [
            models.Index(fields=['empresa', 'activo']),
            models.Index(fields=['codigo']),
            models.Index(fields=['nombre']),
        ]

    def __str__(self):
        return f"{self.codigo} - {self.nombre}"


class RutaGeopunto(models.Model):
    """
    Puntos geográficos que definen la geometría de una ruta
    """
    id = models.BigAutoField(primary_key=True)
    ruta = models.ForeignKey(
        Ruta,
        on_delete=models.CASCADE,
        related_name='geopuntos',
        help_text="Ruta a la que pertenece el punto"
    )
    orden = models.PositiveIntegerField(help_text="Orden del punto en la ruta")
    latitud = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        help_text="Latitud del punto (-90.0 a 90.0)",
        validators=[MinValueValidator(-90.0), MaxValueValidator(90.0)]
    )
    longitud = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        help_text="Longitud del punto (-180.0 a 180.0)",
        validators=[MinValueValidator(-180.0), MaxValueValidator(180.0)]
    )

    class Meta:
        db_table = 'ruta_geopunto'
        verbose_name = 'Punto Geográfico de Ruta'
        verbose_name_plural = 'Puntos Geográficos de Ruta'
        ordering = ['ruta', 'orden']
        indexes = [
            models.Index(fields=['ruta', 'orden']),
            models.Index(fields=['latitud', 'longitud']),
        ]
        unique_together = [['ruta', 'orden']]

    def __str__(self):
        return f"Ruta {self.ruta.codigo} - Punto {self.orden}"


class Parada(models.Model):
    """
    Paradas de transporte público en una ruta
    """
    SENTIDO_CHOICES = [
        ('IDA', 'Ida'),
        ('VUELTA', 'Vuelta'),
    ]

    id = models.BigAutoField(primary_key=True)
    ruta = models.ForeignKey(
        Ruta,
        on_delete=models.CASCADE,
        related_name='paradas',
        help_text="Ruta a la que pertenece la parada"
    )
    nombre = models.CharField(max_length=120, help_text="Nombre de la parada")
    orden = models.PositiveIntegerField(help_text="Orden de la parada en la ruta")
    sentido = models.CharField(
        max_length=16,
        choices=SENTIDO_CHOICES,
        help_text="Sentido de la parada en la ruta"
    )
    latitud = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        help_text="Latitud de la parada",
        validators=[MinValueValidator(-90.0), MaxValueValidator(90.0)]
    )
    longitud = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        help_text="Longitud de la parada",
        validators=[MinValueValidator(-180.0), MaxValueValidator(180.0)]
    )
    activo = models.BooleanField(default=True, help_text="Indica si la parada está activa")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'parada'
        verbose_name = 'Parada'
        verbose_name_plural = 'Paradas'
        ordering = ['ruta', 'sentido', 'orden']
        indexes = [
            models.Index(fields=['ruta', 'sentido', 'orden']),
            models.Index(fields=['latitud', 'longitud']),
            models.Index(fields=['activo']),
        ]

    def __str__(self):
        return f"{self.ruta.codigo} - {self.nombre} ({self.sentido})"


class AsignacionAutobusRuta(models.Model):
    """
    Asignación diaria de autobús a ruta con piloto
    """
    ESTADO_CHOICES = [
        ('PROGRAMADA', 'Programada'),
        ('EN_CURSO', 'En Curso'),
        ('FINALIZADA', 'Finalizada'),
        ('CANCELADA', 'Cancelada'),
    ]

    id = models.BigAutoField(primary_key=True)
    autobus = models.ForeignKey(
        Autobus,
        on_delete=models.CASCADE,
        related_name='asignaciones',
        help_text="Autobús asignado"
    )
    ruta = models.ForeignKey(
        Ruta,
        on_delete=models.CASCADE,
        related_name='asignaciones',
        help_text="Ruta asignada"
    )
    piloto = models.ForeignKey(
        Piloto,
        on_delete=models.CASCADE,
        related_name='asignaciones',
        help_text="Piloto asignado"
    )
    fecha = models.DateField(help_text="Fecha de la asignación")
    hora_inicio = models.TimeField(help_text="Hora de inicio programada")
    hora_fin = models.TimeField(help_text="Hora de fin programada")
    estado = models.CharField(
        max_length=16,
        choices=ESTADO_CHOICES,
        default='PROGRAMADA',
        help_text="Estado de la asignación"
    )
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'asignacion_autobus_ruta'
        verbose_name = 'Asignación Autobús-Ruta'
        verbose_name_plural = 'Asignaciones Autobús-Ruta'
        ordering = ['fecha', 'hora_inicio']
        indexes = [
            models.Index(fields=['autobus', 'fecha']),
            models.Index(fields=['ruta', 'fecha']),
            models.Index(fields=['piloto', 'fecha']),
            models.Index(fields=['fecha', 'estado']),
        ]
        unique_together = [['autobus', 'fecha', 'hora_inicio']]

    def __str__(self):
        return f"{self.autobus.codigo} - {self.ruta.codigo} ({self.fecha})"


class ViajeAutobus(models.Model):
    """
    Viaje histórico de un autobús en una asignación
    """
    ESTADO_CHOICES = [
        ('EN_CURSO', 'En Curso'),
        ('FINALIZADO', 'Finalizado'),
        ('CANCELADO', 'Cancelado'),
    ]

    id = models.BigAutoField(primary_key=True)
    asignacion = models.ForeignKey(
        AsignacionAutobusRuta,
        on_delete=models.CASCADE,
        related_name='viajes',
        help_text="Asignación que genera el viaje"
    )
    autobus = models.ForeignKey(
        Autobus,
        on_delete=models.CASCADE,
        related_name='viajes',
        help_text="Autobús del viaje"
    )
    ruta = models.ForeignKey(
        Ruta,
        on_delete=models.CASCADE,
        related_name='viajes',
        help_text="Ruta del viaje"
    )
    piloto = models.ForeignKey(
        Piloto,
        on_delete=models.CASCADE,
        related_name='viajes',
        help_text="Piloto del viaje"
    )
    numero_viaje = models.PositiveIntegerField(help_text="Número secuencial del viaje en la asignación")
    estado = models.CharField(
        max_length=16,
        choices=ESTADO_CHOICES,
        default='EN_CURSO',
        help_text="Estado del viaje"
    )
    inicio_en = models.DateTimeField(blank=True, null=True, help_text="Fecha y hora de inicio del viaje")
    fin_en = models.DateTimeField(blank=True, null=True, help_text="Fecha y hora de fin del viaje")
    parada_inicio = models.ForeignKey(
        Parada,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='viajes_inicio',
        help_text="Parada de inicio del viaje"
    )
    parada_fin = models.ForeignKey(
        Parada,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='viajes_fin',
        help_text="Parada de fin del viaje"
    )
    distancia_km = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        blank=True,
        null=True,
        help_text="Distancia recorrida en kilómetros",
        validators=[MinValueValidator(0)]
    )
    duracion_min = models.PositiveIntegerField(
        blank=True,
        null=True,
        help_text="Duración del viaje en minutos"
    )
    velocidad_media_kmh = models.DecimalField(
        max_digits=6,
        decimal_places=2,
        blank=True,
        null=True,
        help_text="Velocidad media del viaje en km/h",
        validators=[MinValueValidator(0)]
    )
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'viaje_autobus'
        verbose_name = 'Viaje de Autobús'
        verbose_name_plural = 'Viajes de Autobús'
        ordering = ['asignacion', 'numero_viaje']
        indexes = [
            models.Index(fields=['asignacion', 'numero_viaje']),
            models.Index(fields=['autobus', 'inicio_en']),
            models.Index(fields=['ruta', 'inicio_en']),
            models.Index(fields=['estado']),
            models.Index(fields=['inicio_en', 'fin_en']),
        ]
        unique_together = [['asignacion', 'numero_viaje']]

    def __str__(self):
        return f"Viaje {self.numero_viaje} - {self.autobus.codigo} ({self.estado})"


class PosicionAutobus(models.Model):
    """
    Posición GPS de un autobús durante un viaje
    """
    FUENTE_CHOICES = [
        ('GPS', 'GPS'),
        ('GSM', 'GSM'),
        ('APP', 'Aplicación'),
    ]

    id = models.BigAutoField(primary_key=True)
    viaje = models.ForeignKey(
        ViajeAutobus,
        on_delete=models.CASCADE,
        related_name='posiciones',
        help_text="Viaje al que pertenece la posición"
    )
    autobus = models.ForeignKey(
        Autobus,
        on_delete=models.CASCADE,
        related_name='posiciones',
        help_text="Autobús de la posición"
    )
    latitud = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        help_text="Latitud de la posición",
        validators=[MinValueValidator(-90.0), MaxValueValidator(90.0)]
    )
    longitud = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        help_text="Longitud de la posición",
        validators=[MinValueValidator(-180.0), MaxValueValidator(180.0)]
    )
    velocidad_kmh = models.DecimalField(
        max_digits=6,
        decimal_places=2,
        blank=True,
        null=True,
        help_text="Velocidad en km/h",
        validators=[MinValueValidator(0)]
    )
    rumbo_grados = models.DecimalField(
        max_digits=5,
        decimal_places=1,
        blank=True,
        null=True,
        help_text="Rumbo en grados (0-360)",
        validators=[MinValueValidator(0), MaxValueValidator(360)]
    )
    precision_m = models.DecimalField(
        max_digits=6,
        decimal_places=2,
        blank=True,
        null=True,
        help_text="Precisión en metros",
        validators=[MinValueValidator(0)]
    )
    fuente = models.CharField(
        max_length=24,
        choices=FUENTE_CHOICES,
        default='GPS',
        help_text="Fuente de la posición"
    )
    capturado_en = models.DateTimeField(help_text="Fecha y hora de captura de la posición")
    recibido_en = models.DateTimeField(default=timezone.now, help_text="Fecha y hora de recepción")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")

    class Meta:
        db_table = 'posicion_autobus'
        verbose_name = 'Posición de Autobús'
        verbose_name_plural = 'Posiciones de Autobús'
        ordering = ['viaje', '-capturado_en']
        indexes = [
            models.Index(fields=['viaje', 'capturado_en']),
            models.Index(fields=['autobus', 'capturado_en']),
            models.Index(fields=['latitud', 'longitud']),
            models.Index(fields=['capturado_en']),
        ]

    def __str__(self):
        return f"{self.autobus.codigo} - {self.capturado_en} ({self.latitud}, {self.longitud})"