# Script de Gestión de Base de Datos World3D
# Ejecutar como administrador

# Colores para la consola
$Green = [System.ConsoleColor]::Green
$Blue = [System.ConsoleColor]::Blue
$Red = [System.ConsoleColor]::Red
$Yellow = [System.ConsoleColor]::Yellow

# Crear directorio de backups si no existe
$BackupDir = ".\bd"
if (!(Test-Path -Path $BackupDir)) {
    New-Item -ItemType Directory -Force -Path $BackupDir
}

# Función para mostrar mensaje con color
function Write-ColorOutput {
    param(
        [string]$Message, 
        [System.ConsoleColor]$Color
    )
    Write-Host $Message -ForegroundColor $Color
}

# Verificar Docker
function Test-DockerRunning {
    try {
        $dockerInfo = docker info
        return $true
    }
    catch {
        Write-ColorOutput "Error: Docker no parece estar ejecutándose. Inicia Docker e intenta nuevamente." $Red
        return $false
    }
}

# Verificar contenedor
function Test-ContainerRunning {
    $containerRunning = docker ps | Select-String "World3D-db"
    if (!$containerRunning) {
        Write-ColorOutput "Error: El contenedor 'World3D-db' no está en ejecución. Inicia el contenedor con 'docker-compose up -d'" $Red
        return $false
    }
    return $true
}

# Función para crear backup
function Create-Backup {
    Write-Host "`n" -NoNewline
    Write-ColorOutput "Creando copia de seguridad..." $Blue
    
    # Nombre del archivo con timestamp
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $Filename = "world3d_$Timestamp.dump"
    $FullPath = Join-Path $BackupDir $Filename
    
    try {
        # Ejecutar backup en formato personalizado
        docker exec World3D-db pg_dump -U admin -Fc World3D > $FullPath
        
        if (Test-Path $FullPath -PathType Leaf) {
            Write-ColorOutput "✓ Copia de seguridad creada correctamente en:" $Green
            Write-ColorOutput "  $FullPath" $Green
            
            # Crear archivo de sincronización
            $CurrentPath = Join-Path $BackupDir "world3d_current.dump"
            Copy-Item $FullPath $CurrentPath -Force
            Write-ColorOutput "✓ También se ha actualizado el archivo de sincronización:" $Green
            Write-ColorOutput "  $CurrentPath" $Green
        }
        else {
            throw "Archivo de backup no creado"
        }
    }
    catch {
        Write-ColorOutput "✗ Error al crear la copia de seguridad" $Red
        Write-ColorOutput "Verifica que la base de datos 'World3D' exista y el usuario 'admin' tenga acceso." $Yellow
    }
}

