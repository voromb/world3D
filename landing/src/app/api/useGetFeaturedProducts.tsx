"use client";

import { useState, useEffect } from "react";
import { ResponseType } from "@/types/response";
import { ProductType } from "@/types/product";

export const useGetFeaturedProducts = (): ResponseType => {
  const [result, setResult] = useState<ProductType[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchFeaturedProducts = async () => {
      try {
        setLoading(true);

        // URL para obtener todos los productos con un límite alto para evitar paginación
        const url = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?populate=*&pagination[limit]=100`;

        console.log("Fetching products from:", url);

        const response = await fetch(url);

        if (!response.ok) {
          throw new Error(`Error de API: ${response.status}`);
        }

        const data = await response.json();

        if (data && Array.isArray(data.data)) {
          console.log(`Recibidos ${data.data.length} productos totales`);
          
          // Mostrar información sobre paginación si está disponible
          if (data.meta && data.meta.pagination) {
            console.log("Información de paginación:", {
              page: data.meta.pagination.page,
              pageSize: data.meta.pagination.pageSize, 
              total: data.meta.pagination.total,
              pageCount: data.meta.pagination.pageCount
            });
          }
          
          // Logueamos los tipos de datos para inspección
          console.log("Muestra de productos:", data.data.slice(0, 3).map((p: ProductType) => ({
            id: p.id,
            name: p.productName,
            isFeatured: p.isFeatured,
            typeOfIsFeatured: typeof p.isFeatured
          })));

          // Filtrar productos con isFeatured = true
          const featuredProducts = data.data.filter(
            (product: ProductType) => {
              // Verificación de isFeatured
              const isFeature = product && product.isFeatured === true;
              
              if (isFeature) {
                console.log(`Producto destacado: ${product.id} - ${product.productName}`);
              }
              
              return isFeature;
            }
          );
          
          // Listar IDs de todos los productos destacados para depuración
          console.log(
            `IDs de productos destacados: ${featuredProducts.map((p: ProductType) => p.id).join(', ')}`
          );

          console.log(
            `Encontrados ${featuredProducts.length} productos destacados`
          );

          if (featuredProducts.length > 0) {
            setResult(featuredProducts);
          } else {
            // Si no hay productos destacados, usar los primeros 5
            console.log(
              "No se encontraron productos destacados, usando los primeros 5"
            );
            setResult(data.data.slice(0, 5));
          }
        } else {
          console.error("Formato de respuesta inesperado:", data);
          setError("La API devolvió un formato inesperado");
          setResult([]);
        }
      } catch (err) {
        console.error("Error al cargar productos destacados:", err);
        setError(err instanceof Error ? err.message : "Error desconocido");
        setResult([]);
      } finally {
        setLoading(false);
      }
    };

    fetchFeaturedProducts();
  }, []);

  return { result, loading, error };
};