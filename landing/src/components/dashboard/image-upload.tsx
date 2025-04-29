'use client';

import { useState } from 'react';
import { Upload, X, Image as ImageIcon } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { useSession } from 'next-auth/react';
import Image from 'next/image';

interface ImageUploadProps {
  existingImages?: {
    url: string;
    width?: number;
    height?: number;
    alternativeText?: string;
  }[];
  onImagesChange: (images: File[]) => void;
  onExistingImagesRemove?: (index: number) => void;
}

export default function ImageUpload({ 
  existingImages = [], 
  onImagesChange,
  onExistingImagesRemove
}: ImageUploadProps) {
  const [selectedFiles, setSelectedFiles] = useState<File[]>([]);
  const [previews, setPreviews] = useState<string[]>([]);
  const { data: session } = useSession();
  
  // Manejar la selección de archivos
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files || e.target.files.length === 0) {
      return;
    }
    
    const files = Array.from(e.target.files);
    
    // Verificar que sean solo imágenes
    const validFiles = files.filter(file => 
      file.type.startsWith('image/')
    );
    
    if (validFiles.length !== files.length) {
      alert('Solo se permiten archivos de imagen');
    }
    
    // Crear URLs de vista previa para las imágenes seleccionadas
    const newPreviews = validFiles.map(file => URL.createObjectURL(file));
    
    setSelectedFiles(prev => [...prev, ...validFiles]);
    setPreviews(prev => [...prev, ...newPreviews]);
    
    // Llamar al callback con los archivos actualizados
    onImagesChange([...selectedFiles, ...validFiles]);
  };
  
  // Eliminar una imagen de la lista de seleccionadas
  const removeSelectedImage = (index: number) => {
    const newSelectedFiles = [...selectedFiles];
    const newPreviews = [...previews];
    
    // Liberar la URL del objeto
    URL.revokeObjectURL(newPreviews[index]);
    
    // Eliminar el archivo y su vista previa
    newSelectedFiles.splice(index, 1);
    newPreviews.splice(index, 1);
    
    setSelectedFiles(newSelectedFiles);
    setPreviews(newPreviews);
    
    // Llamar al callback con los archivos actualizados
    onImagesChange(newSelectedFiles);
  };
  
  return (
    <div className="space-y-4">
      <div className="flex flex-wrap gap-3 mb-4">
        {/* Mostrar imágenes existentes */}
        {existingImages.map((image, index) => (
          <div 
            key={`existing-${index}`} 
            className="relative group w-24 h-24 border rounded-md overflow-hidden"
          >
            <Image
              src={image.url}
              alt={image.alternativeText || `Imagen ${index + 1}`}
              width={image.width || 96}
              height={image.height || 96}
              className="w-full h-full object-cover"
            />
            {onExistingImagesRemove && (
              <button
                type="button"
                onClick={() => onExistingImagesRemove(index)}
                className="absolute top-1 right-1 bg-red-500 text-white rounded-full p-1 opacity-0 group-hover:opacity-100 transition-opacity"
              >
                <X size={14} />
              </button>
            )}
          </div>
        ))}
        
        {/* Mostrar vistas previas de las nuevas imágenes */}
        {previews.map((preview, index) => (
          <div 
            key={`preview-${index}`}
            className="relative group w-24 h-24 border rounded-md overflow-hidden"
          >
            <Image
              src={preview}
              alt={`Vista previa ${index + 1}`}
              width={96}
              height={96} 
              className="w-full h-full object-cover"
            />
            <button
              type="button"
              onClick={() => removeSelectedImage(index)}
              className="absolute top-1 right-1 bg-red-500 text-white rounded-full p-1 opacity-0 group-hover:opacity-100 transition-opacity"
            >
              <X size={14} />
            </button>
          </div>
        ))}
        
        {/* Botón para añadir imágenes */}
        <label 
          htmlFor="image-upload" 
          className="flex flex-col items-center justify-center w-24 h-24 border-2 border-dashed border-gray-300 rounded-md cursor-pointer hover:bg-gray-50"
        >
          <div className="flex flex-col items-center">
            <ImageIcon className="text-gray-400" size={24} />
            <span className="text-xs text-gray-500 mt-1">Añadir</span>
          </div>
          <Input
            id="image-upload"
            type="file"
            accept="image/*"
            multiple
            className="hidden"
            onChange={handleFileChange}
          />
        </label>
      </div>
      
      <div className="text-xs text-gray-500">
        * Puedes seleccionar múltiples imágenes. Formatos admitidos: JPG, PNG, GIF, WebP.
      </div>
    </div>
  );
}
