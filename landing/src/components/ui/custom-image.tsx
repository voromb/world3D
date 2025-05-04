'use client';

import { useState, useEffect } from 'react';
import Image, { ImageProps } from 'next/image';
import { ShoppingCart } from 'lucide-react';

/**
 * Componente de imagen personalizado que maneja automáticamente los casos de error
 * y proporciona un fallback consistente sin usar placeholder.jpg
 */
export function CustomImage({
  src,
  alt,
  className,
  ...props
}: Omit<ImageProps, 'src'> & {
  src: string | undefined | null;
}) {
  const [error, setError] = useState(false);
  const [imageSrc, setImageSrc] = useState<string>('/placeholder.svg');
  
  useEffect(() => {
    // Actualizar la URL de la imagen cuando cambia src
    if (src) {
      setImageSrc(src);
      setError(false);
    } else {
      setImageSrc('/placeholder.svg');
    }
  }, [src]);

  if (error) {
    return (
      <div className={`relative flex items-center justify-center bg-secondary ${className}`}>
        <ShoppingCart className="h-8 w-8 text-muted-foreground" />
      </div>
    );
  }

  return (
    <Image
      src={imageSrc}
      alt={alt || 'Imagen de producto'}
      className={className}
      onError={() => {
        console.log(`Error al cargar imagen: ${imageSrc}`);
        setError(true);
      }}
      {...props}
    />
  );
}
