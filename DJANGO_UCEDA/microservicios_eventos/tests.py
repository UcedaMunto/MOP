from django.test import TestCase
from django.utils import timezone
from .models import EventoTrafico


class EventoTraficoModelTest(TestCase):
    """
    Tests para el modelo EventoTrafico
    """
    
    def setUp(self):
        self.evento = EventoTrafico.objects.create(
            tipo_evento='accidente',
            descripcion='Accidente en autopista',
            ubicacion='Km 15 Autopista Los Chorros',
            latitud=13.7942,
            longitud=-89.2182,
            prioridad=3,
            reportado_por='Sistema de Monitoreo'
        )
    
    def test_evento_creation(self):
        """Probar que se puede crear un evento correctamente"""
        self.assertEqual(self.evento.tipo_evento, 'accidente')
        self.assertEqual(self.evento.ubicacion, 'Km 15 Autopista Los Chorros')
        self.assertEqual(self.evento.estado, 'activo')  # valor por defecto
        
    def test_evento_str_representation(self):
        """Probar la representación en string del evento"""
        expected = "Accidente - Km 15 Autopista Los Chorros (activo)"
        self.assertEqual(str(self.evento), expected)
    
    def test_evento_resolucion_automatica(self):
        """Probar que se actualiza fecha_resolucion al cambiar estado a resuelto"""
        self.assertIsNone(self.evento.fecha_resolucion)
        self.evento.estado = 'resuelto'
        self.evento.save()
        self.assertIsNotNone(self.evento.fecha_resolucion)


class EventoTraficoViewTest(TestCase):
    """
    Tests para las vistas de EventoTrafico
    """
    
    def setUp(self):
        self.evento = EventoTrafico.objects.create(
            tipo_evento='congestion',
            descripcion='Tráfico pesado',
            ubicacion='Centro de San Salvador',
            prioridad=2
        )
    
    def test_health_check_view(self):
        """Probar que el health check funciona"""
        response = self.client.get('/eventos/health/')
        self.assertEqual(response.status_code, 200)
        data = response.json()
        self.assertEqual(data['status'], 'OK')
        self.assertEqual(data['app'], 'microservicios_eventos')
    
    def test_evento_list_view(self):
        """Probar que se pueden listar los eventos"""
        response = self.client.get('/eventos/')
        self.assertEqual(response.status_code, 200)
        data = response.json()
        self.assertIn('eventos', data)
        self.assertEqual(len(data['eventos']), 1)
    
    def test_evento_detail_view(self):
        """Probar que se puede obtener el detalle de un evento"""
        response = self.client.get(f'/eventos/{self.evento.id}/')
        self.assertEqual(response.status_code, 200)
        data = response.json()
        self.assertEqual(data['id'], self.evento.id)
        self.assertEqual(data['tipo_evento'], 'congestion')