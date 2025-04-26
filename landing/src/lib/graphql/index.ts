// src/lib/graphql/index.ts
import { graphqlRequest } from './client';
import {
  FIND_PRODUCT_BY_SLUG,
  FIND_PRODUCT_BY_ID,
  GET_ALL_PRODUCTS,
  UPDATE_PRODUCT_VIEWS,
  CREATE_RATING,
  GET_PRODUCT_RATINGS,
  UPDATE_PRODUCT_RATING
} from './queries';
import { incrementProductViews, ID_TO_SLUG_MAP } from './utils';

// Re-exportar funciones y tipos específicos desde client.ts
// Usar 'export type' para interfaces y types cuando isolatedModules está habilitado
export { createApolloClient } from './client';
export type { 
  ProductAttribute,
  ProductData,
  ProductsResponse,
  ProductResponse,
  RatingsResponse,
  CreateRatingResponse,
  UpdateProductResponse
} from './client';

// Re-exportar la función incrementProductViews directamente
export { incrementProductViews, ID_TO_SLUG_MAP };

// Interfaz para los resultados de producto transformados
interface TransformedProduct {
  id: string;
  documentId?: string;
  slug?: string;
  productName?: string;
  views?: number;
  averageRating?: number;
  totalRatings?: number;
  [key: string]: any; // Para cualquier otra propiedad que pueda tener
}

// Función para encontrar un producto por slug o ID
export async function findProductBySlugOrId(slugOrId: string): Promise<TransformedProduct | null> {
  try {
    console.log(`GraphQL: Buscando producto por slug "${slugOrId}"...`);
    
    // Intenta primero por slug
    const slugResult = await graphqlRequest(FIND_PRODUCT_BY_SLUG, { slug: slugOrId });
    console.log('GraphQL respuesta de búsqueda por slug:', JSON.stringify(slugResult, null, 2));
    
    // Manejar los diferentes formatos posibles de respuesta
    if (slugResult?.products) {
      let productData: any = null;
      
      // Si products es un array
      if (Array.isArray(slugResult.products)) {
        if (slugResult.products.length > 0) {
          productData = slugResult.products[0];
        }
      } 
      // Si products tiene una propiedad data que es un array
      else if (slugResult.products.data && Array.isArray(slugResult.products.data)) {
        if (slugResult.products.data.length > 0) {
          productData = slugResult.products.data[0];
        }
      }
      
      if (productData) {
        console.log('Producto encontrado por slug en GraphQL:', productData);
        return {
          id: productData.id,
          ...(productData.documentId ? { documentId: productData.documentId } : {}),
          ...productData.attributes
        };
      }
    }

    // Si no funciona, intenta por ID (si es un número)
    if (!isNaN(parseInt(slugOrId))) {
      console.log(`GraphQL: Intentando buscar por ID "${slugOrId}"...`);
      const idResult = await graphqlRequest(FIND_PRODUCT_BY_ID, { id: slugOrId });
      console.log('GraphQL respuesta de búsqueda por ID:', JSON.stringify(idResult, null, 2));
      
      // Manejar los diferentes formatos posibles de respuesta
      if (idResult?.product) {
        let productData: any = null;
        
        // Si product es un objeto de tipo ProductData directamente
        if ('id' in idResult.product && 'attributes' in idResult.product) {
          productData = idResult.product;
        } 
        // Si product tiene una propiedad data
        else if ('data' in idResult.product && idResult.product.data) {
          productData = idResult.product.data;
        }
        
        if (productData) {
          console.log('Producto encontrado por ID en GraphQL:', productData);
          return {
            id: productData.id,
            ...(productData.documentId ? { documentId: productData.documentId } : {}),
            ...productData.attributes
          };
        }
      }
    }
    
    // Consulta de diagnóstico para ver todos los productos disponibles
    console.log('GraphQL: Realizando consulta de diagnóstico para ver todos los productos...');
    const diagResult = await graphqlRequest(GET_ALL_PRODUCTS);
    
    let availableProducts: string[] = [];
    if (diagResult?.products) {
      if (Array.isArray(diagResult.products)) {
        availableProducts = diagResult.products.map((p: any) => `${p.id}: ${p.attributes?.slug || 'sin slug'}`);
      } else if (diagResult.products.data && Array.isArray(diagResult.products.data)) {
        availableProducts = diagResult.products.data.map((p: any) => `${p.id}: ${p.attributes?.slug || 'sin slug'}`);
      }
    }
    
    console.log('GraphQL productos disponibles:', availableProducts.length > 0 ? availableProducts : 'Ninguno encontrado');
    
    return null; // No se encontró el producto
  } catch (error) {
    console.error('Error al buscar producto por GraphQL:', error);
    return null;
  }
}

