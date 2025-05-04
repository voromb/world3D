'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { ProductType } from '@/types';
import { 
  Carousel, 
  CarouselContent, 
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
  type CarouselApi
} from "./ui/carousel";
import { Card } from "./ui/card";

const FeaturedProducts: React.FC = () => {
  const [loading, setLoading] = useState(true);
  const [products, setProducts] = useState<ProductType[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [activeIndex, setActiveIndex] = useState<number>(0);
  const [carouselApi, setCarouselApi] = useState<CarouselApi | null>(null);

  // Actualizar el índice activo cuando cambia el API del carrusel
  useEffect(() => {
    if (!carouselApi) return;

    const handleSelect = () => {
      setActiveIndex(carouselApi.selectedScrollSnap());
    };

    carouselApi.on("select", handleSelect);
    return () => {
      carouselApi.off("select", handleSelect);
    };
  }, [carouselApi]);

  useEffect(() => {
    const fetchFeaturedProducts = async () => {
      try {
        // Usa la URL completa con populate para obtener las relaciones
        const url = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?populate=*&pagination[limit]=100`;
        console.log("Fetching featured products from:", url);
        
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error(`Error en la API: ${response.status}`);
        }
        
        const data = await response.json();
        console.log("Response data structure:", JSON.stringify(data).substring(0, 200) + "...");
        
        if (data && data.data && Array.isArray(data.data)) {
          // Filtrar productos destacados
          const featuredProducts = data.data.filter(
            (product: ProductType) => product && product.isFeatured === true
          );
          
          console.log(`Encontrados ${featuredProducts.length} productos destacados`);
          
          if (featuredProducts.length > 0) {
            setProducts(featuredProducts);
          } else {
            // Si no hay productos destacados, usar los primeros 5
            console.log("No se encontraron productos destacados, usando los primeros 5");
            setProducts(data.data.slice(0, 5));
          }
        } else {
          console.error("Formato de respuesta inesperado:", data);
          setError("La API devolvió un formato inesperado");
          setProducts([]);
        }
        
        setLoading(false);
      } catch (error) {
        console.error('Error fetching featured products:', error);
        setError(error instanceof Error ? error.message : "Error desconocido");
        setProducts([]);
        setLoading(false);
      }
    };
    
    fetchFeaturedProducts();
  }, []);

  return (
    <div className="max-w-6xl py-4 mx-auto sm:py-16 sm:px-24">
      <div className="flex justify-between items-center mb-8 px-6">
        <h3 className="text-3xl font-bold">Productos Destacados</h3>
        <Link 
          href="/shop" 
          className="text-blue-600 hover:underline font-medium"
        >
          Ver todos
        </Link>
      </div>
      
      {error && (
        <div className="p-4 text-red-500 text-center">
          Error: {error}
        </div>
      )}
      
      <div className="relative px-14">
        <Carousel 
          className="w-full"
          setApi={setCarouselApi}
        >
          <CarouselContent className="-ml-2 md:ml-4">
            {loading ? (
              // Skeleton para carga
              Array(3).fill(0).map((_, index) => (
                <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/3 group">
                  <div className="p-1">
                    <Card className="py-4 border border-gray-200 shadow-none">
                      <div className="h-48 bg-gray-200 animate-pulse mx-6"></div>
                      <div className="px-6 pt-2">
                        <div className="h-6 bg-gray-200 animate-pulse rounded mb-2"></div>
                        <div className="h-4 bg-gray-200 animate-pulse rounded w-1/3 mx-auto"></div>
                      </div>
                    </Card>
                  </div>
                </CarouselItem>
              ))
            ) : products && products.length > 0 ? (
              products.map((product: ProductType) => (
                <CarouselItem key={product.id} className="md:basis-1/2 lg:basis-1/3 group">
                  <div className="p-1">
                    <Link href={`/shop/${product.slug}`}>
                      <Card className="py-4 border border-gray-200 shadow-none hover:shadow-md transition-shadow duration-300">
                        <div className="relative flex items-center justify-center h-48 px-6 py-2">
                          {product.images && product.images.length > 0 ? (
                            <img
                              src={`${process.env.NEXT_PUBLIC_BACKEND_URL}${product.images[0].url}`}
                              alt={product.productName}
                              className="max-h-full object-contain"
                              onError={(e) => {
                                console.error(`Error cargando imagen: ${product.images[0].url}`);
                                e.currentTarget.src = '/placeholder.svg';
                              }}
                            />
                          ) : (
                            <div className="flex items-center justify-center w-full h-full bg-gray-100">
                              <span className="text-gray-400">Sin imagen</span>
                            </div>
                          )}
                        </div>
                        <div className="px-6 pt-2 text-center">
                          <h4 className="text-lg font-medium truncate">{product.productName}</h4>
                          {product.price && (
                            <p className="font-bold text-blue-600">{product.price.toFixed(2)} €</p>
                          )}
                        </div>
                      </Card>
                    </Link>
                  </div>
                </CarouselItem>
              ))
            ) : (
              <CarouselItem className="basis-full">
                <div className="p-4 text-center">
                  No hay productos destacados disponibles
                </div>
              </CarouselItem>
            )}
          </CarouselContent>
          
          {/* Botones de navegación */}
          {products && products.length > 0 && (
            <>
              <CarouselPrevious 
                className="absolute left-2 -translate-x-full" 
                aria-label="Anterior"
              />
              <CarouselNext 
                className="absolute right-2 translate-x-full" 
                aria-label="Siguiente"
              />
            </>
          )}
        </Carousel>
      </div>
      
      {/* Información de depuración */}
      {products && products.length === 0 && !loading && (
        <div className="p-4 mt-4 text-sm bg-red-50 text-red-800 rounded-md">
          <p>No se encontraron productos para mostrar.</p>
          <p>Verifica que existan productos con isFeatured=true en Strapi.</p>
        </div>
      )}
    </div>
  );
};

export default FeaturedProducts;