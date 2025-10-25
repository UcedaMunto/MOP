from django.db import models
from django.utils import timezone
import uuid


class TipoEvento(models.Model):
    """
    Catálogo de tipos de eventos de tráfico
    """
    id = models.SmallAutoField(primary_key=True)
    codigo = models.CharField(max_length=32, unique=True, help_text="Código único del tipo de evento")
    nombre = models.CharField(max_length=64, help_text="Nombre del tipo de evento")
    descripcion = models.TextField(blank=True, help_text="Descripción del tipo de evento")
    activo = models.BooleanField(default=True, help_text="Indica si el tipo de evento está activo")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'tipo_evento'
        verbose_name = 'Tipo de Evento'
        verbose_name_plural = 'Tipos de Evento'
        ordering = ['codigo']
        indexes = [
            models.Index(fields=['codigo']),
            models.Index(fields=['activo']),
        ]

    def __str__(self):
        return f"{self.codigo} - {self.nombre}"


class NivelGravedad(models.Model):
    """
    Catálogo de niveles de gravedad para eventos
    """
    id = models.SmallAutoField(primary_key=True)
    codigo = models.CharField(max_length=16, unique=True, help_text="Código único del nivel")
    nombre = models.CharField(max_length=32, help_text="Nombre del nivel de gravedad")
    orden = models.SmallIntegerField(help_text="Orden del nivel (1=menor, mayor número=más grave)")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'nivel_gravedad'
        verbose_name = 'Nivel de Gravedad'
        verbose_name_plural = 'Niveles de Gravedad'
        ordering = ['orden']
        indexes = [
            models.Index(fields=['codigo']),
            models.Index(fields=['orden']),
        ]

    def __str__(self):
        return f"{self.codigo} - {self.nombre}"


class EstadoEvento(models.Model):
    """
    Catálogo de estados para eventos
    """
    id = models.SmallAutoField(primary_key=True)
    codigo = models.CharField(max_length=16, unique=True, help_text="Código único del estado")
    nombre = models.CharField(max_length=32, help_text="Nombre del estado")
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'estado_evento'
        verbose_name = 'Estado de Evento'
        verbose_name_plural = 'Estados de Evento'
        ordering = ['codigo']
        indexes = [
            models.Index(fields=['codigo']),
        ]

    def __str__(self):
        return f"{self.codigo} - {self.nombre}"


