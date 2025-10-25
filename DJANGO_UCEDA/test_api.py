#!/usr/bin/env python3
"""
Script de prueba para verificar que la API de eventos funciona correctamente
"""

import requests
import json
from requests.auth import HTTPBasicAuth

# Configuración
BASE_URL = "http://localhost:8000/eventos/api"
headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

def test_create_nivel_gravedad():
    """Prueba crear un nivel de gravedad"""
    print("🧪 Probando crear nivel de gravedad...")
    
    url = f"{BASE_URL}/niveles-gravedad/"
    data = {
        "codigo": "TEST",
        "nombre": "Nivel de Prueba",
        "orden": 10
    }
    
    try:
        response = requests.post(url, headers=headers, json=data)
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.text}")
        
        if response.status_code in [200, 201]:
            print("✅ Nivel de gravedad creado exitosamente")
            return response.json()
        else:
            print("❌ Error al crear nivel de gravedad")
            return None
            
    except Exception as e:
        print(f"❌ Error de conexión: {e}")
        return None

def test_create_tipo_evento():
    """Prueba crear un tipo de evento"""
    print("\n🧪 Probando crear tipo de evento...")
    
    url = f"{BASE_URL}/tipos-evento/"
    data = {
        "codigo": "TEST",
        "nombre": "Evento de Prueba",
        "descripcion": "Solo para testing",
        "activo": True
    }
    
    try:
        response = requests.post(url, headers=headers, json=data)
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.text}")
        
        if response.status_code in [200, 201]:
            print("✅ Tipo de evento creado exitosamente")
            return response.json()
        else:
            print("❌ Error al crear tipo de evento")
            return None
            
    except Exception as e:
        print(f"❌ Error de conexión: {e}")
        return None

def test_list_endpoints():
    """Prueba listar los endpoints básicos"""
    endpoints = [
        "/tipos-evento/",
        "/niveles-gravedad/", 
        "/estados-evento/",
        "/eventos/"
    ]
    
    print("\n🧪 Probando endpoints de listado...")
    
    for endpoint in endpoints:
        url = f"{BASE_URL}{endpoint}"
        try:
            response = requests.get(url, headers=headers)
            print(f"GET {endpoint}: {response.status_code}")
            if response.status_code != 200:
                print(f"   Error: {response.text}")
        except Exception as e:
            print(f"GET {endpoint}: Error de conexión - {e}")

def main():
    print("🚀 Iniciando pruebas de API...")
    print(f"Base URL: {BASE_URL}")
    
    # Probar endpoints de listado primero
    test_list_endpoints()
    
    # Probar creación
    test_create_nivel_gravedad()
    test_create_tipo_evento()
    
    print("\n🏁 Pruebas completadas.")

if __name__ == "__main__":
    main()