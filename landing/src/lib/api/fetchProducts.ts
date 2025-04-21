import { FilterType, ProductType, ProductsResponse } from "@/types";
import { buildFilterUrl } from "@/lib/utils/filterUtils";

/**
 * Constantes para la población de datos (populate) en las peticiones a la API
 */
export const PRODUCT_POPULATE_FIELDS = {
  // Campos básicos que siempre deben incluirse
  BASIC: ['images', 'categories', 'brands'],
  
  // Campos específicos para páginas de detalle que requieren más información
  DETAIL: ['images', 'categories', 'brands', 'reviews', 'relatedProducts'],
  
  // Solo imágenes (útil para listados sencillos)
  IMAGES_ONLY: ['images']
};

/**
 * Obtiene productos con filtros aplicados
 */
export async function fetchProducts(
  filters: FilterType = {}
): Promise<ProductsResponse> {
  try {
    // Por defecto usamos los campos básicos a menos que se especifique lo contrario
    const populateFields = filters.populateFields || PRODUCT_POPULATE_FIELDS.BASIC;
    
    const apiUrl = buildFilterUrl(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products`,
      filters,
      populateFields
    );

    const response = await fetch(apiUrl);

    if (!response.ok) {
      throw new Error(`Error fetching products: ${response.status}`);
    }

    const data = await response.json();

    return {
      data: data.data || [],
      meta: data.meta || {
        pagination: { page: 1, pageSize: 100, pageCount: 1, total: 0 },
      },
    };
  } catch (error) {
    console.error("Error fetching products:", error);
    return {
      data: [],
      meta: { pagination: { page: 1, pageSize: 100, pageCount: 1, total: 0 } },
    };
  }
}
