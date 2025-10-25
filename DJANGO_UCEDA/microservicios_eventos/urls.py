from django.urls import path
from . import views

app_name = 'microservicios_eventos'

urlpatterns = [
    path('', views.EventoTraficoListView.as_view(), name='evento_list'),
    path('crear/', views.EventoTraficoCreateView.as_view(), name='evento_create'),
    path('<int:evento_id>/', views.evento_detail_view, name='evento_detail'),
    path('health/', views.health_check, name='health_check'),
]