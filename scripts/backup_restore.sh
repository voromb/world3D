#!/bin/bash
# Script interactivo para backup y restauración de base de datos PostgreSQL

# Colores para el menú
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Crear directorio de backups si no existe
mkdir -p ./bd

# Verificar que Docker esté ejecutándose
if ! docker ps >/dev/null 2>&1; then
    echo -e "${RED}Error: Docker no parece estar ejecutándose. Inicia Docker e intenta nuevamente.${NC}"
    exit 1
fi

# Verificar que el contenedor esté en ejecución
if ! docker ps | grep -q "World3D-db"; then
    echo -e "${RED}Error: El contenedor 'World3D-db' no está en ejecución. Inicia el contenedor con 'docker-compose up -d'${NC}"
    exit 1
fi

# Función para crear backup
crear_backup() {
    echo ""
    echo -e "${BLUE}Creando copia de seguridad...${NC}"
    
    # Nombre del archivo con timestamp
    FILENAME="world3d_$(date +%Y%m%d_%H%M%S).dump"
    
    # Ejecutar el backup en formato personalizado
    docker exec World3D-db pg_dump -U admin -Fc World3D > ./bd/$FILENAME
    
    # Verificar resultado
    if [ $? -eq 0 ] && [ -s "./bd/$FILENAME" ]; then
        echo -e "${GREEN}✓ Copia de seguridad creada correctamente en:${NC}"
        echo -e "${GREEN}  ./bd/$FILENAME${NC}"
        
        # Crear también un archivo con nombre fijo para sincronización
        cp ./bd/$FILENAME ./bd/world3d_current.dump
        echo -e "${GREEN}✓ También se ha actualizado el archivo de sincronización:${NC}"
        echo -e "${GREEN}  ./bd/world3d_current.dump${NC}"
    else
        echo -e "${RED}✗ Error al crear la copia de seguridad${NC}"
        echo -e "${YELLOW}Verifica que la base de datos 'World3D' exista y el usuario 'admin' tenga acceso.${NC}"
    fi
}

# Función para restaurar backup
restaurar_backup() {
    echo ""
    echo -e "${BLUE}Copias de seguridad disponibles:${NC}"
    
    # Listar archivos disponibles
    FILES=(./bd/*.dump)
    if [ ${#FILES[@]} -eq 0 ] || [ ! -f ${FILES[0]} ]; then
        echo -e "${RED}No se encontraron copias de seguridad en la carpeta ./bd/${NC}"
        exit 1
    fi
    
    # Mostrar lista numerada
    for i in "${!FILES[@]}"; do
        # Mostrar tamaño del archivo
        FILE_SIZE=$(du -h "${FILES[$i]}" | cut -f1)
        echo "$((i+1)). $(basename ${FILES[$i]}) ($FILE_SIZE)"
    done
    
    # Seleccionar archivo
    echo ""
    read -p "Seleccione el número de la copia a restaurar [1-${#FILES[@]}]: " file_num
    
    # Validar entrada
    if ! [[ "$file_num" =~ ^[0-9]+$ ]] || [ "$file_num" -lt 1 ] || [ "$file_num" -gt "${#FILES[@]}" ]; then
        echo -e "${RED}Opción inválida${NC}"
        exit 1
    fi
    
    # Obtener archivo seleccionado
    SELECTED_FILE=${FILES[$((file_num-1))]}
    
    echo -e "${BLUE}Restaurando desde: $(basename $SELECTED_FILE)${NC}"
    echo -e "${RED}ADVERTENCIA: Esto sobrescribirá la base de datos actual. Los datos existentes se perderán.${NC}"
    echo -e "${YELLOW}Este proceso detendrá y reiniciará el contenedor de la base de datos.${NC}"
    read -p "¿Está seguro de continuar? [s/N]: " confirm
    
    if [[ $confirm != [sS] ]]; then
        echo -e "${BLUE}Operación cancelada${NC}"
        exit 0
    fi
    
    # Método de restauración robusto
    # 1. Detener el contenedor
    echo -e "${YELLOW}Deteniendo el contenedor de base de datos...${NC}"
    docker-compose stop db
    
    # 2. Eliminar el contenedor (para recrearlo después)
    echo -e "${YELLOW}Eliminando el contenedor de base de datos...${NC}"
    docker-compose rm -f db
    
    # 3. Iniciar nuevo contenedor
    echo -e "${YELLOW}Iniciando nuevo contenedor de base de datos...${NC}"
    docker-compose up -d
    
    # 4. Esperar a que la base de datos esté lista
    echo -e "${YELLOW}Esperando a que la base de datos esté lista...${NC}"
    sleep 10
    
    # 5. Restaurar el backup con pg_restore
    echo -e "${BLUE}Restaurando datos desde el archivo seleccionado...${NC}"
    docker exec -i World3D-db dropdb -U admin World3D
    docker exec -i World3D-db createdb -U admin World3D
    docker exec -i World3D-db pg_restore -U admin -d World3D /tmp/$(basename $SELECTED_FILE)
    docker cp $SELECTED_FILE World3D-db:/tmp/
    
    # Verificar resultado
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Base de datos restaurada correctamente${NC}"
    else
        echo -e "${RED}✗ Error al restaurar la base de datos${NC}"
        echo -e "${YELLOW}Es posible que el archivo de backup esté corrupto o sea incompatible.${NC}"
    fi
}

# Menú principal
clear
echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}      GESTOR DE BASE DE DATOS PARA WORLD3D        ${NC}"
echo -e "${BLUE}==================================================${NC}"
echo ""
echo -e "Por favor, seleccione una opción:"
echo -e "1. ${GREEN}Crear copia de seguridad${NC}"
echo -e "2. ${GREEN}Restaurar copia de seguridad (reinicia el contenedor)${NC}"
echo -e "3. ${RED}Salir${NC}"
echo ""
read -p "Opción [1-3]: " option

case $option in
    1)
        crear_backup
        ;;
    2)
        restaurar_backup
        ;;
    3)
        echo -e "${BLUE}Saliendo...${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Opción inválida${NC}"
        exit 1
        ;;
esac