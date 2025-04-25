import { FilterType, ProductType, ProductsResponse } from "@/types";
import { buildFilterUrl } from "@/lib/utils/filterUtils";

/**
 * Constantes para la población de datos (populate) en las peticiones a la API
 */
export const PRODUCT_POPULATE_FIELDS = {
  // Campos básicos que siempre deben incluirse
  BASIC: ["images", "categories", "brands"],

  // Campos específicos para páginas de detalle que requieren más información
  DETAIL: ["images", "categories", "brands", "reviews", "relatedProducts"],

  // Solo imágenes (útil para listados sencillos)
  IMAGES_ONLY: ["images"],
};

/**
 * Obtiene productos con filtros aplicados
 */
export async function fetchProducts(
  filters: FilterType = {}
): Promise<ProductsResponse> {
  try {
    // Si hay un filtro de marca, asegurarnos de que usamos populate completo
    const populateFields = filters.brand
      ? ["*"] // Cuando filtramos por marca, usamos populate=*
      : filters.populateFields || PRODUCT_POPULATE_FIELDS.BASIC;

    // Debug: Mostrar filtros recibidos
    console.log(
      "fetchProducts - Filtros recibidos:",
      JSON.stringify(filters, null, 2)
    );

    // Si estamos filtrando por marca, mostrar información de diagnóstico
    if (filters.brand) {
      console.log("\n🔍 DIAGNÓSTICO DE FILTRADO DE MARCA 🔍\n");
      console.log(`Filtrando productos por marca: ${filters.brand}`);
    }

    // Construir la URL para consulta
    let apiUrl = buildFilterUrl(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products`,
      filters,
      populateFields
    );

    // Log de la URL completa para verificar
    console.log("fetchProducts - URL de la API:", apiUrl);

    // Si estamos filtrando por marca, asegurar que la URL tiene los parámetros correctos
    // Forzamos los parámetros correctos para asegurar compatibilidad con Strapi
    if (filters.brand) {
      const url = new URL(apiUrl);
      // Eliminar cualquier parámetro de filtro existente para la marca y agregar el correcto
      url.searchParams.forEach((value, key) => {
        if (key.startsWith("filters[brands]")) {
          url.searchParams.delete(key);
        }
      });

      // Agregar el filtro correcto
      url.searchParams.append("filters[brands][slug][$eq]", filters.brand);

      // Asegurar población completa
      url.searchParams.append("populate", "*");

      apiUrl = url.toString();
      console.log("fetchProducts - URL ajustada para filtro de marca:", apiUrl);
    }

    const response = await fetch(apiUrl);

    if (!response.ok) {
      throw new Error(`Error fetching products: ${response.status}`);
    }

    const data = await response.json();

    // Verificar cuántos productos se han encontrado
    console.log(
      `fetchProducts - Productos recibidos: ${data.data?.length || 0}`
    );

    // Si estamos filtrando por marca y no hay resultados, probar con un enfoque alternativo
    if (filters.brand && (!data.data || data.data.length === 0)) {
      console.log(
        `\n⚠️ No se encontraron productos con la marca: ${filters.brand}`
      );
      console.log("Intentando enfoque alternativo...");

      // Enfoque alternativo: Buscar la marca primero y luego los productos relacionados
      const brandUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/brands?filters[slug][$eq]=${filters.brand}&populate=products.images`;
      console.log("URL para buscar marca:", brandUrl);

      try {
        const brandResponse = await fetch(brandUrl);
        const brandData = await brandResponse.json();

        if (brandData.data && brandData.data.length > 0) {
          console.log(
            `Marca encontrada: ${
              brandData.data[0].attributes?.brandName ||
              brandData.data[0].brandName
            }`
          );

          // Extraer productos relacionados
          const brandProducts =
            brandData.data[0].attributes?.products?.data || [];

          if (brandProducts.length > 0) {
            console.log(
              `Productos relacionados encontrados: ${brandProducts.length}`
            );

            // Obtener detalles completos de estos productos
            const productIds = brandProducts.map((p: any) => p.id).join(",");
            const detailedProductsUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?filters[id][$in]=${productIds}&populate=*`;

            const detailedResponse = await fetch(detailedProductsUrl);
            const detailedData = await detailedResponse.json();

            return {
              data: detailedData.data || [],
              meta: detailedData.meta || {
                pagination: {
                  page: 1,
                  pageSize: 100,
                  pageCount: 1,
                  total: detailedData.data?.length || 0,
                },
              },
            };
          }
        }
      } catch (altError) {
        console.error("Error en enfoque alternativo:", altError);
      }
    }

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
