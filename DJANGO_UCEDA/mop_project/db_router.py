"""
Database router para dirigir diferentes apps a sus respectivas bases de datos.
"""

class DatabaseRouter:
    """
    Un router para controlar todas las operaciones de base de datos en los modelos
    para diferentes bases de datos.
    """

    route_app_labels = {
        "microservicios_eventos": "eventos_trafico",
        "microservicios_rutas_viajes": "rutas_viajes",
        # Aquí puedes agregar más apps y sus respectivas bases de datos
    }

    def db_for_read(self, model, **hints):
        """Sugerir la base de datos que debe usarse para leer objetos del tipo model."""
        if model._meta.app_label in self.route_app_labels:
            return self.route_app_labels[model._meta.app_label]
        return None

    def db_for_write(self, model, **hints):
        """Sugerir la base de datos que debe usarse para escribir objetos del tipo model."""
        if model._meta.app_label in self.route_app_labels:
            return self.route_app_labels[model._meta.app_label]
        return None

    def allow_relation(self, obj1, obj2, **hints):
        """Permitir relaciones si los modelos están en la misma app."""
        db_set = {"default", "eventos_trafico", "rutas_viajes"}
        if obj1._state.db in db_set and obj2._state.db in db_set:
            return True
        return None

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        """Asegurar que ciertas apps migren solo a su base de datos correspondiente."""
        if app_label in self.route_app_labels:
            return db == self.route_app_labels[app_label]
        elif db in self.route_app_labels.values():
            return False
        return db == "default"
