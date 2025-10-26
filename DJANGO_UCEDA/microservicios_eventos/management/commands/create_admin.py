from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from django.db import transaction


class Command(BaseCommand):
    help = 'Crea o actualiza el usuario admin con privilegios completos'

    def handle(self, *args, **options):
        username = 'admin'
        email = 'admin@mop.com'
        password = 'aw3453jdeW'
        
        try:
            with transaction.atomic():
                # Intentar obtener el usuario existente
                try:
                    user = User.objects.get(username=username)
                    # Actualizar usuario existente
                    user.set_password(password)
                    user.email = email
                    user.is_staff = True
                    user.is_superuser = True
                    user.is_active = True
                    user.save()
                    self.stdout.write(
                        self.style.SUCCESS(
                            f'Usuario admin actualizado exitosamente con email: {email}'
                        )
                    )
                except User.DoesNotExist:
                    # Crear nuevo usuario admin
                    user = User.objects.create_superuser(
                        username=username,
                        email=email,
                        password=password
                    )
                    self.stdout.write(
                        self.style.SUCCESS(
                            f'Usuario admin creado exitosamente con email: {email}'
                        )
                    )
                
                # Verificar que el usuario tiene todos los permisos
                self.stdout.write(
                    self.style.SUCCESS(
                        f'Usuario: {user.username}\n'
                        f'Email: {user.email}\n'
                        f'Es staff: {user.is_staff}\n'
                        f'Es superusuario: {user.is_superuser}\n'
                        f'Está activo: {user.is_active}'
                    )
                )
                
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'Error al crear/actualizar usuario admin: {str(e)}')
            )