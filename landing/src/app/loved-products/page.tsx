"use client";

import React, { useEffect, useState } from "react";
import { getUserFavorites, removeFromFavorites } from "@/lib/graphql";
import Image from "next/image";
import Link from "next/link";
import { Heart } from "lucide-react";

// Interfaz para productos favoritos
interface FavoriteProduct {
  documentId: string;
  slug: string;
  productName: string;
  description: string;
  price: number;
  images: { url: string; alternativeText: string }[];
  averageRating: number;
}

interface FavoriteItem {
  documentId: string;
  products: FavoriteProduct[];
}

const FavoritesPage = () => {
  const [favorites, setFavorites] = useState<FavoriteItem[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    const fetchFavorites = async () => {
      try {
        setLoading(true);
        
        // En un sistema real, esto debería obtener el ID del usuario autenticado
        const userId = "1"; // ID de usuario simulado
        
        // Obtener favoritos directamente desde el servidor usando nuestra función modificada
        const userFavorites = await getUserFavorites(userId);
        console.log("Favoritos obtenidos:", userFavorites);
        
        if (Array.isArray(userFavorites) && userFavorites.length > 0) {
          setFavorites(userFavorites);
          console.log(`Favoritos cargados correctamente: ${userFavorites.length}`);
        } else {
          console.warn("No se encontraron favoritos");
          setFavorites([]);
        }
      } catch (error) {
        console.error("Error al cargar favoritos:", error);
        setFavorites([]);
      } finally {
        setLoading(false);
      }
    };

    fetchFavorites();
  }, []);

  const handleRemoveFromFavorites = async (favoriteId: string) => {
    try {
      const success = await removeFromFavorites(favoriteId);
      
      if (success) {
        // Elimina el favorito de la lista local sin usar localStorage
        setFavorites(currentFavorites => 
          currentFavorites.filter(fav => fav.documentId !== favoriteId)
        );
        console.log("Favorito eliminado correctamente");
      }
    } catch (error) {
      console.error("Error al eliminar de favoritos:", error);
    }
  };

  // Función para obtener la primera imagen o una imagen por defecto
  const getProductImage = (images: { url: string }[] | undefined) => {
    if (images && images.length > 0 && images[0].url) {
      return images[0].url;
    }
    return "/placeholder.svg"; // Imagen por defecto
  };

  // Función para extraer productos de todos los favoritos
  const getAllProducts = () => {
    let allProducts: Array<{favoriteId: string, product: FavoriteProduct}> = [];
    
    console.log("Procesando favoritos para mostrar:", favorites.length);
    
    favorites.forEach(favorite => {
      console.log("Procesando favorito:", favorite.documentId, "con productos:", 
        favorite.products && Array.isArray(favorite.products) ? favorite.products.length : 0);
      
      if (favorite.products && Array.isArray(favorite.products)) {
        favorite.products.forEach(product => {
          console.log("Añadiendo producto a la vista:", product.productName || product.documentId);
          
          // Asegurar que el producto tenga todos los campos necesarios
          allProducts.push({
            favoriteId: favorite.documentId,
            product: {
              documentId: product.documentId,
              slug: product.slug || "",
              productName: product.productName || "Producto sin nombre",
              description: product.description || "",
              price: product.price || 0,
              images: product.images || [],
              averageRating: product.averageRating || 0
            }
          });
        });
      }
    });
    
    console.log("Total de productos extraídos:", allProducts.length);
    return allProducts;
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">Mis Productos Favoritos</h1>
      
      {loading ? (
        <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
        </div>
      ) : favorites.length === 0 ? (
        <div className="text-center py-10">
          <Heart className="w-16 h-16 mx-auto text-gray-300 mb-4" />
          <h2 className="text-xl font-semibold text-gray-800">No tienes productos favoritos</h2>
          <p className="text-gray-500 mt-2">Visita nuestra tienda y añade productos a tus favoritos.</p>
          <Link href="/shop" className="inline-block mt-6 px-6 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition-colors">
            Ir a la tienda
          </Link>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {getAllProducts().length === 0 ? (
            <div className="col-span-3 text-center py-10">
              <Heart className="w-16 h-16 mx-auto text-gray-300 mb-4" />
              <h2 className="text-xl font-semibold text-gray-800">No tienes productos favoritos</h2>
              <p className="text-gray-500 mt-2">Visita nuestra tienda y añade productos a tus favoritos.</p>
              <Link href="/shop" className="inline-block mt-6 px-6 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition-colors">
                Ir a la tienda
              </Link>
            </div>
          ) : getAllProducts().map(({favoriteId, product}) => (
            <div key={`${favoriteId}-${product.documentId}`} className="bg-white rounded-lg shadow-md overflow-hidden relative">
              <button
                onClick={() => handleRemoveFromFavorites(favoriteId)}
                className="absolute top-3 right-3 bg-white rounded-full p-2 shadow-md hover:bg-red-50 transition-colors z-10"
              >
                <Heart className="w-5 h-5 text-red-500 fill-red-500" />
              </button>
              
              <Link href={`/shop/${product.slug}`}>
                <div className="relative h-56 w-full">
                  <Image
                    src={getProductImage(product.images)}
                    alt={product.productName}
                    fill
                    style={{ objectFit: "cover" }}
                  />
                </div>
                
                <div className="p-4">
                  <h2 className="text-lg font-semibold text-gray-800 mb-2">{product.productName}</h2>
                  <p className="text-gray-600 text-sm line-clamp-2 mb-3">
                    {product.description || "Sin descripción disponible"}
                  </p>
                  {product.price && (
                    <p className="text-lg font-bold text-blue-600">
                      {new Intl.NumberFormat("es-ES", {
                        style: "currency",
                        currency: "EUR",
                      }).format(product.price)}
                    </p>
                  )}
                </div>
              </Link>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default FavoritesPage;