// Función para actualizar las vistas de un producto usando GraphQL
// Usa la función incrementProductViews de utils.ts directamente
export async function updateProductViewsGraphQL(slugOrId: string): Promise<number> {
  try {
    console.log("GraphQL: Intentando actualizar vistas para:", slugOrId);
    
    // Usamos la función importada de utils.ts
    const result = await incrementProductViews(slugOrId);
    
    if (result.incremented) {
      console.log("GraphQL: Vistas actualizadas correctamente en Strapi:", result.views);
      return result.views || 1;
    } else {
      console.log("GraphQL: No se incrementaron las vistas:", result.message);
      
      // Intentamos obtener el producto para al menos devolver las vistas actuales
      const product = await findProductBySlugOrId(slugOrId);
      if (product && typeof product.views === 'number') {
        return product.views;
      }
      
      return 1; // Valor por defecto si no pudimos obtener las vistas
    }
  } catch (error) {
    console.error("GraphQL: Error al actualizar vistas:", error);
    return 1; // Valor simulado en caso de error
  }
}

// Función para enviar una valoración para un producto usando GraphQL
export async function submitRatingGraphQL(
  slugOrId: string, 
  rating: number
): Promise<{ averageRating: number; totalRatings: number }> {
  try {
    console.log(`GraphQL: Enviando valoración ${rating} para:`, slugOrId);
    
    // Buscar el producto primero
    const product = await findProductBySlugOrId(slugOrId);
    if (!product) {
      console.log(`Producto ${slugOrId} no encontrado en Strapi, usando valoración simulada`);
      return { averageRating: rating, totalRatings: 1 }; // Valor simulado
    }
    
    // 1. Crear una nueva valoración
    const createRatingResult = await graphqlRequest(CREATE_RATING, {
      rating: rating,
      product: product.id
    });
    
    // Verificar el resultado de crear valoración
    let ratingCreated = false;
    
    if (createRatingResult?.createProductRating) {
      if ('id' in createRatingResult.createProductRating || 'documentId' in createRatingResult.createProductRating) {
        ratingCreated = true;
      } else if ('data' in createRatingResult.createProductRating && 
                createRatingResult.createProductRating.data &&
                'id' in createRatingResult.createProductRating.data) {
        ratingCreated = true;
      }
    }
    
    if (!ratingCreated) {
      throw new Error("No se pudo crear la valoración");
    }
    
    // 2. Obtener todas las valoraciones para calcular el promedio
    const ratingsResult = await graphqlRequest(GET_PRODUCT_RATINGS, {
      productId: product.id
    });
    
    // Extraer los ratings dependiendo del formato de respuesta
    let ratings: Array<{ rating: number }> = [];
    
    if (ratingsResult?.productRatings) {
      if (Array.isArray(ratingsResult.productRatings)) {
        ratings = ratingsResult.productRatings.map((r: any) => ({ rating: r.rating }));
      } else if ('data' in ratingsResult.productRatings && 
                Array.isArray(ratingsResult.productRatings.data)) {
        ratings = ratingsResult.productRatings.data.map((r: any) => ({ 
          rating: r.attributes.rating 
        }));
      }
    }
    
    const totalRatings = ratings.length;
    let ratingSum = 0;
    
    // Calcular la suma de valoraciones
    ratings.forEach(ratingItem => {
      ratingSum += ratingItem.rating;
    });
    
    // Calcular la valoración media
    const averageRating = totalRatings > 0 ? ratingSum / totalRatings : 0;
    const roundedAverage = parseFloat(averageRating.toFixed(1));
    
    // 3. Actualizar el producto con la nueva valoración media
    const updateResult = await graphqlRequest(UPDATE_PRODUCT_RATING, {
      id: product.id,
      averageRating: roundedAverage,
      totalRatings: totalRatings
    });
    
    // Extraer datos actualizados dependiendo del formato de respuesta
    let updatedAverage = roundedAverage;
    let updatedTotal = totalRatings;
    
    if (updateResult?.updateProduct) {
      if ('averageRating' in updateResult.updateProduct) {
        updatedAverage = updateResult.updateProduct.averageRating || updatedAverage;
        updatedTotal = updateResult.updateProduct.totalRatings || updatedTotal;
      } else if ('data' in updateResult.updateProduct && 
                updateResult.updateProduct.data && 
                'attributes' in updateResult.updateProduct.data) {
        updatedAverage = updateResult.updateProduct.data.attributes.averageRating || updatedAverage;
        updatedTotal = updateResult.updateProduct.data.attributes.totalRatings || updatedTotal;
      }
      
      console.log("GraphQL: Valoración guardada y promedio actualizado correctamente");
    } else {
      console.error("GraphQL: No se pudo actualizar la valoración media");
    }
    
    return {
      averageRating: updatedAverage,
      totalRatings: updatedTotal
    };
  } catch (error) {
    console.error("GraphQL: Error al enviar valoración:", error);
    return { averageRating: rating, totalRatings: 1 }; // Valor simulado en caso de error
  }
}