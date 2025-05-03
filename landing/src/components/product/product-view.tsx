'use client';

import { useState } from 'react';
import Image from 'next/image';
import { Button } from '@/components/ui/button';
import { AddToCartButton } from '@/components/ui/add-to-cart-button';
import { ShoppingCart, Truck, ArrowLeft } from 'lucide-react';
import Link from 'next/link';

// Interfaz para el producto
interface ProductProps {
  product: {
    documentId: string;
    productName: string;
    slug: string;
    description: string;
    price: number;
    active: boolean;
    isFeatured: boolean;
    dimensions?: string;
    weight?: number;
    State?: string;
    cityName?: string;
    provinceName?: string;
    countryName?: string;
    directionName?: string;
    imageUrl?: string;
  };
}

export function ProductView({ product }: ProductProps) {
  // Estado para imágenes (aquí podrías tener múltiples imágenes)
  const [selectedImage, setSelectedImage] = useState(product.imageUrl || '');

  // Formatear el precio en euros
  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-ES', {
      style: 'currency',
      currency: 'EUR'
    }).format(price);
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Link href="/productos" className="flex items-center gap-2 text-blue-600 hover:text-blue-800 mb-6">
        <ArrowLeft className="h-4 w-4" />
        <span>Volver a productos</span>
      </Link>
      
      <div className="grid md:grid-cols-2 gap-8">
        {/* Columna de imágenes */}
        <div className="space-y-4">
          <div className="aspect-square relative rounded-lg overflow-hidden border bg-gray-50">
            {selectedImage ? (
              <Image
                src={selectedImage}
                alt={product.productName}
                fill
                className="object-cover"
              />
            ) : (
              <div className="w-full h-full flex items-center justify-center bg-gray-100">
                <ShoppingCart className="h-16 w-16 text-gray-400" />
                <span className="sr-only">No hay imagen disponible</span>
              </div>
            )}
          </div>
          
          {/* Aquí podrías añadir una galería de miniaturas si tienes múltiples imágenes */}
        </div>

        {/* Columna de información */}
        <div className="space-y-6">
          <div>
            <h1 className="text-3xl font-bold">{product.productName}</h1>
            <p className="text-2xl font-bold text-blue-600 mt-2">
              {formatPrice(product.price)}
            </p>
          </div>

          <div className="prose max-w-none">
            <p>{product.description}</p>
          </div>

          {/* Estado del producto */}
          {product.State && (
            <div className="bg-blue-50 text-blue-700 px-3 py-1 rounded-full inline-block text-sm font-medium">
              {product.State}
            </div>
          )}

          {/* Detalles de envío */}
          <div className="border-t border-b py-4 space-y-2">
            <div className="flex items-center gap-2">
              <Truck className="h-5 w-5 text-green-600" />
              <span>Envío disponible a {product.countryName || 'España'}</span>
            </div>
            
            {product.weight && (
              <div className="text-sm text-gray-500">
                Peso: {product.weight} kg
              </div>
            )}
            
            {product.dimensions && (
              <div className="text-sm text-gray-500">
                Dimensiones: {product.dimensions}
              </div>
            )}
          </div>

          {/* Ubicación */}
          {(product.cityName || product.provinceName) && (
            <div className="text-sm text-gray-600">
              <p>Ubicación: {[product.cityName, product.provinceName, product.countryName]
                .filter(Boolean)
                .join(', ')}
              </p>
            </div>
          )}

          {/* Botón de añadir al carrito */}
          <div className="pt-4">
            <AddToCartButton product={product} />
          </div>
        </div>
      </div>
    </div>
  );
}
