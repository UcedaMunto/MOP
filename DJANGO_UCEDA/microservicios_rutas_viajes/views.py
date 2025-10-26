from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import Q
from django.utils import timezone
from .models import (
    EmpresaTransporte, Piloto, Autobus, Ruta, RutaGeopunto, Parada,
    AsignacionAutobusRuta, ViajeAutobus, PosicionAutobus
)
from .serializers import (
    EmpresaTransporteSerializer, EmpresaTransporteListSerializer,
    PilotoSerializer, AutobusSerializer, AutobusListSerializer,
    RutaSerializer, RutaListSerializer, RutaGeopuntoSerializer,
    ParadaSerializer, AsignacionAutobusRutaSerializer,
    ViajeAutobusSerializer, PosicionAutobusSerializer
)


class EmpresaTransporteViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de empresas de transporte
    """
    queryset = EmpresaTransporte.objects.all()
    serializer_class = EmpresaTransporteSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['activo']
    search_fields = ['nombre', 'codigo', 'contacto']
    ordering_fields = ['nombre', 'codigo', 'creado_en']
    ordering = ['nombre']

    def get_serializer_class(self):
        """Usar serializer simplificado para listados"""
        if self.action == 'list':
            return EmpresaTransporteListSerializer
        return EmpresaTransporteSerializer

    @action(detail=True, methods=['get'])
    def pilotos(self, request, pk=None):
        """Obtener pilotos de una empresa"""
        empresa = self.get_object()
        pilotos = empresa.pilotos.filter(activo=True)
        serializer = PilotoSerializer(pilotos, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def autobuses(self, request, pk=None):
        """Obtener autobuses de una empresa"""
        empresa = self.get_object()
        autobuses = empresa.autobuses.filter(activo=True)
        serializer = AutobusListSerializer(autobuses, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def rutas(self, request, pk=None):
        """Obtener rutas de una empresa"""
        empresa = self.get_object()
        rutas = empresa.rutas.filter(activo=True)
        serializer = RutaListSerializer(rutas, many=True)
        return Response(serializer.data)


class PilotoViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de pilotos
    """
    queryset = Piloto.objects.select_related('empresa').all()
    serializer_class = PilotoSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['empresa', 'activo', 'licencia_categoria']
    search_fields = ['nombre', 'documento', 'licencia_numero']
    ordering_fields = ['nombre', 'creado_en']
    ordering = ['nombre']

    @action(detail=True, methods=['get'])
    def asignaciones(self, request, pk=None):
        """Obtener asignaciones del piloto"""
        piloto = self.get_object()
        fecha = request.query_params.get('fecha')
        asignaciones = piloto.asignaciones.all()
        
        if fecha:
            asignaciones = asignaciones.filter(fecha=fecha)
        
        serializer = AsignacionAutobusRutaSerializer(asignaciones, many=True)
        return Response(serializer.data)


class AutobusViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de autobuses
    """
    queryset = Autobus.objects.select_related('empresa').all()
    serializer_class = AutobusSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['empresa', 'activo']
    search_fields = ['codigo', 'placa']
    ordering_fields = ['codigo', 'placa', 'creado_en']
    ordering = ['codigo']

    def get_serializer_class(self):
        """Usar serializer simplificado para listados"""
        if self.action == 'list':
            return AutobusListSerializer
        return AutobusSerializer

    @action(detail=True, methods=['get'])
    def asignaciones(self, request, pk=None):
        """Obtener asignaciones del autobús"""
        autobus = self.get_object()
        fecha = request.query_params.get('fecha')
        asignaciones = autobus.asignaciones.all()
        
        if fecha:
            asignaciones = asignaciones.filter(fecha=fecha)
        
        serializer = AsignacionAutobusRutaSerializer(asignaciones, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def ultima_posicion(self, request, pk=None):
        """Obtener la última posición del autobús"""
        autobus = self.get_object()
        posicion = autobus.posiciones.order_by('-capturado_en').first()
        
        if posicion:
            serializer = PosicionAutobusSerializer(posicion)
            return Response(serializer.data)
        return Response({'message': 'No se encontraron posiciones'}, status=status.HTTP_404_NOT_FOUND)


class RutaViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de rutas
    """
    queryset = Ruta.objects.select_related('empresa').prefetch_related('geopuntos', 'paradas').all()
    serializer_class = RutaSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['empresa', 'activo']
    search_fields = ['codigo', 'nombre']
    ordering_fields = ['codigo', 'nombre', 'creado_en']
    ordering = ['codigo']

    def get_serializer_class(self):
        """Usar serializer simplificado para listados"""
        if self.action == 'list':
            return RutaListSerializer
        return RutaSerializer

    @action(detail=True, methods=['get'])
    def paradas(self, request, pk=None):
        """Obtener paradas de la ruta"""
        ruta = self.get_object()
        sentido = request.query_params.get('sentido')
        paradas = ruta.paradas.filter(activo=True)
        
        if sentido:
            paradas = paradas.filter(sentido=sentido.upper())
        
        paradas = paradas.order_by('sentido', 'orden')
        serializer = ParadaSerializer(paradas, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def geopuntos(self, request, pk=None):
        """Obtener puntos geográficos de la ruta"""
        ruta = self.get_object()
        geopuntos = ruta.geopuntos.order_by('orden')
        serializer = RutaGeopuntoSerializer(geopuntos, many=True)
        return Response(serializer.data)


class RutaGeopuntoViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de puntos geográficos de rutas
    """
    queryset = RutaGeopunto.objects.select_related('ruta').all()
    serializer_class = RutaGeopuntoSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = ['ruta']
    ordering_fields = ['ruta', 'orden']
    ordering = ['ruta', 'orden']


class ParadaViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de paradas
    """
    queryset = Parada.objects.select_related('ruta').all()
    serializer_class = ParadaSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['ruta', 'sentido', 'activo']
    search_fields = ['nombre']
    ordering_fields = ['ruta', 'sentido', 'orden', 'nombre']
    ordering = ['ruta', 'sentido', 'orden']

    @action(detail=False, methods=['get'])
    def cercanas(self, request):
        """Buscar paradas cercanas a una coordenada"""
        lat = request.query_params.get('lat')
        lon = request.query_params.get('lon')
        radio = request.query_params.get('radio', 1000)  # metros
        
        if not lat or not lon:
            return Response(
                {'error': 'Se requieren parámetros lat y lon'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            lat = float(lat)
            lon = float(lon)
            radio = float(radio)
        except ValueError:
            return Response(
                {'error': 'Coordenadas inválidas'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Búsqueda básica por rango (no usa funciones geográficas reales)
        delta = radio / 111000  # Aproximación: 1 grado = ~111km
        paradas = self.queryset.filter(
            latitud__range=(lat - delta, lat + delta),
            longitud__range=(lon - delta, lon + delta),
            activo=True
        )
        
        serializer = self.get_serializer(paradas, many=True)
        return Response(serializer.data)


class AsignacionAutobusRutaViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de asignaciones autobús-ruta
    """
    queryset = AsignacionAutobusRuta.objects.select_related(
        'autobus', 'ruta', 'piloto', 'autobus__empresa'
    ).all()
    serializer_class = AsignacionAutobusRutaSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = ['autobus', 'ruta', 'piloto', 'fecha', 'estado']
    ordering_fields = ['fecha', 'hora_inicio', 'creado_en']
    ordering = ['-fecha', 'hora_inicio']

    @action(detail=False, methods=['get'])
    def hoy(self, request):
        """Obtener asignaciones del día actual"""
        hoy = timezone.now().date()
        asignaciones = self.queryset.filter(fecha=hoy)
        serializer = self.get_serializer(asignaciones, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def viajes(self, request, pk=None):
        """Obtener viajes de una asignación"""
        asignacion = self.get_object()
        viajes = asignacion.viajes.order_by('numero_viaje')
        serializer = ViajeAutobusSerializer(viajes, many=True)
        return Response(serializer.data)


class ViajeAutobusViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de viajes de autobús
    """
    queryset = ViajeAutobus.objects.select_related(
        'asignacion', 'autobus', 'ruta', 'piloto', 'parada_inicio', 'parada_fin'
    ).all()
    serializer_class = ViajeAutobusSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = ['asignacion', 'autobus', 'ruta', 'piloto', 'estado']
    ordering_fields = ['inicio_en', 'numero_viaje', 'creado_en']
    ordering = ['-inicio_en']

    @action(detail=False, methods=['get'])
    def activos(self, request):
        """Obtener viajes activos (en curso)"""
        viajes = self.queryset.filter(estado='EN_CURSO')
        serializer = self.get_serializer(viajes, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'])
    def posiciones(self, request, pk=None):
        """Obtener posiciones de un viaje"""
        viaje = self.get_object()
        posiciones = viaje.posiciones.order_by('-capturado_en')
        
        # Limitar resultados para evitar sobrecarga
        limit = request.query_params.get('limit', 100)
        try:
            limit = int(limit)
            posiciones = posiciones[:limit]
        except ValueError:
            pass
        
        serializer = PosicionAutobusSerializer(posiciones, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['post'])
    def finalizar(self, request, pk=None):
        """Finalizar un viaje"""
        viaje = self.get_object()
        
        if viaje.estado != 'EN_CURSO':
            return Response(
                {'error': 'Solo se pueden finalizar viajes en curso'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        viaje.estado = 'FINALIZADO'
        viaje.fin_en = timezone.now()
        viaje.save()
        
        serializer = self.get_serializer(viaje)
        return Response(serializer.data)


class PosicionAutobusViewSet(viewsets.ModelViewSet):
    """
    ViewSet para gestión de posiciones de autobús
    """
    queryset = PosicionAutobus.objects.select_related('viaje', 'autobus').all()
    serializer_class = PosicionAutobusSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_fields = ['viaje', 'autobus', 'fuente']
    ordering_fields = ['capturado_en', 'recibido_en', 'creado_en']
    ordering = ['-capturado_en']

    @action(detail=False, methods=['get'])
    def recientes(self, request):
        """Obtener posiciones recientes (última hora)"""
        hora_atras = timezone.now() - timezone.timedelta(hours=1)
        posiciones = self.queryset.filter(capturado_en__gte=hora_atras)
        serializer = self.get_serializer(posiciones, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['get'])
    def por_autobus(self, request):
        """Obtener última posición de cada autobús"""
        from django.db.models import Max
        
        # Obtener la última posición de cada autobús
        ultimas_posiciones = self.queryset.values('autobus').annotate(
            ultima_captura=Max('capturado_en')
        )
        
        # Filtrar para obtener solo esas posiciones
        posiciones = []
        for item in ultimas_posiciones:
            posicion = self.queryset.filter(
                autobus=item['autobus'],
                capturado_en=item['ultima_captura']
            ).first()
            if posicion:
                posiciones.append(posicion)
        
        serializer = self.get_serializer(posiciones, many=True)
        return Response(serializer.data)