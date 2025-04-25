const fs = require('fs');
const path = require('path');

// Directorios de origen y destino
const leafletDir = path.join(__dirname, '../node_modules/leaflet/dist/images');
const publicImagesDir = path.join(__dirname, '../public/images');

// Crear el directorio de destino si no existe
if (!fs.existsSync(publicImagesDir)) {
  fs.mkdirSync(publicImagesDir, { recursive: true });
}

// Lista de archivos a copiar
const iconFiles = [
  'marker-icon.png',
  'marker-icon-2x.png',
  'marker-shadow.png'
];

// Copiar cada archivo
iconFiles.forEach(file => {
  const sourcePath = path.join(leafletDir, file);
  const destPath = path.join(publicImagesDir, file);
  
  try {
    fs.copyFileSync(sourcePath, destPath);
    console.log(`Copiado: ${file}`);
  } catch (err) {
    console.error(`Error al copiar ${file}:`, err);
  }
});

console.log('Iconos de Leaflet configurados correctamente.');