from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.utils.decorators import method_decorator
from django.views import View
from .models import EventoTrafico
import json


class EventoTraficoListView(View):
    """
    Vista para listar todos los eventos de tráfico
    """
    def get(self, request):
        eventos = EventoTrafico.objects.all()
        data = []
        for evento in eventos:
            data.append({
                'id': evento.id,
                'tipo_evento': evento.tipo_evento,
                'descripcion': evento.descripcion,
                'ubicacion': evento.ubicacion,
                'estado': evento.estado,
                'fecha_creacion': evento.fecha_creacion.isoformat(),
                'prioridad': evento.prioridad,
            })
        return JsonResponse({'eventos': data})


@method_decorator(csrf_exempt, name='dispatch')
class EventoTraficoCreateView(View):
    """
    Vista para crear nuevos eventos de tráfico
    """
    def post(self, request):
        try:
            data = json.loads(request.body)
            evento = EventoTrafico.objects.create(
                tipo_evento=data.get('tipo_evento'),
                descripcion=data.get('descripcion'),
                ubicacion=data.get('ubicacion'),
                latitud=data.get('latitud'),
                longitud=data.get('longitud'),
                prioridad=data.get('prioridad', 1),
                reportado_por=data.get('reportado_por', 'Sistema')
            )
            return JsonResponse({
                'mensaje': 'Evento creado exitosamente',
                'evento_id': evento.id
            }, status=201)
        except Exception as e:
            return JsonResponse({
                'error': str(e)
            }, status=400)


def evento_detail_view(request, evento_id):
    """
    Vista para obtener detalles de un evento específico
    """
    try:
        evento = EventoTrafico.objects.get(id=evento_id)
        data = {
            'id': evento.id,
            'tipo_evento': evento.tipo_evento,
            'descripcion': evento.descripcion,
            'ubicacion': evento.ubicacion,
            'latitud': str(evento.latitud) if evento.latitud else None,
            'longitud': str(evento.longitud) if evento.longitud else None,
            'estado': evento.estado,
            'fecha_creacion': evento.fecha_creacion.isoformat(),
            'fecha_actualizacion': evento.fecha_actualizacion.isoformat(),
            'fecha_resolucion': evento.fecha_resolucion.isoformat() if evento.fecha_resolucion else None,
            'prioridad': evento.prioridad,
            'reportado_por': evento.reportado_por,
        }
        return JsonResponse(data)
    except EventoTrafico.DoesNotExist:
        return JsonResponse({'error': 'Evento no encontrado'}, status=404)


def health_check(request):
    """
    Vista simple para verificar el estado de la aplicación
    """
    return JsonResponse({
        'status': 'OK',
        'app': 'microservicios_eventos',
        'database': 'eventos_trafico'
    })