# Guía Completa para World3D

Esta guía detallada proporciona todas las instrucciones necesarias para configurar, ejecutar, mantener y sincronizar el proyecto World3D entre diferentes entornos de desarrollo.

## Tabla de Contenidos

- [Guía Completa para World3D](#guía-completa-para-world3d)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Requisitos Previos](#requisitos-previos)
    - [Instalación de Requisitos](#instalación-de-requisitos)
      - [Windows:](#windows)
      - [macOS:](#macos)
      - [Linux (Ubuntu/Debian):](#linux-ubuntudebian)
  - [Configuración Inicial](#configuración-inicial)
    - [Clonar el Repositorio](#clonar-el-repositorio)
    - [Configurar Docker y la Base de Datos](#configurar-docker-y-la-base-de-datos)
    - [Configurar Backend (Strapi)](#configurar-backend-strapi)
    - [Configurar Frontend (Next.js)](#configurar-frontend-nextjs)
  - [Desarrollo](#desarrollo)
    - [Flujo de Trabajo Recomendado](#flujo-de-trabajo-recomendado)
    - [Endpoints de la API](#endpoints-de-la-api)
  - [Gestión de la Base de Datos](#gestión-de-la-base-de-datos)
    - [Backup y Restauración](#backup-y-restauración)
      - [En Mac/Linux:](#en-maclinux)
      - [En Windows:](#en-windows)
    - [Sincronización entre Entornos](#sincronización-entre-entornos)
  - [Despliegue](#despliegue)
    - [Preparación para Producción](#preparación-para-producción)
      - [Backend (Strapi):](#backend-strapi)
      - [Frontend (Next.js):](#frontend-nextjs)
    - [Opciones de Despliegue](#opciones-de-despliegue)
  - [Resolución de Problemas](#resolución-de-problemas)
    - [Problemas Comunes con Docker](#problemas-comunes-con-docker)
      - [Error: "Puerto en uso"](#error-puerto-en-uso)
      - [Contenedor no inicia correctamente](#contenedor-no-inicia-correctamente)
    - [Problemas con Strapi](#problemas-con-strapi)
      - [Error de conexión a la base de datos](#error-de-conexión-a-la-base-de-datos)
      - [Problemas de permisos API](#problemas-de-permisos-api)
    - [Problemas con Next.js](#problemas-con-nextjs)
      - [Error "Connection Refused" al conectarse a Strapi](#error-connection-refused-al-conectarse-a-strapi)
  - [Comandos Útiles](#comandos-útiles)
    - [Docker](#docker)
    - [Strapi](#strapi)
    - [Next.js](#nextjs)
    - [Base de Datos](#base-de-datos)
  - [Contribución](#contribución)

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Node.js** (v18.x o superior)
- **npm** (v8.x o superior)
- **Docker** y **Docker Compose**
- **Git**

### Instalación de Requisitos

#### Windows:
- Node.js y npm: [Descargar el instalador](https://nodejs.org/)
- Docker Desktop: [Descargar Docker Desktop](https://www.docker.com/products/docker-desktop)
- Git: [Descargar el instalador](https://git-scm.com/downloads)

#### macOS:
```bash
# Instalar Homebrew si no lo tienes
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar Node.js
brew install node

# Instalar Docker Desktop
brew install --cask docker

# Instalar Git
brew install git
```

#### Linux (Ubuntu/Debian):
```bash
# Actualizar repositorios
sudo apt update

# Instalar Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Instalar Docker y Docker Compose
sudo apt install docker.io docker-compose

# Instalar Git
sudo apt install git
```

## Configuración Inicial

### Clonar el Repositorio

```bash
git clone https://github.com/voromb/world3d.git
cd world3d
```

### Configurar Docker y la Base de Datos

1. **Iniciar el contenedor de PostgreSQL**:
   ```bash
   docker-compose up -d
   ```
   
   Este comando inicia un contenedor PostgreSQL con la siguiente configuración:
   - Puerto: 5434 (mapeado al puerto 5432 del contenedor)
   - Usuario: admin
   - Base de datos: World3D

2. **Verificar que el contenedor está funcionando**:
   ```bash
   docker ps
   ```
   
   Deberías ver un contenedor llamado `World3D-db` en ejecución.

### Configurar Backend (Strapi)

1. **Instalar dependencias**:
   ```bash
   cd backend
   npm install
   ```

2. **Iniciar Strapi en modo desarrollo**:
   ```bash
   npm run develop
   ```
   
   La primera vez que inicies Strapi, se te pedirá crear un usuario administrador:
   - Nombre
   - Email
   - Contraseña
   
   Strapi estará disponible en http://localhost:1337/admin

3. **Configurar permisos de API** (necesario para que Next.js pueda comunicarse con Strapi):
   
   a. Ve a la sección **Settings > Roles > Public**
   b. Habilita los permisos necesarios para los tipos de contenido que deseas exponer públicamente
   c. Guarda los cambios

### Configurar Frontend (Next.js)

1. **Instalar dependencias**:
   ```bash
   cd ../landing
   npm install
   ```

2. **Crear archivo de variables de entorno**:
   ```bash
   # En la carpeta landing
   echo "NEXT_PUBLIC_API_URL=http://localhost:1337" > .env.local
   ```

3. **Iniciar Next.js en modo desarrollo**:
   ```bash
   npm run dev
   ```
   
   El frontend estará disponible en http://localhost:3000

4. **Verificar la conexión con Strapi**:
   
   Al acceder a http://localhost:3000, deberías ver un indicador que muestra si la conexión con Strapi está activa.

## Desarrollo

### Flujo de Trabajo Recomendado

1. **Desarrollo del Backend**:
   - Crea tipos de contenido en Strapi desde el panel de administración
   - Define relaciones entre entidades
   - Configura permisos y roles
   - Prueba endpoints con herramientas como Postman o Insomnia

2. **Desarrollo del Frontend**:
   - Consume la API de Strapi desde Next.js usando el cliente API integrado
   - Desarrolla componentes y páginas
   - Implementa la lógica de negocio

### Endpoints de la API

Strapi genera automáticamente endpoints RESTful para tus tipos de contenido:

- `GET /api/{content-type}` - Obtener una lista de entradas
- `GET /api/{content-type}/{id}` - Obtener una entrada específica
- `POST /api/{content-type}` - Crear una nueva entrada
- `PUT /api/{content-type}/{id}` - Actualizar una entrada existente
- `DELETE /api/{content-type}/{id}` - Eliminar una entrada

## Gestión de la Base de Datos

### Backup y Restauración

Hemos incluido scripts interactivos para facilitar la gestión de la base de datos.

#### En Mac/Linux:

```bash
./scripts/backup_restore.sh
```

Este script te presentará un menú con opciones para:
1. Crear una copia de seguridad
2. Restaurar una copia de seguridad existente
3. Salir

#### En Windows:

```bash
.\scripts\backup_restore.ps1
```

Funciona de manera similar al script de Mac/Linux, presentando un menú interactivo.

### Sincronización entre Entornos

Para mantener la base de datos sincronizada entre diferentes entornos (Windows/Mac/Linux):

1. **Antes de cambiar de entorno**:
   ```bash
   # Ejecuta el script de backup
   ./scripts/backup_restore.sh  # o .\scripts\backup_restore.ps1 en Windows
   # Selecciona la opción 1 para crear una copia de seguridad
   ```

2. **Sube la copia de seguridad a Git**:
   ```bash
   git add bd/
   git commit -m "Actualizar estado de la base de datos para sincronización"
   git push
   ```

3. **En el nuevo entorno**:
   ```bash
   # Obtén los últimos cambios
   git pull
   
   # Ejecuta el script de restauración
   ./scripts/backup_restore.sh  # o .\scripts\backup_restore.ps1 en Windows
   # Selecciona la opción 2 para restaurar
   # Elige el archivo world3d_current.sql
   ```

## Despliegue

### Preparación para Producción

#### Backend (Strapi):

1. **Construir la aplicación para producción**:
   ```bash
   cd backend
   NODE_ENV=production npm run build
   ```

2. **Iniciar en modo producción**:
   ```bash
   NODE_ENV=production npm start
   ```

#### Frontend (Next.js):

1. **Construir la aplicación para producción**:
   ```bash
   cd landing
   npm run build
   ```

2. **Iniciar en modo producción**:
   ```bash
   npm start
   ```

### Opciones de Despliegue

Puedes desplegar World3D en varias plataformas:

- **Vercel**: Ideal para el frontend Next.js
- **Heroku**: Adecuado para Strapi
- **DigitalOcean**: Buena opción para desplegar toda la aplicación
- **AWS, Google Cloud, Azure**: Para despliegues más robustos y a escala

## Resolución de Problemas

### Problemas Comunes con Docker

#### Error: "Puerto en uso"

```
Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:5434 -> 127.0.0.1:0: listen tcp 0.0.0.0:5434: bind: address already in use
```

**Solución**:
1. Cambia el puerto en `docker-compose.yml`:
   ```yaml
   ports:
     - "5435:5432"  # Cambia 5434 a otro puerto disponible
   ```
2. O detén el proceso que está usando ese puerto:
   ```bash
   # En Mac/Linux
   sudo lsof -i :5434
   sudo kill <PID>
   
   # En Windows
   netstat -ano | findstr :5434
   taskkill /PID <PID> /F
   ```

#### Contenedor no inicia correctamente

**Solución**:
```bash
# Ver logs del contenedor
docker logs World3D-db

# Reiniciar el contenedor
docker-compose down
docker-compose up -d
```

### Problemas con Strapi

#### Error de conexión a la base de datos

```
error: password authentication failed for user "admin"
```

**Solución**:
1. Verifica que el contenedor PostgreSQL esté ejecutándose: `docker ps`
2. Confirma que las credenciales en la configuración de Strapi coinciden con las de Docker:
   - Revisa `backend/config/database.ts`
   - Asegúrate de que el puerto, usuario y contraseña sean correctos

#### Problemas de permisos API

Si Next.js no puede acceder a los datos, verifica:
1. Permisos en **Settings > Roles > Public**
2. Configuración CORS en `backend/config/middlewares.ts`

### Problemas con Next.js

#### Error "Connection Refused" al conectarse a Strapi

**Solución**:
1. Verifica que Strapi esté ejecutándose
2. Confirma que la variable de entorno `NEXT_PUBLIC_API_URL` es correcta
3. Revisa la configuración CORS en Strapi

## Comandos Útiles

### Docker

```bash
# Ver contenedores en ejecución
docker ps

# Ver logs de un contenedor
docker logs World3D-db

# Detener todos los contenedores
docker-compose down

# Reiniciar contenedores
docker-compose restart
```

### Strapi

```bash
# Iniciar en modo desarrollo
npm run develop

# Construir para producción
NODE_ENV=production npm run build

# Iniciar en modo producción
NODE_ENV=production npm start
```

### Next.js

```bash
# Iniciar en modo desarrollo
npm run dev

# Construir para producción
npm run build

# Iniciar en modo producción
npm start

# Análisis de tamaño de bundle
ANALYZE=true npm run build
```

### Base de Datos

```bash
# Conectarse directamente a PostgreSQL
docker exec -it World3D-db psql -U admin World3D

# Exportar manualmente la base de datos
docker exec World3D-db pg_dump -U admin World3D > backup.sql

# Importar manualmente la base de datos
cat backup.sql | docker exec -i World3D-db psql -U admin World3D
```

---

## Contribución

Si encuentras problemas o tienes sugerencias de mejoras, no dudes en abrir un issue o enviar un pull request en el repositorio.

---

Última actualización: Abril 2025