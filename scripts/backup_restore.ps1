# backup_restore.ps1
# Script interactivo para crear y restaurar backups de PostgreSQL (.sql) con Docker en Windows

$backupDir = ".\bd"

# Crear carpeta de backups si no existe
if (!(Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Verificar si Docker está corriendo
try {
    docker info | Out-Null
} catch {
    Write-Host "❌ Docker no está en ejecución. Inícialo e intenta de nuevo." -ForegroundColor Red
    exit 1
}

# Verificar si el contenedor World3D-db está activo
$containerRunning = docker ps --filter "name=World3D-db" --format "{{.Names}}"
if (-not $containerRunning) {
    Write-Host "❌ El contenedor 'World3D-db' no está en ejecución. Usa 'docker-compose up -d' para iniciarlo." -ForegroundColor Red
    exit 1
}

function Crear-Backup {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $filename = "world3d_$timestamp.sql"
    $filepath = Join-Path $backupDir $filename

    Write-Host "`n📦 Creando copia de seguridad..." -ForegroundColor Cyan

    docker exec World3D-db pg_dump -U admin World3D > $filepath

    if ($LASTEXITCODE -eq 0 -and (Test-Path $filepath) -and ((Get-Item $filepath).Length -gt 0)) {
        Write-Host "✅ Backup creado correctamente en: $filepath" -ForegroundColor Green

        Copy-Item $filepath -Destination (Join-Path $backupDir "world3d_current.sql") -Force
        Write-Host "✅ Archivo de sincronización actualizado: world3d_current.sql" -ForegroundColor Green
    } else {
        Write-Host "❌ Error al crear el backup. Verifica que la base de datos exista y el usuario sea correcto." -ForegroundColor Red
    }
}

function Restaurar-Backup {
    $files = Get-ChildItem $backupDir -Filter *.sql
    if ($files.Count -eq 0) {
        Write-Host "❌ No se encontraron archivos .sql en '$backupDir'" -ForegroundColor Red
        return
    }

    Write-Host "`n📂 Copias de seguridad disponibles:`n" -ForegroundColor Cyan
    for ($i = 0; $i -lt $files.Count; $i++) {
        $size = "{0:N2} MB" -f ($files[$i].Length / 1MB)
        Write-Host "$($i + 1). $($files[$i].Name) ($size)"
    }

    $choice = Read-Host "`nSeleccione el número del archivo a restaurar"
    if ($choice -notmatch '^\d+$' -or [int]$choice -lt 1 -or [int]$choice -gt $files.Count) {
        Write-Host "❌ Opción inválida" -ForegroundColor Red
        return
    }

    $selectedFile = $files[[int]$choice - 1].FullName
    Write-Host "`n🚨 ADVERTENCIA: Esto sobrescribirá la base de datos actual." -ForegroundColor Red
    $confirm = Read-Host "¿Desea continuar? (s/N)"
    if ($confirm -ne 's' -and $confirm -ne 'S') {
        Write-Host "🚫 Operación cancelada" -ForegroundColor Yellow
        return
    }

    Write-Host "`n🛑 Deteniendo contenedor..." -ForegroundColor Yellow
    docker-compose stop db
    Write-Host "🧹 Eliminando contenedor..." -ForegroundColor Yellow
    docker-compose rm -f db
    Write-Host "🚀 Iniciando nuevo contenedor..." -ForegroundColor Yellow
    docker-compose up -d

    Write-Host "⏳ Esperando a que la base de datos esté lista..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10

    Write-Host "🗑️ Eliminando base de datos actual..." -ForegroundColor Cyan
    docker exec -i World3D-db dropdb -U admin World3D
    docker exec -i World3D-db createdb -U admin World3D

    Write-Host "🔁 Restaurando desde: $($files[[int]$choice - 1].Name)" -ForegroundColor Cyan
    Get-Content $selectedFile | docker exec -i World3D-db psql -U admin -d World3D

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Base de datos restaurada correctamente." -ForegroundColor Green
    } else {
        Write-Host "❌ Error al restaurar la base de datos." -ForegroundColor Red
    }
}

# Menú principal
Clear-Host
Write-Host "===============================" -ForegroundColor Cyan
Write-Host "  GESTOR DE BASE DE DATOS      " -ForegroundColor Cyan
Write-Host "         WORLD3D               " -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Crear copia de seguridad" -ForegroundColor Green
Write-Host "2. Restaurar copia de seguridad" -ForegroundColor Green
Write-Host "3. Salir" -ForegroundColor Red
Write-Host ""

$opcion = Read-Host "Seleccione una opción [1-3]"

switch ($opcion) {
    '1' { Crear-Backup }
    '2' { Restaurar-Backup }
    '3' {
        Write-Host "👋 Saliendo..." -ForegroundColor Cyan
        exit
    }
    default {
        Write-Host "❌ Opción inválida" -ForegroundColor Red
    }
}
