import { FilterType, ProductType, ProductsResponse } from "@/types";
import { buildFilterUrl } from "@/lib/utils/filterUtils";

/**
 * Obtiene productos con filtros aplicados
 */
export async function fetchProducts(
  filters: FilterType = {}
): Promise<ProductsResponse> {
  try {
    const apiUrl = buildFilterUrl(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products`,
      filters
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
