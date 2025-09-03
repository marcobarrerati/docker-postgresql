# PostgreSQL Docker Setup

Una configuración robusta de PostgreSQL usando Docker Compose con health checks, configuración optimizada y scripts de inicialización.

## Características

- ✅ PostgreSQL 17 Alpine (imagen ligera)
- ✅ Health checks integrados
- ✅ Configuración optimizada de performance
- ✅ Scripts de inicialización personalizables
- ✅ Logging configurado
- ✅ Límites de recursos
- ✅ Configuración de seguridad
- ✅ Variables de entorno configurables

## Configuración Rápida

1. **Copia el archivo de configuración de ejemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Edita las variables en `.env`:**
   ```bash
   nano .env
   ```

3. **Inicia el servicio:**
   ```bash
   docker-compose up -d
   ```

4. **Verifica el estado:**
   ```bash
   docker-compose ps
   docker-compose logs postgres
   ```

## Variables de Entorno

| Variable            | Descripción                 | Valor por Defecto |
| ------------------- | --------------------------- | ----------------- |
| `POSTGRES_USER`     | Usuario de la base de datos | `postgres`        |
| `POSTGRES_PASSWORD` | Contraseña (requerida)      | -                 |
| `POSTGRES_DB`       | Nombre de la base de datos  | `myapp`           |
| `POSTGRES_PORT`     | Puerto expuesto             | `5432`            |
| `TZ`                | Timezone del contenedor     | `UTC`             |

## Conexión a la Base de Datos

### Desde el host local:
```bash
psql -h localhost -p 5432 -U postgres -d myapp
```

### Desde otro contenedor:
```bash
psql -h postgres-dev -p 5432 -U postgres -d myapp
```

### String de conexión:
```
postgresql://postgres:password@localhost:5432/myapp
```

## Scripts de Inicialización

Los scripts en `init-scripts/` se ejecutan automáticamente cuando se crea la base de datos por primera vez:

- `01-init.sh` - Script de ejemplo que crea extensiones y tablas

Para agregar más scripts, créalos en el directorio `init-scripts/` con nombres que respeten el orden alfabético.

## Configuración Personalizada

El archivo `postgres-conf/postgresql.conf` contiene configuraciones optimizadas. Puedes modificarlo según tus necesidades:

- Configuración de memoria
- Configuración de logging
- Configuración de autovacuum
- Configuración de conexiones

## Comandos Útiles

### Gestión del servicio:
```bash
# Iniciar el servicio
docker-compose up -d

# Detener el servicio
docker-compose down

# Reiniciar el servicio
docker-compose restart

# Ver logs
docker-compose logs -f postgres

# Ejecutar psql interactivo
docker-compose exec postgres psql -U postgres -d myapp
```

### Backup y Restore:
```bash
# Crear backup
docker-compose exec postgres pg_dump -U postgres myapp > backup.sql

# Restaurar backup
docker-compose exec -T postgres psql -U postgres myapp < backup.sql
```

### Monitoreo:
```bash
# Ver estadísticas de conexiones
docker-compose exec postgres psql -U postgres -c "SELECT * FROM pg_stat_activity;"

# Ver extensiones instaladas
docker-compose exec postgres psql -U postgres -c "SELECT * FROM pg_extension;"

# Ver configuración actual
docker-compose exec postgres psql -U postgres -c "SHOW ALL;"
```

## Health Check

El contenedor incluye un health check que verifica cada 10 segundos si PostgreSQL está respondiendo correctamente:

```bash
# Ver estado del health check
docker-compose ps
```

## Seguridad

Esta configuración incluye varias medidas de seguridad:

- No se ejecutan nuevos privilegios en el contenedor
- Filesystem root de solo lectura con tmpfs para áreas necesarias
- Logging habilitado para auditoría
- Configuración de recursos limitados

## Troubleshooting

### El contenedor no inicia:
1. Verifica que el puerto 5432 no esté ocupado
2. Revisa los logs: `docker-compose logs postgres`
3. Verifica las variables de entorno en `.env`

### Problemas de permisos:
```bash
sudo chown -R 999:999 postgres_data/
```

### Resetear la base de datos:
```bash
docker-compose down -v
docker-compose up -d
```

## Estructura del Proyecto

```
.
├── docker-compose.yml         # Configuración principal
├── .env.example               # Variables de entorno de ejemplo
├── init-scripts/              # Scripts de inicialización
│   └── 01-init.sh             # Script de ejemplo
├── postgres-conf/             # Configuración personalizada
│   └── postgresql.conf        # Configuración de PostgreSQL
└── postgres_data/             # Datos persistentes (auto-generado)
```

## Optimizaciones de Performance

La configuración incluye optimizaciones para desarrollo y producción:

- `shared_buffers` = 256MB
- `effective_cache_size` = 1GB
- `work_mem` = 4MB
- `maintenance_work_mem` = 64MB
- Logging de queries lentas (>1000ms)
- pg_stat_statements habilitado

Ajusta estos valores según los recursos de tu sistema.

## Licencia

Este proyecto está bajo la licencia MIT. Siéntete libre de usar y modificar según tus necesidades.
