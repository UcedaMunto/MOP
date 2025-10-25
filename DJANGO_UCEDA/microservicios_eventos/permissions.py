from rest_framework import permissions
from rest_framework.permissions import BasePermission


class IsOwnerOrReadOnly(BasePermission):
    """
    Permiso personalizado que solo permite a los propietarios de un objeto editarlo.
    """
    def has_object_permission(self, request, view, obj):
        # Permisos de lectura para cualquier request
        if request.method in permissions.SAFE_METHODS:
            return True
        
        # Permisos de escritura solo para el propietario del evento
        # Como manejamos IDs externos, verificamos por username o ID externo
        return (obj.creado_por_username == getattr(request.user, 'username', None) or
                obj.creado_por_id_externo == str(getattr(request.user, 'id', None)))


class IsAuthenticatedOrReadOnlyForCatalogs(BasePermission):
    """
    Permiso que permite lectura a todos pero escritura solo a usuarios autenticados
    Específicamente diseñado para catálogos (TipoEvento, NivelGravedad, EstadoEvento)
    """
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user and request.user.is_authenticated


class CanManageEvents(BasePermission):
    """
    Permiso para gestionar eventos de tráfico
    """
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        
        # Para operaciones de escritura, el usuario debe estar autenticado
        if not (request.user and request.user.is_authenticated):
            return False
        
        # Aquí se pueden agregar más validaciones específicas
        # Por ejemplo, verificar roles específicos, permisos por microservicio, etc.
        return True

    def has_object_permission(self, request, view, obj):
        # Permisos de lectura para cualquier request
        if request.method in permissions.SAFE_METHODS:
            return True
            
        # Para eliminar, solo administradores o el creador
        if request.method == 'DELETE':
            return (request.user.is_staff or 
                    obj.creado_por_username == request.user.username)
        
        # Para actualizar, usuario autenticado
        return request.user and request.user.is_authenticated


class CanManageCatalogs(BasePermission):
    """
    Permiso para gestionar catálogos (TipoEvento, NivelGravedad, EstadoEvento)
    Solo usuarios con permisos especiales pueden modificar catálogos
    """
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
            
        # TEMPORAL PARA DESARROLLO: Solo usuarios autenticados pueden modificar catálogos
        # En producción cambiar a: request.user.is_staff
        return request.user and request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
            
        return request.user and request.user.is_authenticated and request.user.is_staff


class CanManageRoutes(BasePermission):
    """
    Permiso para gestionar rutas afectadas
    """
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user and request.user.is_authenticated

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
            
        # Para eliminar rutas afectadas, solo el creador del evento o staff
        if request.method == 'DELETE':
            return (request.user.is_staff or 
                    obj.evento.creado_por_username == request.user.username)
                    
        return request.user and request.user.is_authenticated


class IsSystemUserOrAuthenticated(BasePermission):
    """
    Permiso para usuarios del sistema o usuarios autenticados
    Útil para endpoints que pueden ser llamados por otros microservicios
    """
    def has_permission(self, request, view):
        # Verificar si es una llamada del sistema (por header especial)
        if request.META.get('HTTP_X_SYSTEM_TOKEN'):
            # Aquí se podría validar el token del sistema
            return True
            
        # O usuario autenticado normal
        return request.user and request.user.is_authenticated


# Configuraciones de permisos por endpoint
ENDPOINT_PERMISSIONS = {
    'tipos-evento': [CanManageCatalogs],
    'niveles-gravedad': [CanManageCatalogs], 
    'estados-evento': [CanManageCatalogs],
    'eventos': [CanManageEvents],
    'rutas-afectadas': [CanManageRoutes],
}