# Función para restaurar backup
function Restore-Backup {
    Write-Host "`n" -NoNewline
    Write-ColorOutput "Copias de seguridad disponibles:" $Blue
    
    # Obtener archivos de backup
    $BackupFiles = Get-ChildItem $BackupDir -Filter *.dump
    
    if ($BackupFiles.Count -eq 0) {
        Write-ColorOutput "No se encontraron copias de seguridad en la carpeta $BackupDir" $Red
        return
    }
    
    # Mostrar lista de backups
    for ($i = 0; $i -lt $BackupFiles.Count; $i++) {
        $File = $BackupFiles[$i]
        $FileSize = "{0:N2} MB" -f ($File.Length / 1MB)
        Write-Host "$($i+1). $($File.Name) ($FileSize)"
    }
    
    # Seleccionar archivo
    Write-Host ""
    $Selection = Read-Host "Seleccione el número de la copia a restaurar [1-$($BackupFiles.Count)]"
    
    # Validar selección
    try {
        $SelectedIndex = [int]$Selection - 1
        if ($SelectedIndex -lt 0 -or $SelectedIndex -ge $BackupFiles.Count) {
            throw "Selección inválida"
        }
        
        $SelectedFile = $BackupFiles[$SelectedIndex]
    }
    catch {
        Write-ColorOutput "Opción inválida" $Red
        return
    }
    
    # Confirmación
    Write-ColorOutput "Restaurando desde: $($SelectedFile.Name)" $Blue
    Write-ColorOutput "ADVERTENCIA: Esto sobrescribirá la base de datos actual. Los datos existentes se perderán." $Red
    Write-ColorOutput "Este proceso detendrá y reiniciará el contenedor de la base de datos." $Yellow
    
    $Confirm = Read-Host "¿Está seguro de continuar? [s/N]"
    if ($Confirm.ToLower() -ne 's') {
        Write-ColorOutput "Operación cancelada" $Blue
        return
    }
    
    # Proceso de restauración
    try {
        # 1. Detener el contenedor
        Write-ColorOutput "Deteniendo el contenedor de base de datos..." $Yellow
        docker-compose stop db
        
        # 2. Eliminar el contenedor
        Write-ColorOutput "Eliminando el contenedor de base de datos..." $Yellow
        docker-compose rm -f db
        
        # 3. Iniciar nuevo contenedor
        Write-ColorOutput "Iniciando nuevo contenedor de base de datos..." $Yellow
        docker-compose up -d
        
        # 4. Esperar a que la base de datos esté lista
        Write-ColorOutput "Esperando a que la base de datos esté lista..." $Yellow
        Start-Sleep -Seconds 10
        
        # 5. Copiar archivo de backup al contenedor
        $ContainerBackupPath = "/tmp/$($SelectedFile.Name)"
        docker cp $SelectedFile.FullName World3D-db:$ContainerBackupPath
        
        # 6. Restaurar backup
        Write-ColorOutput "Restaurando datos desde el archivo seleccionado..." $Blue
        docker exec -i World3D-db dropdb -U admin World3D
        docker exec -i World3D-db createdb -U admin World3D
        docker exec -i World3D-db pg_restore -U admin -d World3D $ContainerBackupPath
        
        Write-ColorOutput "✓ Base de datos restaurada correctamente" $Green
    }
    catch {
        Write-ColorOutput "✗ Error al restaurar la base de datos" $Red
        Write-ColorOutput "Es posible que el archivo de backup esté corrupto o sea incompatible." $Yellow
        Write-Host $_.Exception.Message
    }
}

# Menú principal
function Show-Menu {
    Clear-Host
    Write-Host "==================================================" -ForegroundColor $Blue
    Write-Host "      GESTOR DE BASE DE DATOS PARA WORLD3D        " -ForegroundColor $Blue
    Write-Host "==================================================" -ForegroundColor $Blue
    Write-Host ""
    Write-Host "Por favor, seleccione una opción:" -NoNewline
    Write-Host " [Usar teclas de flecha y Enter]" -ForegroundColor DarkGray
    Write-Host "1. " -NoNewline
    Write-Host "Crear copia de seguridad" -ForegroundColor $Green
    Write-Host "2. " -NoNewline
    Write-Host "Restaurar copia de seguridad (reinicia el contenedor)" -ForegroundColor $Green
    Write-Host "3. " -NoNewline
    Write-Host "Salir" -ForegroundColor $Red
}

# Bucle principal
do {
    # Verificaciones previas
    if (!(Test-DockerRunning)) {
        Read-Host "Presione Enter para salir"
        exit
    }
    
    if (!(Test-ContainerRunning)) {
        Read-Host "Presione Enter para salir"
        exit
    }

    # Mostrar menú
    Show-Menu
    
    # Entrada de usuario
    $Selection = Read-Host "Opción [1-3]"
    
    # Procesar selección
    switch ($Selection) {
        '1' { Create-Backup }
        '2' { Restore-Backup }
        '3' { 
            Write-ColorOutput "Saliendo..." $Blue
            exit 
        }
        default { 
            Write-ColorOutput "Opción inválida" $Red
            Start-Sleep -Seconds 2
        }
    }
    
    # Pausar para ver resultados
    if ($Selection -ne '3') {
        Read-Host "Presione Enter para continuar"
    }
}
while ($true)