class EventoTrafico(models.Model):
    """
    Evento de tráfico principal con referencias externas a otros microservicios
    """
    id = models.BigAutoField(primary_key=True)
    titulo = models.CharField(max_length=140, help_text="Título del evento")
    descripcion = models.TextField(help_text="Descripción detallada del evento")
    
    # Relaciones con catálogos
    tipo = models.ForeignKey(
        TipoEvento,
        on_delete=models.PROTECT,
        related_name='eventos',
        help_text="Tipo de evento"
    )
    gravedad = models.ForeignKey(
        NivelGravedad, 
        on_delete=models.PROTECT,
        related_name='eventos',
        help_text="Nivel de gravedad"
    )
    estado = models.ForeignKey(
        EstadoEvento,
        on_delete=models.PROTECT,
        related_name='eventos',
        help_text="Estado del evento"
    )
    
    # Coordenadas geográficas
    latitud = models.DecimalField(
        max_digits=9, 
        decimal_places=6,
        help_text="Latitud del evento"
    )
    longitud = models.DecimalField(
        max_digits=9, 
        decimal_places=6,
        help_text="Longitud del evento"
    )
    radio_metros = models.IntegerField(
        help_text="Radio de afectación en metros"
    )
    
    # Fechas
    fecha_ocurrencia = models.DateTimeField(
        default=timezone.now,
        help_text="Fecha y hora de ocurrencia del evento"
    )
    fecha_reporte = models.DateTimeField(
        default=timezone.now,
        help_text="Fecha y hora del reporte"
    )
    expira_en = models.DateTimeField(
        null=True,
        blank=True,
        help_text="Fecha de expiración del evento"
    )
    
    # Referencias externas a otros microservicios (sin FK)
    viaje_id_externo = models.CharField(
        max_length=64,
        null=True,
        blank=True,
        help_text="ID del viaje en MS Transporte"
    )
    viaje_sistema_origen = models.CharField(
        max_length=32,
        null=True,
        blank=True,
        help_text="Sistema origen del viaje (ej: transporte-ms)"
    )
    vehiculo_id_externo = models.CharField(
        max_length=64,
        null=True,
        blank=True,
        help_text="ID del vehículo en MS Transporte"
    )
    conductor_id_externo = models.CharField(
        max_length=64,
        null=True,
        blank=True,
        help_text="ID del conductor en MS Transporte"
    )
    correlacion_id = models.UUIDField(
        null=True,
        blank=True,
        help_text="ID de correlación para trazabilidad entre servicios"
    )
    
    # Referencias a usuarios (IDs externos, sin FK porque viven en otra BD)
    creado_por_id_externo = models.CharField(
        max_length=64,
        null=True,
        blank=True,
        help_text="ID del usuario que creó el evento (referencia externa)"
    )
    creado_por_username = models.CharField(
        max_length=150,
        null=True,
        blank=True,
        help_text="Username del usuario que creó el evento (snapshot)"
    )
    actualizado_por_id_externo = models.CharField(
        max_length=64,
        null=True,
        blank=True,
        help_text="ID del usuario que actualizó el evento (referencia externa)"
    )
    actualizado_por_username = models.CharField(
        max_length=150,
        null=True,
        blank=True,
        help_text="Username del usuario que actualizó el evento (snapshot)"
    )
    
    # Timestamps
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")
    eliminado_en = models.DateTimeField(
        null=True,
        blank=True,
        help_text="Fecha de eliminación lógica"
    )

    class Meta:
        db_table = 'evento_trafico'
        verbose_name = 'Evento de Tráfico'
        verbose_name_plural = 'Eventos de Tráfico'
        ordering = ['-fecha_ocurrencia']
        indexes = [
            models.Index(fields=['tipo']),
            models.Index(fields=['gravedad']),
            models.Index(fields=['estado']),
            models.Index(fields=['fecha_ocurrencia']),
            models.Index(fields=['fecha_reporte']),
            models.Index(fields=['latitud', 'longitud']),
            models.Index(fields=['viaje_id_externo']),
            models.Index(fields=['vehiculo_id_externo']),
            models.Index(fields=['correlacion_id']),
            models.Index(fields=['eliminado_en']),
        ]

    def __str__(self):
        return f"{self.titulo} - {self.tipo.nombre} ({self.estado.nombre})"

    def save(self, *args, **kwargs):
        # Generar correlacion_id si no existe
        if not self.correlacion_id:
            self.correlacion_id = uuid.uuid4()
        super().save(*args, **kwargs)


class EventoRutaAfectada(models.Model):
    """
    Mapeo de rutas afectadas por eventos (IDs externos, sin FK)
    """
    RELEVANCIA_CHOICES = [
        ('PRINCIPAL', 'Principal'),
        ('SECUNDARIA', 'Secundaria'),
    ]
    
    id = models.BigAutoField(primary_key=True)
    evento = models.ForeignKey(
        EventoTrafico,
        on_delete=models.CASCADE,
        related_name='rutas_afectadas',
        help_text="Evento que afecta la ruta"
    )
    
    # Referencias externas (sin FK porque viven en otro MS/BD)
    sistema_origen = models.CharField(
        max_length=32,
        help_text="Sistema origen de la ruta (ej: rutas-ms, SIG)"
    )
    ruta_id_externo = models.CharField(
        max_length=64,
        help_text="ID de la ruta en el sistema externo"
    )
    
    # Snapshots opcionales para búsquedas rápidas
    ruta_codigo = models.CharField(
        max_length=32,
        null=True,
        blank=True,
        help_text="Código de la ruta (snapshot)"
    )
    ruta_nombre = models.CharField(
        max_length=120,
        null=True,
        blank=True,
        help_text="Nombre de la ruta (snapshot)"
    )
    
    relevancia = models.CharField(
        max_length=16,
        choices=RELEVANCIA_CHOICES,
        help_text="Relevancia de la afectación"
    )
    
    creado_en = models.DateTimeField(default=timezone.now, help_text="Fecha de creación")
    actualizado_en = models.DateTimeField(auto_now=True, help_text="Fecha de última actualización")

    class Meta:
        db_table = 'evento_ruta_afectada'
        verbose_name = 'Ruta Afectada por Evento'
        verbose_name_plural = 'Rutas Afectadas por Eventos'
        ordering = ['-creado_en']
        indexes = [
            models.Index(fields=['evento']),
            models.Index(fields=['sistema_origen', 'ruta_id_externo']),
            models.Index(fields=['ruta_codigo']),
            models.Index(fields=['relevancia']),
        ]
        unique_together = [
            ['evento', 'sistema_origen', 'ruta_id_externo']
        ]

    def __str__(self):
        return f"Evento {self.evento.id} - Ruta {self.ruta_codigo or self.ruta_id_externo} ({self.relevancia})"