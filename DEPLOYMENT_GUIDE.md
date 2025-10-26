# Guía de Despliegue en Producción
## IP Pública: 34.45.166.79

### Configuraciones Realizadas

#### 1. Variables de Entorno (`.env`)
- ✅ `DEBUG=False` - Deshabilitado para producción
- ✅ `ALLOWED_HOSTS` actualizado para incluir la IP pública `34.45.166.79`
- ✅ `CORS_ALLOW_ALL_ORIGINS=False` - Restringido para producción

#### 2. Configuración Django (`settings.py`)
- ✅ **CORS Origins**: Agregada la IP pública a `CORS_ALLOWED_ORIGINS`
- ✅ **CSRF Trusted Origins**: Agregada la IP pública a `CSRF_TRUSTED_ORIGINS`
- ✅ **Static Files**: Configurado `STATIC_ROOT` y `STATICFILES_DIRS`
- ✅ **API Documentation**: Agregado servidor de producción en Spectacular
- ✅ **Security Headers**: Configuradas para producción cuando `DEBUG=False`

#### 3. Docker Compose (`docker-compose.yml`)
- ✅ **Puerto 80**: Ya configurado para acceso HTTP público
- ✅ **Puerto 443**: Agregado para futuro soporte HTTPS
- ✅ **Red interna**: Mantenida para comunicación entre contenedores

#### 4. Scripts de Despliegue
- ✅ **entrypoint.sh**: Agregado `collectstatic --noinput` para archivos estáticos

### URLs de Acceso en Producción

- **API Base**: `http://34.45.166.79/api/`
- **Admin**: `http://34.45.166.79/admin/`
- **Documentación API**: `http://34.45.166.79/api/docs/`
- **Schema API**: `http://34.45.166.79/api/schema/`

### Comandos de Despliegue

```bash
# 1. Detener contenedores existentes
docker-compose down

# 2. Reconstruir y levantar con nueva configuración
docker-compose up --build -d

# 3. Verificar que los contenedores estén corriendo
docker-compose ps

# 4. Ver logs de la aplicación
docker-compose logs -f central
```

### Configuraciones de Seguridad Aplicadas

1. **Headers de Seguridad** (cuando DEBUG=False):
   - `SECURE_BROWSER_XSS_FILTER = True`
   - `SECURE_CONTENT_TYPE_NOSNIFF = True`
   - `X_FRAME_OPTIONS = 'DENY'`
   - `SECURE_HSTS_SECONDS = 31536000`
   - `SECURE_HSTS_INCLUDE_SUBDOMAINS = True`
   - `SECURE_HSTS_PRELOAD = True`

2. **CORS Restringido**: Solo orígenes específicos permitidos
3. **CSRF Protection**: Orígenes de confianza configurados

### Verificación Post-Despliegue

Después del despliegue, verificar:

1. **API Health Check**:
   ```bash
   curl http://34.45.166.79/api/health/
   ```

2. **Documentación API**:
   Acceder a `http://34.45.166.79/api/docs/`

3. **Admin Panel**:
   Acceder a `http://34.45.166.79/admin/`

### Consideraciones Adicionales

1. **Firewall**: Asegurar que los puertos 80 y 443 estén abiertos en el servidor
2. **SSL/HTTPS**: Para implementar HTTPS, se necesitará un certificado SSL
3. **Backup**: Los datos de PostgreSQL se almacenan en volúmenes Docker persistentes
4. **Monitoreo**: Considerar implementar logs y monitoreo de aplicación

### Archivos Modificados

- `/home/uceda/Documents/MOP/.env`
- `/home/uceda/Documents/MOP/DJANGO_UCEDA/mop_project/settings.py`
- `/home/uceda/Documents/MOP/docker-compose.yml`
- `/home/uceda/Documents/MOP/DJANGO_UCEDA/entrypoint.sh`