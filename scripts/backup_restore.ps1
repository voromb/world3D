# Script interactivo para backup y restauración de base de datos PostgreSQL para Windows

# Crear directorio de backups si no existe
if (-not (Test-Path -Path .\bd)) {
  New-Item -ItemType Directory -Path .\bd | Out-Null
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

switch ($option) {
  "1" {
      # Crear backup
      Write-Host ""
      Write-Host "Creando copia de seguridad..." -ForegroundColor Blue
      
      # Nombre del archivo con timestamp
      $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
      $FILENAME = "world3d_$timestamp.sql"
      
      # Ejecutar el backup
      docker exec World3D-db pg_dump -U admin World3D > .\bd\$FILENAME
      
      # Verificar resultado
      if ($LASTEXITCODE -eq 0) {
          Write-Host "✓ Copia de seguridad creada correctamente en:" -ForegroundColor Green
          Write-Host "  .\bd\$FILENAME" -ForegroundColor Green
          
          # Crear también un archivo con nombre fijo para sincronización
          Copy-Item .\bd\$FILENAME .\bd\world3d_current.sql
          Write-Host "✓ También se ha actualizado el archivo de sincronización:" -ForegroundColor Green
          Write-Host "  .\bd\world3d_current.sql" -ForegroundColor Green
      } else {
          Write-Host "✗ Error al crear la copia de seguridad" -ForegroundColor Red
      }
  }
  
  "2" {
      # Restaurar backup
      Write-Host ""
      Write-Host "Copias de seguridad disponibles:" -ForegroundColor Blue
      
      # Listar archivos disponibles
      $FILES = Get-ChildItem .\bd\*.sql -ErrorAction SilentlyContinue
      if (-not $FILES) {
          Write-Host "No se encontraron copias de seguridad en la carpeta .\bd\" -ForegroundColor Red
          exit 1
      }
      
      # Mostrar lista numerada
      for ($i = 0; $i -lt $FILES.Count; $i++) {
          Write-Host "$($i+1). $($FILES[$i].Name)"
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
      
      # Ejecutar restauración
      Get-Content $SELECTED_FILE | docker exec -i World3D-db psql -U admin World3D
      
      # Verificar resultado
      if ($LASTEXITCODE -eq 0) {
          Write-Host "✓ Base de datos restaurada correctamente" -ForegroundColor Green
      } else {
          Write-Host "✗ Error al restaurar la base de datos" -ForegroundColor Red
      }
  }
  
  "3" {
      Write-Host "Saliendo..." -ForegroundColor Blue
      exit 0
  }
  
  default {
      Write-Host "Opción inválida" -ForegroundColor Red
      exit 1
  }
}