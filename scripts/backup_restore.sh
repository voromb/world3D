#!/bin/bash
# Script interactivo para backup y restauración de base de datos PostgreSQL

# Colores para el menú
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Crear directorio de backups si no existe
mkdir -p ./bd

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
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Copia de seguridad creada correctamente en:${NC}"
            echo -e "${GREEN}  ./bd/$FILENAME${NC}"
            
            # Crear también un archivo con nombre fijo para sincronización
            cp ./bd/$FILENAME ./bd/world3d_current.sql
            echo -e "${GREEN}✓ También se ha actualizado el archivo de sincronización:${NC}"
            echo -e "${GREEN}  ./bd/world3d_current.sql${NC}"
        else
            echo -e "${RED}✗ Error al crear la copia de seguridad${NC}"
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
            echo "$((i+1)). $(basename ${FILES[$i]})"
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
        
        # Ejecutar restauración
        cat $SELECTED_FILE | docker exec -i World3D-db psql -U admin World3D
        
        # Verificar resultado
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Base de datos restaurada correctamente${NC}"
        else
            echo -e "${RED}✗ Error al restaurar la base de datos${NC}"
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