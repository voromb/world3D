//src/components/ui/map/ProductMap.tsx

'use client';

import { useEffect, useState } from 'react';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';
import Link from 'next/link';
import { ProductType } from '@/types';

// Solución para el problema de los iconos de Leaflet en Next.js
const defaultIcon = () => {
  return L.icon({
    iconUrl: '/images/marker-icon.png',
    iconRetinaUrl: '/images/marker-icon-2x.png',
    shadowUrl: '/images/marker-shadow.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41]
  });
};

// Función para obtener URL de imagen completa
const getImageUrl = (product: ProductType, index: number = 0): string => {
  if (!product.images || product.images.length === 0) return "/placeholder.jpg";
  const image = product.images[index];
  if (image.url.startsWith("http")) return image.url;
  return `${process.env.NEXT_PUBLIC_BACKEND_URL}${image.url}`;
};

interface ProductMapProps {
  products: ProductType[];
  height?: string;
  zoom?: number;
  singleProduct?: boolean;
}

// Para evitar errores de tipo, usamos este enfoque
const MapContainerAny: any = MapContainer;
const TileLayerAny: any = TileLayer;
const MarkerAny: any = Marker;

export default function ProductMap({ 
  products, 
  height = '500px', 
  zoom = 2, 
  singleProduct = false 
}: ProductMapProps) {
  const [mapReady, setMapReady] = useState(false);
  const [center, setCenter] = useState<[number, number]>([40.416775, -3.703790]); // Madrid por defecto
  const [currentImageIndex, setCurrentImageIndex] = useState<Record<number, number>>({});

  useEffect(() => {
    // Esto soluciona el problema de "window is not defined" con Leaflet en Next.js
    setMapReady(true);

    // Solución para los iconos en Next.js
    delete (L.Icon.Default.prototype as any)._getIconUrl;
    L.Icon.Default.mergeOptions({
      iconRetinaUrl: '/images/marker-icon-2x.png',
      iconUrl: '/images/marker-icon.png',
      shadowUrl: '/images/marker-shadow.png',
    });

    // Inicializar el estado de las imágenes actuales para cada producto
    const initialIndices: Record<number, number> = {};
    products.forEach(product => {
      initialIndices[product.id] = 0;
    });
    setCurrentImageIndex(initialIndices);

    // Calcular el centro del mapa si es un producto único
    if (singleProduct && products.length > 0 && products[0].latitud && products[0].longitud) {
      setCenter([
        products[0].latitud as number, 
        products[0].longitud as number
      ]);
    } 
    // Si hay múltiples productos y queremos centrar el mapa
    else if (products.length > 0 && !singleProduct) {
      // Calculamos el centro como el promedio de todas las coordenadas
      // Solo si no es un mapa de producto único
      const validProducts = products.filter(p => p.latitud != null && p.longitud != null);
      if (validProducts.length > 0) {
        const sumLat = validProducts.reduce((sum, p) => sum + (p.latitud as number), 0);
        const sumLng = validProducts.reduce((sum, p) => sum + (p.longitud as number), 0);
        setCenter([sumLat / validProducts.length, sumLng / validProducts.length]);
      }
    }
  }, [products, singleProduct]);

  // Función para cambiar la imagen actual de un producto específico
  const changeProductImage = (productId: number, direction: 'next' | 'prev' | number) => {
    setCurrentImageIndex(prev => {
      const currentIndex = prev[productId] || 0;
      const product = products.find(p => p.id === productId);
      
      if (!product || !product.images || product.images.length <= 1) {
        return prev;
      }
      
      const totalImages = product.images.length;
      let newIndex;
      
      if (direction === 'next') {
        newIndex = (currentIndex + 1) % totalImages;
      } else if (direction === 'prev') {
        newIndex = (currentIndex - 1 + totalImages) % totalImages;
      } else {
        newIndex = direction;
      }
      
      return { ...prev, [productId]: newIndex };
    });
  };

  if (!mapReady) {
    return <div className="w-full bg-gray-100 flex items-center justify-center" style={{ height }}>Cargando mapa...</div>;
  }

  if (!products || products.length === 0) {
    return <div className="w-full bg-gray-100 flex items-center justify-center" style={{ height }}>No hay productos para mostrar en el mapa</div>;
  }

  // Para TypeScript, le damos un tipo explícito y usamos as para evitar errores
  const mapProps: any = {
    center: singleProduct && products[0]?.latitud != null 
      ? [products[0].latitud as number, products[0].longitud as number] 
      : center,
    zoom: singleProduct ? 14 : zoom,
    style: { height, width: '100%' },
    scrollWheelZoom: true
  };

  return (
    <MapContainerAny {...mapProps}>
      <TileLayerAny
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      
      {products.map((product) => {
        if (product.latitud == null || product.longitud == null) return null;
        
        return (
          <MarkerAny 
            key={product.id} 
            position={[product.latitud as number, product.longitud as number]}
            icon={defaultIcon()}
          >
            <Popup>
              <div className="flex flex-col w-64">
                {/* Carrusel de imágenes */}
                <div className="w-full h-36 overflow-hidden mb-2 rounded relative">
                  {product.images && product.images.length > 0 ? (
                    <>
                      {/* Imagen actual */}
                      <img 
                        src={getImageUrl(product, currentImageIndex[product.id] || 0)} 
                        alt={`${product.productName} - Imagen ${(currentImageIndex[product.id] || 0) + 1}`} 
                        className="w-full h-full object-cover"
                      />
                      
                      {/* Controles del carrusel (solo si hay más de una imagen) */}
                      {product.images.length > 1 && (
                        <>
                          {/* Botón anterior */}
                          <button 
                            onClick={(e) => {
                              e.stopPropagation();
                              changeProductImage(product.id, 'prev');
                            }}
                            className="absolute left-0 top-1/2 transform -translate-y-1/2 bg-black bg-opacity-50 text-white px-2 py-1 rounded-r z-10"
                          >
                            ‹
                          </button>
                          
                          {/* Botón siguiente */}
                          <button
                            onClick={(e) => {
                              e.stopPropagation();
                              changeProductImage(product.id, 'next');
                            }}
                            className="absolute right-0 top-1/2 transform -translate-y-1/2 bg-black bg-opacity-50 text-white px-2 py-1 rounded-l z-10"
                          >
                            ›
                          </button>
                          
                          {/* Indicadores de posición (puntos) */}
                          <div className="absolute bottom-1 left-0 right-0 flex justify-center gap-1 z-10">
                            {product.images.map((_, idx) => (
                              <button
                                key={idx}
                                onClick={(e) => {
                                  e.stopPropagation();
                                  changeProductImage(product.id, idx);
                                }}
                                className={`w-2 h-2 rounded-full ${
                                  (currentImageIndex[product.id] || 0) === idx 
                                    ? 'bg-white' 
                                    : 'bg-gray-400'
                                }`}
                              />
                            ))}
                          </div>
                          
                          {/* Contador de imágenes */}
                          <div className="absolute top-1 right-1 bg-black bg-opacity-50 text-white text-xs px-2 py-1 rounded z-10">
                            {(currentImageIndex[product.id] || 0) + 1}/{product.images.length}
                          </div>
                        </>
                      )}
                    </>
                  ) : (
                    <div className="w-full h-full bg-gray-200 flex items-center justify-center">
                      <span className="text-sm text-gray-500">Sin imagen</span>
                    </div>
                  )}
                </div>
                
                {/* Información del producto */}
                <div className="flex flex-col">
                  <h3 className="text-base font-semibold mb-1">{product.productName}</h3>
                  <p className="text-sm mb-2">{product.price}€</p>
                  
                  {/* Solo mostrar el enlace Ver detalles cuando NO estamos en la página de detalles */}
                  {!singleProduct && (
                    <Link href={`/shop/${product.slug}`}>
                      <span className="text-blue-600 hover:text-blue-800 text-sm font-medium">Ver detalles</span>
                    </Link>
                  )}
                </div>
              </div>
            </Popup>
          </MarkerAny>
        );
      })}
    </MapContainerAny>
  );
}
