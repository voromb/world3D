"use client";

import React, { useEffect, useState } from "react";
import Link from "next/link";
import Image from "next/image";
import { ProductType } from "@/types";
import { ChevronLeft, ChevronRight, ShoppingCart } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useCartStore } from "@/lib/store/cart-store";

interface ProductCardProps {
  product: ProductType;
}

const ProductCard: React.FC<ProductCardProps> = ({ product }) => {
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [hasValidImages, setHasValidImages] = useState(false);
  const [imageUrls, setImageUrls] = useState<string[]>(['/placeholder.svg']);

  // Función para generar URLs de imágenes completas
  const getImageUrl = (imagePath: string): string => {
    if (!imagePath) return "/placeholder.svg";
    if (imagePath.startsWith("http")) return imagePath;
    return `${process.env.NEXT_PUBLIC_BACKEND_URL}${imagePath}`;
  };

  // Funciones para navegar entre imágenes
  const prevImage = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setCurrentImageIndex((prevIndex) => 
      prevIndex > 0 ? prevIndex - 1 : imageUrls.length - 1
    );
  };

  const nextImage = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setCurrentImageIndex((prevIndex) => 
      prevIndex < imageUrls.length - 1 ? prevIndex + 1 : 0
    );
  };

  // Efecto para procesar las imágenes cuando el producto cambia
  useEffect(() => {
    try {
      if (product.images && Array.isArray(product.images) && product.images.length > 0) {
        // Procesar todas las imágenes y extraer sus URLs
        const urls = product.images.map(image => {
          if (image.url) {
            return getImageUrl(image.url);
          } else if (image.formats) {
            // Intentar obtener diferentes tamaños, preferir thumbnail por rendimiento
            const url = image.formats.thumbnail?.url || image.formats.small?.url || image.formats.medium?.url;
            return url ? getImageUrl(url) : '/placeholder.svg';
          }
          return '/placeholder.svg';
        });
        
        // Filtrar cualquier placeholder
        const validUrls = urls.filter(url => url !== '/placeholder.svg');
        
        if (validUrls.length > 0) {
          setImageUrls(validUrls);
          setHasValidImages(true);
          setCurrentImageIndex(0); // Reiniciar al índice 0 cuando cambian las imágenes
          console.log(`${validUrls.length} imágenes cargadas para ${product.productName}`);
        } else {
          setImageUrls(['/placeholder.svg']);
          setHasValidImages(false);
        }
      } else {
        setImageUrls(['/placeholder.svg']);
        setHasValidImages(false);
      }
    } catch (error) {
      setImageUrls(['/placeholder.svg']);
      setHasValidImages(false);
      console.error(`Error al procesar imágenes para ${product.productName}:`, error);
    }
  }, [product]);

  // Función para manejar errores de carga de imágenes
  const handleImageError = (e: React.SyntheticEvent<HTMLImageElement, Event>) => {
    console.error(`Error cargando imagen para ${product.productName}`);
    e.currentTarget.src = '/placeholder.svg';
  };

  // Función para añadir al carrito
  const { addItem } = useCartStore();
  
  const handleAddToCart = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    
    addItem({
      documentId: String(product.documentId || product.id),
      productName: product.productName,
      price: Number(product.price) || 0,
      quantity: 1,
      slug: product.slug,
      imageUrl: imageUrls[0] !== '/placeholder.svg' ? imageUrls[0] : undefined
    });
  };

  return (
    <div className="bg-white rounded-lg shadow-sm border overflow-hidden group hover:shadow-md transition-shadow">
      <div className="block">
        <div className="relative overflow-hidden h-48 bg-gray-100 rounded-t-lg">
          {/* Imagen principal */}
          <div className="relative w-full h-full">
            <Image
              src={imageUrls[currentImageIndex]}
              alt={`${product.productName} - Imagen ${currentImageIndex + 1}`}
              className="object-cover transition-transform group-hover:scale-105 duration-300"
              fill
              sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
              priority={false}
              unoptimized={imageUrls[currentImageIndex].includes('placeholder.svg')}
              onError={handleImageError}
            />
          </div>
          
          {/* Controles del carrusel - Solo visibles si hay más de una imagen */}
          {hasValidImages && imageUrls.length > 1 && (
            <div className="absolute inset-0 flex items-center justify-between p-2 opacity-0 group-hover:opacity-100 transition-opacity">
              <button 
                onClick={prevImage}
                className="bg-black/50 text-white p-1 rounded-full hover:bg-black/70 focus:outline-none"
                aria-label="Imagen anterior"
              >
                <ChevronLeft size={20} />
              </button>
              <button 
                onClick={nextImage}
                className="bg-black/50 text-white p-1 rounded-full hover:bg-black/70 focus:outline-none"
                aria-label="Imagen siguiente"
              >
                <ChevronRight size={20} />
              </button>
            </div>
          )}
        
          {/* Indicadores de imágenes - Solo visibles si hay más de una imagen */}
          {hasValidImages && imageUrls.length > 1 && (
            <div className="absolute bottom-2 left-0 right-0 flex justify-center gap-1">
              {imageUrls.map((_, index) => (
                <button
                  key={index}
                  onClick={(e) => { e.preventDefault(); e.stopPropagation(); setCurrentImageIndex(index); }}
                  className={`w-2 h-2 rounded-full focus:outline-none transition-colors ${currentImageIndex === index ? 'bg-white' : 'bg-white/50'}`}
                  aria-label={`Ir a imagen ${index + 1}`}
                />
              ))}
            </div>
          )}
        
          {/* Insignias */}
          <div className="absolute top-2 left-2 flex flex-col gap-1">
            {product.isFeatured && (
              <span className="bg-blue-600 text-white text-xs px-2 py-1 rounded-md">
                Destacado
              </span>
            )}
          </div>
        </div>

        <div className="p-4">
          <Link href={`/productos/${product.slug}`} className="block">
            <h3
              className="font-semibold text-lg mb-2 line-clamp-2 hover:text-blue-600 transition-colors"
              title={product.productName}
            >
              {product.productName}
            </h3>
          </Link>

          <div className="flex justify-between items-center mb-2">
            <span className="text-blue-600 font-bold">{product.price}€</span>
            <span className="text-sm text-gray-500">{product.cityName}</span>
          </div>

          <div className="flex flex-wrap gap-1 mb-3">
            {product.categories?.map((category) => (
              <span
                key={category.id}
                className="inline-block bg-gray-100 text-gray-800 text-xs px-2 py-1 rounded"
              >
                {category.categoryName}
              </span>
            ))}

            {product.brands?.[0] && (
              <span className="inline-block bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded">
                {product.brands[0].brandName}
              </span>
            )}
          </div>
          
          <Button
            onClick={handleAddToCart}
            variant="outline"
            className="w-full flex items-center justify-center gap-2 mt-2"
            size="sm"
          >
            <ShoppingCart className="h-4 w-4" />
            <span>Añadir al carrito</span>
          </Button>
        </div>
      </div>
    </div>
  );
};

export default ProductCard;