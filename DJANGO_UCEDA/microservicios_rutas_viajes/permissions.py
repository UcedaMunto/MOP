from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Permiso personalizado para permitir solo a los propietarios editar sus objetos
    """
    def has_object_permission(self, request, view, obj):
        # Permisos de lectura para cualquier request
        if request.method in permissions.SAFE_METHODS:
            return True
        
        # Permisos de escritura solo para el propietario del objeto
        return obj.owner == request.user


class IsEmpresaOwnerOrReadOnly(permissions.BasePermission):
    """
    Permiso para objetos que pertenecen a una empresa
    """
    def has_object_permission(self, request, view, obj):
        # Permisos de lectura para cualquier request
        if request.method in permissions.SAFE_METHODS:
            return True
        
        # Para objetos que tienen empresa, verificar que el usuario pertenezca a esa empresa
        if hasattr(obj, 'empresa'):
            # Aquí se podría implementar lógica para verificar si el usuario
            # pertenece a la empresa o tiene permisos sobre ella
            return True
        
        return False


class IsActiveUserPermission(permissions.BasePermission):
    """
    Permiso que requiere que el usuario esté activo
    """
    def has_permission(self, request, view):
        return request.user and request.user.is_authenticated and request.user.is_active