from django.shortcuts import render
from django.http import JsonResponse
from django.utils import timezone
from django.db.models import Q, Count
from rest_framework import viewsets, status, filters
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAuthenticated
from rest_framework.pagination import PageNumberPagination
import json
import math
from decimal import Decimal

from .models import TipoEvento, NivelGravedad, EstadoEvento, EventoTrafico, EventoRutaAfectada
from .serializers import (
    TipoEventoSerializer,
    NivelGravedadSerializer, 
    EstadoEventoSerializer,
    EventoTraficoSerializer,
    EventoTraficoSimpleSerializer,
    EventoTraficoCreateUpdateSerializer,
    EventoRutaAfectadaSerializer,
    UserRegistrationSerializer,
    UserSerializer,
    PointSerializer
)
from .filters import (
    TipoEventoFilter,
    NivelGravedadFilter,
    EstadoEventoFilter,
    EventoTraficoFilter,
    EventoRutaAfectadaFilter
)
from .permissions import (
    CanManageCatalogs,
    CanManageEvents,
    CanManageRoutes,
    IsOwnerOrReadOnly
)
from drf_spectacular.utils import extend_schema, extend_schema_view, OpenApiParameter, OpenApiExample
from drf_spectacular.types import OpenApiTypes


# Paginación personalizada para eventos
class EventoPagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = 'page_size'
    max_page_size = 100
    
    def get_paginated_response(self, data):
        return Response({
            'pagination': {
                'count': self.page.paginator.count,
                'next': self.get_next_link(),
                'previous': self.get_previous_link(),
                'page_size': self.page_size,
                'current_page': self.page.number,
                'total_pages': self.page.paginator.num_pages
            },
            'results': data
        })


# Paginación para catálogos (más pequeña)
class CatalogPagination(PageNumberPagination):
    page_size = 50
    page_size_query_param = 'page_size'
    max_page_size = 200


