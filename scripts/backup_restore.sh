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

clear
echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}      GESTOR DE BASE DE DATOS PARA WORLD3D        ${NC}"
echo -e "${BLUE}==================================================${NC}"
echo ""
echo -e "Por favor, seleccione una opción:"
echo -e "1. ${GREEN}Crear copia de seguridad${NC}"
echo -e "2. ${GREEN}Restaurar copia de seguridad${NC}"
echo -e "3. ${RED}Salir${NC}"
echo ""
read -p "Opción [1-3]: " option

case $option in
    1)
        # Crear backup
        echo ""
        echo -e "${BLUE}Creando copia de seguridad...${NC}"
        
        # Nombre del archivo con timestamp
        FILENAME="world3d_$(date +%Y%m%d_%H%M%S).sql"
        
        # Ejecutar el backup
        docker exec World3D-db pg_dump -U admin World3D > ./bd/$FILENAME
        
        # Verificar resultado
        if [ $? -eq 0 ] && [ -s "./bd/$FILENAME" ]; then
            echo -e "${GREEN}✓ Copia de seguridad creada correctamente en:${NC}"
            echo -e "${GREEN}  ./bd/$FILENAME${NC}"
            
            # Crear también un archivo con nombre fijo para sincronización
            cp ./bd/$FILENAME ./bd/world3d_current.sql
            echo -e "${GREEN}✓ También se ha actualizado el archivo de sincronización:${NC}"
            echo -e "${GREEN}  ./bd/world3d_current.sql${NC}"
        else
            echo -e "${RED}✗ Error al crear la copia de seguridad${NC}"
            echo -e "${YELLOW}Verifica que la base de datos 'World3D' exista y el usuario 'admin' tenga acceso.${NC}"
        fi
        ;;
        
    2)
        # Restaurar backup
        echo ""
        echo -e "${BLUE}Copias de seguridad disponibles:${NC}"
        
        # Listar archivos disponibles
        FILES=(./bd/*.sql)
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
        read -p "¿Está seguro de continuar? [s/N]: " confirm
        
        if [[ $confirm != [sS] ]]; then
            echo -e "${BLUE}Operación cancelada${NC}"
            exit 0
        fi
        
        # Crear una copia de seguridad antes de restaurar
        BACKUP_FILENAME="world3d_before_restore_$(date +%Y%m%d_%H%M%S).sql"
        echo -e "${YELLOW}Creando copia de seguridad de la base de datos actual antes de restaurar...${NC}"
        docker exec World3D-db pg_dump -U admin World3D > ./bd/$BACKUP_FILENAME
        
        if [ $? -eq 0 ] && [ -s "./bd/$BACKUP_FILENAME" ]; then
            echo -e "${GREEN}✓ Backup previo creado en: ./bd/$BACKUP_FILENAME${NC}"
        else
            echo -e "${YELLOW}⚠️ No se pudo crear un backup previo. Continuando con la restauración...${NC}"
        fi
        
        # Ejecutar eliminación y creación de la base de datos antes de restaurar
        echo -e "${BLUE}Preparando base de datos para restauración limpia...${NC}"
        # Desconectar usuarios y eliminar base de datos
        docker exec -i World3D-db psql -U admin postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'World3D';"
        docker exec -i World3D-db psql -U admin postgres -c "DROP DATABASE IF EXISTS World3D;"
        docker exec -i World3D-db psql -U admin postgres -c "CREATE DATABASE World3D;"
        
        # Ejecutar restauración
        echo -e "${BLUE}Restaurando la base de datos desde el archivo seleccionado...${NC}"
        cat $SELECTED_FILE | docker exec -i World3D-db psql -U admin World3D
        
        # Verificar resultado
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Base de datos restaurada correctamente${NC}"
        else
            echo -e "${RED}✗ Error al restaurar la base de datos${NC}"
            echo -e "${YELLOW}Es posible que el archivo de backup esté corrupto o sea incompatible.${NC}"
        fi
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