# Script interactivo para backup y restauración de base de datos PostgreSQL para Windows

# Crear directorio de backups si no existe
if (-not (Test-Path -Path ".\bd")) {
  New-Item -ItemType Directory -Path ".\bd" | Out-Null
}

# Verificar que Docker esté ejecutándose
try {
  $null = docker ps
} catch {
  Write-Host "Error: Docker no parece estar ejecutándose. Inicia Docker Desktop e intenta nuevamente." -ForegroundColor Red
  exit 1
}

# Verificar que el contenedor esté en ejecución
$containerRunning = docker ps -f "name=World3D-db" --format "{{.Names}}"
if (-not $containerRunning) {
  Write-Host "Error: El contenedor 'World3D-db' no está en ejecución. Inicia el contenedor con 'docker-compose up -d'" -ForegroundColor Red
  exit 1
}

Clear-Host
Write-Host "==================================================" -ForegroundColor Blue
Write-Host "      GESTOR DE BASE DE DATOS PARA WORLD3D        " -ForegroundColor Blue
Write-Host "==================================================" -ForegroundColor Blue
Write-Host ""
Write-Host "Por favor, seleccione una opción:"
Write-Host "1. Crear copia de seguridad" -ForegroundColor Green
Write-Host "2. Restaurar copia de seguridad" -ForegroundColor Green
Write-Host "3. Salir" -ForegroundColor Red
Write-Host ""

$option = Read-Host "Opción [1-3]"

if ($option -eq "1") {
  # Crear backup
  Write-Host ""
  Write-Host "Creando copia de seguridad..." -ForegroundColor Blue
  
  # Nombre del archivo con timestamp
  $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
  $FILENAME = "world3d_$timestamp.sql"
  
  try {
      # Ejecutar el backup
      docker exec World3D-db pg_dump -U admin World3D > ".\bd\$FILENAME"
      
      if (Test-Path ".\bd\$FILENAME") {
          $fileSize = (Get-Item ".\bd\$FILENAME").Length
          if ($fileSize -gt 0) {
              Write-Host "✓ Copia de seguridad creada correctamente en:" -ForegroundColor Green
              Write-Host "  .\bd\$FILENAME" -ForegroundColor Green
              
              # Crear también un archivo con nombre fijo para sincronización
              Copy-Item ".\bd\$FILENAME" ".\bd\world3d_current.sql" -Force
              Write-Host "✓ También se ha actualizado el archivo de sincronización:" -ForegroundColor Green
              Write-Host "  .\bd\world3d_current.sql" -ForegroundColor Green
          } else {
              Write-Host "⚠️ El archivo de backup está vacío. Es posible que haya ocurrido un error." -ForegroundColor Yellow
          }
      } else {
          Write-Host "✗ No se pudo crear el archivo de backup" -ForegroundColor Red
      }
  }
  catch {
      Write-Host "✗ Error al crear la copia de seguridad: $_" -ForegroundColor Red
  }
}
elseif ($option -eq "2") {
  # Restaurar backup
  Write-Host ""
  Write-Host "Copias de seguridad disponibles:" -ForegroundColor Blue
  
  try {
      # Listar archivos disponibles
      $FILES = Get-ChildItem ".\bd\*.sql" -ErrorAction Stop
      if ($FILES.Count -eq 0) {
          Write-Host "No se encontraron copias de seguridad en la carpeta .\bd\" -ForegroundColor Red
          exit 1
      }
      
      # Mostrar lista numerada
      for ($i = 0; $i -lt $FILES.Count; $i++) {
          # Mostrar tamaño del archivo
          $fileSize = [math]::Round(($FILES[$i].Length / 1KB), 2)
          Write-Host "$($i+1). $($FILES[$i].Name) ($fileSize KB)" 
      }
      
      # Seleccionar archivo
      Write-Host ""
      $file_num = Read-Host "Seleccione el número de la copia a restaurar [1-$($FILES.Count)]"
      
      # Validar entrada
      if (-not ($file_num -match "^\d+$") -or [int]$file_num -lt 1 -or [int]$file_num -gt $FILES.Count) {
          Write-Host "Opción inválida" -ForegroundColor Red
          exit 1
      }
      
      # Obtener archivo seleccionado
      $SELECTED_FILE = $FILES[[int]$file_num-1].FullName
      
      Write-Host "Restaurando desde: $($FILES[[int]$file_num-1].Name)" -ForegroundColor Blue
      Write-Host "ADVERTENCIA: Esto sobrescribirá la base de datos actual. Los datos existentes se perderán." -ForegroundColor Red
      $confirm = Read-Host "¿Está seguro de continuar? [s/N]"
      
      if ($confirm -ne "s" -and $confirm -ne "S") {
          Write-Host "Operación cancelada" -ForegroundColor Blue
          exit 0
      }
      
      # Realizar un backup antes de restaurar
      $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
      $BACKUP_FILENAME = "world3d_before_restore_$timestamp.sql"
      Write-Host "Creando copia de seguridad de la base de datos actual antes de restaurar..." -ForegroundColor Yellow
      docker exec World3D-db pg_dump -U admin World3D > ".\bd\$BACKUP_FILENAME"
      
      if (Test-Path ".\bd\$BACKUP_FILENAME") {
          $fileSize = (Get-Item ".\bd\$BACKUP_FILENAME").Length
          if ($fileSize -gt 0) {
              Write-Host "✓ Backup previo creado en: .\bd\$BACKUP_FILENAME" -ForegroundColor Green
          } else {
              Write-Host "⚠️ El backup previo está vacío o ha fallado" -ForegroundColor Yellow
          }
      }
      
      # Preparar la base de datos para restauración limpia
      Write-Host "Preparando base de datos para restauración limpia..." -ForegroundColor Blue
      # Desconectar usuarios y eliminar base de datos
      docker exec -i World3D-db psql -U admin postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'World3D';"
      docker exec -i World3D-db psql -U admin postgres -c "DROP DATABASE IF EXISTS World3D;"
      docker exec -i World3D-db psql -U admin postgres -c "CREATE DATABASE World3D;"
      
      # Ejecutar restauración
      Write-Host "Restaurando base de datos..." -ForegroundColor Blue
      type $SELECTED_FILE | docker exec -i World3D-db psql -U admin World3D
      Write-Host "✓ Base de datos restaurada correctamente" -ForegroundColor Green
  }
  catch {
      Write-Host "✗ Error: $_" -ForegroundColor Red
  }
}
elseif ($option -eq "3") {
  Write-Host "Saliendo..." -ForegroundColor Blue
  exit 0
}
else {
  Write-Host "Opción inválida" -ForegroundColor Red
  exit 1
}