@extend_schema_view(
    list=extend_schema(
        tags=['Catálogos'],
        summary="Listar tipos de evento",
        description="Obtiene una lista paginada de todos los tipos de evento activos"
    ),
    create=extend_schema(
        tags=['Catálogos'],
        summary="Crear tipo de evento",
        description="Crea un nuevo tipo de evento (requiere permisos de staff)"
    ),
    retrieve=extend_schema(
        tags=['Catálogos'],
        summary="Obtener tipo de evento",
        description="Obtiene los detalles de un tipo de evento específico"
    ),
    update=extend_schema(
        tags=['Catálogos'],
        summary="Actualizar tipo de evento",
        description="Actualiza completamente un tipo de evento (requiere permisos de staff)"
    ),
    partial_update=extend_schema(
        tags=['Catálogos'],
        summary="Actualizar parcialmente tipo de evento",
        description="Actualiza parcialmente un tipo de evento (requiere permisos de staff)"
    ),
    destroy=extend_schema(
        tags=['Catálogos'],
        summary="Eliminar tipo de evento",
        description="Elimina un tipo de evento (requiere permisos de staff)"
    )
)
class TipoEventoViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestionar tipos de eventos
    
    Permite operaciones CRUD completas:
    - GET /tipos-evento/ - Lista todos los tipos de evento
    - POST /tipos-evento/ - Crea un nuevo tipo de evento
    - GET /tipos-evento/{id}/ - Obtiene un tipo de evento específico
    - PUT /tipos-evento/{id}/ - Actualiza completamente un tipo de evento
    - PATCH /tipos-evento/{id}/ - Actualiza parcialmente un tipo de evento
    - DELETE /tipos-evento/{id}/ - Elimina un tipo de evento
    """
    queryset = TipoEvento.objects.filter(activo=True)
    serializer_class = TipoEventoSerializer
    permission_classes = [CanManageCatalogs]
    pagination_class = CatalogPagination
    filterset_class = TipoEventoFilter
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['codigo', 'nombre', 'descripcion']
    ordering_fields = ['codigo', 'nombre', 'creado_en']
    ordering = ['codigo']

    @extend_schema(
        tags=['Catálogos'],
        summary="Listar tipos de evento inactivos",
        description="Obtiene una lista de todos los tipos de evento inactivos"
    )
    @action(detail=False, methods=['get'])
    def inactivos(self, request):
        """Endpoint para obtener tipos de evento inactivos"""
        queryset = TipoEvento.objects.filter(activo=False)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    @extend_schema(
        tags=['Catálogos'],
        summary="Activar tipo de evento",
        description="Cambia el estado de un tipo de evento a activo"
    )
    @action(detail=True, methods=['post'])
    def activar(self, request, pk=None):
        """Activar un tipo de evento"""
        tipo_evento = self.get_object()
        tipo_evento.activo = True
        tipo_evento.save()
        return Response({'mensaje': 'Tipo de evento activado exitosamente'})

    @extend_schema(
        tags=['Catálogos'],
        summary="Desactivar tipo de evento",
        description="Cambia el estado de un tipo de evento a inactivo"
    )
    @action(detail=True, methods=['post'])
    def desactivar(self, request, pk=None):
        """Desactivar un tipo de evento"""
        tipo_evento = self.get_object()
        tipo_evento.activo = False
        tipo_evento.save()
        return Response({'mensaje': 'Tipo de evento desactivado exitosamente'})


@extend_schema_view(
    list=extend_schema(
        tags=['Catálogos'],
        summary="Listar niveles de gravedad",
        description="Obtiene una lista paginada de todos los niveles de gravedad ordenados por orden"
    ),
    create=extend_schema(
        tags=['Catálogos'],
        summary="Crear nivel de gravedad",
        description="Crea un nuevo nivel de gravedad (requiere permisos de staff)"
    ),
    retrieve=extend_schema(
        tags=['Catálogos'],
        summary="Obtener nivel de gravedad",
        description="Obtiene los detalles de un nivel de gravedad específico"
    ),
    update=extend_schema(
        tags=['Catálogos'],
        summary="Actualizar nivel de gravedad",
        description="Actualiza completamente un nivel de gravedad (requiere permisos de staff)"
    ),
    partial_update=extend_schema(
        tags=['Catálogos'],
        summary="Actualizar parcialmente nivel de gravedad",
        description="Actualiza parcialmente un nivel de gravedad (requiere permisos de staff)"
    ),
    destroy=extend_schema(
        tags=['Catálogos'],
        summary="Eliminar nivel de gravedad",
        description="Elimina un nivel de gravedad (requiere permisos de staff)"
    )
)
class NivelGravedadViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestionar niveles de gravedad
    
    Permite operaciones CRUD completas:
    - GET /niveles-gravedad/ - Lista todos los niveles de gravedad
    - POST /niveles-gravedad/ - Crea un nuevo nivel de gravedad
    - GET /niveles-gravedad/{id}/ - Obtiene un nivel de gravedad específico
    - PUT /niveles-gravedad/{id}/ - Actualiza completamente un nivel de gravedad
    - PATCH /niveles-gravedad/{id}/ - Actualiza parcialmente un nivel de gravedad
    - DELETE /niveles-gravedad/{id}/ - Elimina un nivel de gravedad
    """
    queryset = NivelGravedad.objects.all()
    serializer_class = NivelGravedadSerializer
    permission_classes = [CanManageCatalogs]
    pagination_class = CatalogPagination
    filterset_class = NivelGravedadFilter
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['codigo', 'nombre']
    ordering_fields = ['codigo', 'nombre', 'orden', 'creado_en']
    ordering = ['orden']

    @extend_schema(
        tags=['Catálogos'],
        summary="Obtener estadísticas de niveles de gravedad",
        description="Obtiene estadísticas sobre el uso de niveles de gravedad en eventos"
    )
    @action(detail=False, methods=['get'])
    def estadisticas(self, request):
        """Endpoint para obtener estadísticas de niveles de gravedad"""
        estadisticas = self.get_queryset().annotate(
            total_eventos=Count('eventos')
        ).values(
            'id', 'codigo', 'nombre', 'orden', 'total_eventos'
        ).order_by('orden')
        
        return Response({
            'total_niveles': len(estadisticas),
            'niveles': list(estadisticas)
        })

    @extend_schema(
        tags=['Catálogos'],
        summary="Verificar disponibilidad de código",
        description="Verifica si un código está disponible para usar",
        parameters=[
            OpenApiParameter(
                name='codigo',
                type=OpenApiTypes.STR,
                location=OpenApiParameter.QUERY,
                description='Código a verificar',
                required=True
            )
        ]
    )
    @action(detail=False, methods=['get'])
    def verificar_codigo(self, request):
        """Verificar si un código está disponible"""
        codigo = request.query_params.get('codigo', '').strip().upper()
        if not codigo:
            return Response(
                {'error': 'Debe proporcionar un código'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        existe = NivelGravedad.objects.filter(codigo=codigo).exists()
        return Response({
            'codigo': codigo,
            'disponible': not existe,
            'mensaje': 'Código disponible' if not existe else 'Código ya existe'
        })

    @extend_schema(
        tags=['Catálogos'],
        summary="Verificar disponibilidad de orden",
        description="Verifica si un orden está disponible para usar",
        parameters=[
            OpenApiParameter(
                name='orden',
                type=OpenApiTypes.INT,
                location=OpenApiParameter.QUERY,
                description='Orden a verificar',
                required=True
            )
        ]
    )
    @action(detail=False, methods=['get'])
    def verificar_orden(self, request):
        """Verificar si un orden está disponible"""
        try:
            orden = int(request.query_params.get('orden', 0))
        except (ValueError, TypeError):
            return Response(
                {'error': 'El orden debe ser un número válido'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        if orden <= 0:
            return Response(
                {'error': 'El orden debe ser un número positivo'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        existe = NivelGravedad.objects.filter(orden=orden).exists()
        return Response({
            'orden': orden,
            'disponible': not existe,
            'mensaje': 'Orden disponible' if not existe else 'Orden ya existe'
        })


class EstadoEventoViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestionar estados de eventos
    
    Permite operaciones CRUD completas
    """
    queryset = EstadoEvento.objects.all()
    serializer_class = EstadoEventoSerializer
    permission_classes = [CanManageCatalogs]
    pagination_class = CatalogPagination
    filterset_class = EstadoEventoFilter
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['codigo', 'nombre']
    ordering_fields = ['codigo', 'nombre', 'creado_en']
    ordering = ['codigo']


@extend_schema_view(
    list=extend_schema(
        tags=['Eventos'],
        summary="Listar eventos de tráfico",
        description="Obtiene una lista paginada de eventos de tráfico con filtros avanzados",
        parameters=[
            OpenApiParameter('tipo_codigo', OpenApiTypes.STR, description='Filtrar por código de tipo'),
            OpenApiParameter('estado_codigo', OpenApiTypes.STR, description='Filtrar por código de estado'),
            OpenApiParameter('gravedad_codigo', OpenApiTypes.STR, description='Filtrar por código de gravedad'),
            OpenApiParameter('fecha_ocurrencia_desde', OpenApiTypes.DATETIME, description='Eventos desde esta fecha'),
            OpenApiParameter('fecha_ocurrencia_hasta', OpenApiTypes.DATETIME, description='Eventos hasta esta fecha'),
            OpenApiParameter('lat', OpenApiTypes.DECIMAL, description='Latitud para filtro geográfico'),
            OpenApiParameter('lng', OpenApiTypes.DECIMAL, description='Longitud para filtro geográfico'),
            OpenApiParameter('radio', OpenApiTypes.INT, description='Radio en metros para filtro geográfico'),
            OpenApiParameter('vigentes', OpenApiTypes.BOOL, description='Solo eventos vigentes (no expirados)'),
            OpenApiParameter('search', OpenApiTypes.STR, description='Búsqueda en título y descripción'),
        ]
    ),
    create=extend_schema(
        tags=['Eventos'],
        summary="Crear evento de tráfico",
        description="Crea un nuevo evento de tráfico (requiere autenticación)"
    ),
    retrieve=extend_schema(
        tags=['Eventos'],
        summary="Obtener evento de tráfico",
        description="Obtiene los detalles completos de un evento de tráfico específico"
    ),
    update=extend_schema(
        tags=['Eventos'],
        summary="Actualizar evento de tráfico",
        description="Actualiza completamente un evento de tráfico (requiere autenticación)"
    ),
    partial_update=extend_schema(
        tags=['Eventos'],
        summary="Actualizar parcialmente evento",
        description="Actualiza parcialmente un evento de tráfico (requiere autenticación)"
    ),
    destroy=extend_schema(
        tags=['Eventos'],
        summary="Eliminar evento de tráfico",
        description="Eliminación lógica de un evento de tráfico (requiere autenticación/staff)"
    )
)
class EventoTraficoViewSet(viewsets.ModelViewSet):
    """
    ViewSet principal para gestionar eventos de tráfico
    
    Proporciona API REST completa con funcionalidades específicas:
    - Filtrado por ubicación geográfica
    - Búsqueda por fechas
    - Estados y tipos
    - Endpoints personalizados para casos de uso específicos
    """
    queryset = EventoTrafico.objects.filter(eliminado_en__isnull=True)
    permission_classes = [CanManageEvents]
    pagination_class = EventoPagination
    filterset_class = EventoTraficoFilter
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['titulo', 'descripcion', 'tipo__nombre', 'estado__nombre']
    ordering_fields = [
        'fecha_ocurrencia', 'fecha_reporte', 'creado_en', 
        'tipo__nombre', 'gravedad__orden', 'estado__nombre'
    ]
    ordering = ['-fecha_ocurrencia']

    def get_serializer_class(self):
        """Usar diferentes serializers según la acción"""
        if self.action == 'list':
            return EventoTraficoSimpleSerializer
        elif self.action in ['create', 'update', 'partial_update']:
            return EventoTraficoCreateUpdateSerializer
        return EventoTraficoSerializer

    def get_queryset(self):
        """Aplicar filtros personalizados"""
        queryset = super().get_queryset()
        
        # Filtrar por tipo de evento
        tipo = self.request.query_params.get('tipo', None)
        if tipo is not None:
            queryset = queryset.filter(tipo__codigo=tipo)
        
        # Filtrar por estado
        estado = self.request.query_params.get('estado', None)
        if estado is not None:
            queryset = queryset.filter(estado__codigo=estado)
        
        # Filtrar por gravedad
        gravedad = self.request.query_params.get('gravedad', None)
        if gravedad is not None:
            queryset = queryset.filter(gravedad__codigo=gravedad)
        
        # Filtrar por rango de fechas
        fecha_desde = self.request.query_params.get('fecha_desde', None)
        fecha_hasta = self.request.query_params.get('fecha_hasta', None)
        
        if fecha_desde:
            try:
                fecha_desde = timezone.datetime.fromisoformat(fecha_desde.replace('Z', '+00:00'))
                queryset = queryset.filter(fecha_ocurrencia__gte=fecha_desde)
            except ValueError:
                pass
        
        if fecha_hasta:
            try:
                fecha_hasta = timezone.datetime.fromisoformat(fecha_hasta.replace('Z', '+00:00'))
                queryset = queryset.filter(fecha_ocurrencia__lte=fecha_hasta)
            except ValueError:
                pass
        
        # Filtrar por ubicación (dentro de un radio)
        lat = self.request.query_params.get('lat', None)
        lng = self.request.query_params.get('lng', None)
        radio = self.request.query_params.get('radio', None)
        
        if lat and lng and radio:
            try:
                lat = Decimal(lat)
                lng = Decimal(lng)
                radio = Decimal(radio)
                # Filtro básico por coordenadas (se puede mejorar con PostGIS)
                queryset = queryset.filter(
                    latitud__range=[lat - radio/111000, lat + radio/111000],
                    longitud__range=[lng - radio/111000, lng + radio/111000]
                )
            except (ValueError, TypeError):
                pass
        
        # Filtrar eventos vigentes
        solo_vigentes = self.request.query_params.get('vigentes', None)
        if solo_vigentes and solo_vigentes.lower() == 'true':
            queryset = queryset.filter(
                Q(expira_en__isnull=True) | Q(expira_en__gt=timezone.now())
            )
        
        return queryset.select_related('tipo', 'gravedad', 'estado')

    @action(detail=False, methods=['get'])
    def activos(self, request):
        """Obtener solo eventos activos/vigentes"""
        queryset = self.get_queryset().filter(
            Q(expira_en__isnull=True) | Q(expira_en__gt=timezone.now())
        )
        serializer = EventoTraficoSimpleSerializer(queryset, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['get'])
    def por_ubicacion(self, request):
        """Obtener eventos cerca de una ubicación específica"""
        lat = request.query_params.get('lat')
        lng = request.query_params.get('lng')
        radio = request.query_params.get('radio', '1000')  # Radio en metros
        
        if not lat or not lng:
            return Response(
                {'error': 'Se requieren parámetros lat y lng'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            lat = Decimal(lat)
            lng = Decimal(lng)
            radio = Decimal(radio)
            
            # Conversión básica: 1 grado ≈ 111km
            radio_grados = radio / Decimal('111000')
            
            queryset = self.get_queryset().filter(
                latitud__range=[lat - radio_grados, lat + radio_grados],
                longitud__range=[lng - radio_grados, lng + radio_grados]
            )
            
            serializer = EventoTraficoSimpleSerializer(queryset, many=True)
            return Response(serializer.data)
            
        except (ValueError, TypeError):
            return Response(
                {'error': 'Coordenadas o radio inválidos'}, 
                status=status.HTTP_400_BAD_REQUEST
            )

    @action(detail=False, methods=['get'])
    def estadisticas(self, request):
        """Obtener estadísticas de eventos"""
        queryset = self.get_queryset()
        
        # Estadísticas por tipo
        tipos_stats = {}
        for evento in queryset:
            tipo = evento.tipo.nombre
            tipos_stats[tipo] = tipos_stats.get(tipo, 0) + 1
        
        # Estadísticas por estado
        estados_stats = {}
        for evento in queryset:
            estado = evento.estado.nombre
            estados_stats[estado] = estados_stats.get(estado, 0) + 1
        
        # Eventos vigentes
        vigentes = queryset.filter(
            Q(expira_en__isnull=True) | Q(expira_en__gt=timezone.now())
        ).count()
        
        return Response({
            'total_eventos': queryset.count(),
            'eventos_vigentes': vigentes,
            'por_tipo': tipos_stats,
            'por_estado': estados_stats
        })

    @action(detail=True, methods=['post'])
    def marcar_resuelto(self, request, pk=None):
        """Marcar un evento como resuelto"""
        evento = self.get_object()
        try:
            estado_resuelto = EstadoEvento.objects.get(codigo='RESUELTO')
            evento.estado = estado_resuelto
            evento.save()
            return Response({'mensaje': 'Evento marcado como resuelto'})
        except EstadoEvento.DoesNotExist:
            return Response(
                {'error': 'Estado RESUELTO no encontrado'}, 
                status=status.HTTP_400_BAD_REQUEST
            )

    def perform_destroy(self, instance):
        """Eliminación lógica en lugar de física"""
        instance.eliminado_en = timezone.now()
        instance.save()


class EventoRutaAfectadaViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestionar rutas afectadas por eventos
    """
    queryset = EventoRutaAfectada.objects.all()
    serializer_class = EventoRutaAfectadaSerializer
    permission_classes = [CanManageRoutes]
    filterset_class = EventoRutaAfectadaFilter
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['ruta_codigo', 'ruta_nombre', 'sistema_origen']
    ordering_fields = ['creado_en', 'relevancia']
    ordering = ['-creado_en']

    def get_queryset(self):
        """Filtrar por evento si se proporciona"""
        queryset = super().get_queryset()
        evento_id = self.request.query_params.get('evento', None)
        if evento_id is not None:
            queryset = queryset.filter(evento_id=evento_id)
        return queryset.select_related('evento')





def home(request):
    """
    Vista principal que renderiza el home con opciones para gestionar las tablas
    """
    return render(request, 'home.html')


def health_check(request):
    """
    Vista simple para verificar el estado de la aplicación
    """
    return JsonResponse({
        'status': 'OK',
        'app': 'microservicios_eventos',
        'database': 'eventos_trafico',
        'timestamp': timezone.now().isoformat()
    })

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny

@extend_schema(
    operation_id="register_user",
    summary="Registrar nuevo usuario",
    description="Crea un nuevo usuario en el sistema. Recibe username, password y email en el cuerpo de la petición.",
    request=UserRegistrationSerializer,
    responses={
        201: UserSerializer,
        400: OpenApiExample(
            name="Error de validación",
            value={
                "username": ["Este nombre de usuario ya está en uso."],
                "email": ["Este email ya está registrado."],
                "password": ["Esta contraseña es demasiado común."]
            }
        )
    },
    tags=["Autenticación"]
)
@api_view(["POST"])
@permission_classes([AllowAny])
def register_user(request):
    """
    Endpoint para registrar un nuevo usuario
    
    POST /api/register/
    
    Body:
    {
        "username": "usuario123",
        "email": "usuario@email.com", 
        "password": "contraseña123",
        "password_confirm": "contraseña123"
    }
    
    Response:
    {
        "id": 1,
        "username": "usuario123",
        "email": "usuario@email.com",
        "date_joined": "2024-01-01T12:00:00Z",
        "is_active": true
    }
    """
    if request.method == "POST":
        serializer = UserRegistrationSerializer(data=request.data)
        
        if serializer.is_valid():
            # Crear el usuario
            user = serializer.save()
            
            # Retornar los datos del usuario sin la contraseña
            user_serializer = UserSerializer(user)
            
            return Response(
                {
                    "message": "Usuario registrado exitosamente",
                    "user": user_serializer.data
                },
                status=status.HTTP_201_CREATED
            )
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    return Response(
        {"detail": "Método no permitido"}, 
        status=status.HTTP_405_METHOD_NOT_ALLOWED
    )


# Función utilitaria para calcular distancia entre dos puntos usando la fórmula de Haversine
def calculate_distance(lat1, lon1, lat2, lon2):
    """
    Calcula la distancia entre dos puntos geográficos usando la fórmula de Haversine
    Retorna la distancia en kilómetros
    """
    # Convertir a radianes
    lat1, lon1, lat2, lon2 = map(math.radians, [float(lat1), float(lon1), float(lat2), float(lon2)])
    
    # Fórmula de Haversine
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = math.sin(dlat/2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon/2)**2
    c = 2 * math.asin(math.sqrt(a))
    
    # Radio de la Tierra en kilómetros
    earth_radius_km = 6371
    
    return c * earth_radius_km


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@extend_schema(
    operation_id='list_traffic_points',
    summary='Obtener puntos de georeferencia de eventos de tráfico',
    description='Retorna una lista de todos los eventos de tráfico como puntos de georeferencia. '
                'Soporta filtrado opcional por tipo, ubicación y proximidad.',
    parameters=[
        OpenApiParameter(
            name='type',
            description='Filtrar por tipo de evento (código del tipo)',
            required=False,
            type=OpenApiTypes.STR,
            location=OpenApiParameter.QUERY,
            examples=[
                OpenApiExample('Accidente', value='ACCIDENTE'),
                OpenApiExample('Construcción', value='CONSTRUCCION'),
            ]
        ),
        OpenApiParameter(
            name='lat',
            description='Latitud para filtrar eventos cercanos (debe usarse con long y radius)',
            required=False,
            type=OpenApiTypes.NUMBER,
            location=OpenApiParameter.QUERY,
            examples=[
                OpenApiExample('Latitud ejemplo', value=40.7128),
            ]
        ),
        OpenApiParameter(
            name='long',
            description='Longitud para filtrar eventos cercanos (debe usarse con lat y radius)',
            required=False,
            type=OpenApiTypes.NUMBER,
            location=OpenApiParameter.QUERY,
            examples=[
                OpenApiExample('Longitud ejemplo', value=-74.0060),
            ]
        ),
        OpenApiParameter(
            name='radius',
            description='Radio en kilómetros para filtrar eventos cercanos (debe usarse con lat y long)',
            required=False,
            type=OpenApiTypes.NUMBER,
            location=OpenApiParameter.QUERY,
            examples=[
                OpenApiExample('Radio 10km', value=10),
                OpenApiExample('Radio 50km', value=50),
            ]
        ),
    ],
    responses={
        200: PointSerializer(many=True),
        401: 'No autenticado',
    }
)
def points_list(request):
    """
    GET /points: Retorna una lista de todos los puntos de georeferencia de eventos de tráfico.
    Soporta filtrado opcional por tipo y proximidad geográfica.
    """
    if request.method == 'GET':
        # Obtener todos los eventos de tráfico
        queryset = EventoTrafico.objects.select_related('tipo', 'gravedad', 'estado')
        
        # Filtro por tipo de evento
        event_type = request.GET.get('type')
        if event_type:
            queryset = queryset.filter(tipo__codigo__iexact=event_type)
        
        # Filtros geográficos
        lat = request.GET.get('lat')
        lon = request.GET.get('long')  # long es palabra reservada, usamos lon
        radius = request.GET.get('radius')
        
        # Si se proporcionan parámetros geográficos, filtrar por proximidad
        if lat and lon and radius:
            try:
                lat = float(lat)
                lon = float(lon)
                radius = float(radius)
                
                # Filtrar eventos dentro del radio especificado
                filtered_events = []
                for evento in queryset:
                    distance = calculate_distance(lat, lon, evento.latitud, evento.longitud)
                    if distance <= radius:
                        filtered_events.append(evento.id)
                
                queryset = queryset.filter(id__in=filtered_events)
                
            except (ValueError, TypeError):
                return Response(
                    {"error": "Los parámetros lat, long y radius deben ser números válidos"},
                    status=status.HTTP_400_BAD_REQUEST
                )
        
        # Serializar los resultados
        serializer = PointSerializer(queryset, many=True)
        
        return Response({
            "count": queryset.count(),
            "results": serializer.data
        }, status=status.HTTP_200_OK)
    
    return Response(
        {"detail": "Método no permitido"}, 
        status=status.HTTP_405_METHOD_NOT_ALLOWED
    )
