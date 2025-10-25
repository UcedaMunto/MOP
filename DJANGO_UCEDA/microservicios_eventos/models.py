from django.db import models
from django.utils import timezone


class EventoTrafico(models.Model):
    """
    Modelo para almacenar eventos de tráfico
    """
    TIPO_EVENTO_CHOICES = [
        ('accidente', 'Accidente'),
        ('congestion', 'Congestión'),
        ('obras', 'Obras en la vía'),
        ('incidente', 'Incidente'),
        ('clima', 'Condiciones climáticas'),
    ]
    
    ESTADO_CHOICES = [
        ('activo', 'Activo'),
        ('resuelto', 'Resuelto'),
        ('en_proceso', 'En Proceso'),
    ]
    
    id = models.AutoField(primary_key=True)
    tipo_evento = models.CharField(
        max_length=20, 
        choices=TIPO_EVENTO_CHOICES,
        help_text="Tipo de evento de tráfico"
    )
    descripcion = models.TextField(
        help_text="Descripción detallada del evento"
    )
    ubicacion = models.CharField(
        max_length=255,
        help_text="Ubicación del evento"
    )
    latitud = models.DecimalField(
        max_digits=10, 
        decimal_places=8,
        null=True,
        blank=True,
        help_text="Coordenada de latitud"
    )
    longitud = models.DecimalField(
        max_digits=11, 
        decimal_places=8,
        null=True,
        blank=True,
        help_text="Coordenada de longitud"
    )
    estado = models.CharField(
        max_length=15,
        choices=ESTADO_CHOICES,
        default='activo',
        help_text="Estado actual del evento"
    )
    fecha_creacion = models.DateTimeField(
        default=timezone.now,
        help_text="Fecha y hora de creación del evento"
    )
    fecha_actualizacion = models.DateTimeField(
        auto_now=True,
        help_text="Fecha y hora de última actualización"
    )
    fecha_resolucion = models.DateTimeField(
        null=True,
        blank=True,
        help_text="Fecha y hora de resolución del evento"
    )
    prioridad = models.IntegerField(
        default=1,
        choices=[(1, 'Baja'), (2, 'Media'), (3, 'Alta'), (4, 'Crítica')],
        help_text="Nivel de prioridad del evento"
    )
    reportado_por = models.CharField(
        max_length=100,
        blank=True,
        help_text="Usuario o sistema que reportó el evento"
    )
    
    class Meta:
        db_table = 'eventos_trafico'
        verbose_name = 'Evento de Tráfico'
        verbose_name_plural = 'Eventos de Tráfico'
        ordering = ['-fecha_creacion']
        indexes = [
            models.Index(fields=['tipo_evento']),
            models.Index(fields=['estado']),
            models.Index(fields=['fecha_creacion']),
            models.Index(fields=['ubicacion']),
        ]
    
    def __str__(self):
        return f"{self.get_tipo_evento_display()} - {self.ubicacion} ({self.estado})"
    
    def save(self, *args, **kwargs):
        # Actualizar fecha_resolucion cuando se cambia el estado a resuelto
        if self.estado == 'resuelto' and not self.fecha_resolucion:
            self.fecha_resolucion = timezone.now()
        super().save(*args, **kwargs)