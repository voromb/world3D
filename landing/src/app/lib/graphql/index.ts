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
import type {
  ProductsResponse,
  ProductResponse,
  UpdateProductResponse,
  RatingsResponse,
  CreateRatingResponse
} from './client';

// Función para encontrar un producto por slug o ID
export async function findProductBySlugOrId(slugOrId: string) {
  try {
    console.log(`GraphQL: Buscando producto por slug "${slugOrId}"...`);
    
    // Intenta primero por slug
    const slugResult = await graphqlRequest<ProductsResponse>(FIND_PRODUCT_BY_SLUG, { slug: slugOrId });
    console.log('GraphQL respuesta de búsqueda por slug:', JSON.stringify(slugResult, null, 2));
    
    if (slugResult?.products?.data && slugResult.products.data.length > 0) {
      console.log('Producto encontrado por slug en GraphQL:', slugResult.products.data[0]);
      return {
        id: slugResult.products.data[0].id,
        ...slugResult.products.data[0].attributes
      };
    }

    // Si no funciona, intenta por ID (si es un número)
    if (!isNaN(parseInt(slugOrId))) {
      console.log(`GraphQL: Intentando buscar por ID "${slugOrId}"...`);
      const idResult = await graphqlRequest<ProductResponse>(FIND_PRODUCT_BY_ID, { id: slugOrId });
      console.log('GraphQL respuesta de búsqueda por ID:', JSON.stringify(idResult, null, 2));
      
      if (idResult?.product?.data) {
        console.log('Producto encontrado por ID en GraphQL:', idResult.product.data);
        return {
          id: idResult.product.data.id,
          ...idResult.product.data.attributes
        };
      }
    }
    
    // Consulta de diagnóstico para ver todos los productos disponibles
    console.log('GraphQL: Realizando consulta de diagnóstico para ver todos los productos...');
    const diagResult = await graphqlRequest<ProductsResponse>(GET_ALL_PRODUCTS);
    console.log('GraphQL productos disponibles:', 
      diagResult?.products?.data ? 
      diagResult.products.data.map((p) => `${p.id}: ${p.attributes.slug || 'sin slug'}`) : 
      'Ninguno encontrado');
    
    return null; // No se encontró el producto
  } catch (error) {
    console.error('Error al buscar producto por GraphQL:', error);
    return null;
  }
}

// Función para actualizar las vistas de un producto usando GraphQL
export async function updateProductViewsGraphQL(slugOrId: string): Promise<number> {
  try {
    console.log("GraphQL: Intentando actualizar vistas para:", slugOrId);
    
    // Buscar el producto primero
    const product = await findProductBySlugOrId(slugOrId);
    if (!product) {
      console.log(`Producto ${slugOrId} no encontrado en Strapi, usando contador simulado`);
      return 1; // Valor simulado
    }
    
    // Incrementar las vistas
    const currentViews = typeof product.views === 'number' ? product.views : 0;
    const newViews = currentViews + 1;
    
    // Actualizar en Strapi
    const updateResult = await graphqlRequest<UpdateProductResponse>(UPDATE_PRODUCT_VIEWS, {
      id: product.id,
      views: newViews
    });
    
    if (updateResult?.updateProduct?.data?.attributes?.views !== undefined) {
      console.log("GraphQL: Vistas actualizadas correctamente en Strapi:", 
        updateResult.updateProduct.data.attributes.views);
      return updateResult.updateProduct.data.attributes.views;
    } else {
      console.error("GraphQL: No se pudo actualizar las vistas en Strapi");
      return newViews; // Devolver el nuevo valor aunque no se haya guardado
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
    const createRatingResult = await graphqlRequest<CreateRatingResponse>(CREATE_RATING, {
      rating: rating,
      product: product.id
    });
    
    if (!createRatingResult?.createProductRating?.data?.id) {
      throw new Error("No se pudo crear la valoración");
    }
    
    // 2. Obtener todas las valoraciones para calcular el promedio
    const ratingsResult = await graphqlRequest<RatingsResponse>(GET_PRODUCT_RATINGS, {
      productId: product.id
    });
    
    const ratings = ratingsResult?.productRatings?.data || [];
    const totalRatings = ratings.length;
    let ratingSum = 0;
    
    // Calcular la suma de valoraciones
    ratings.forEach((ratingItem: { attributes: { rating: number } }) => {
      ratingSum += ratingItem.attributes.rating;
    });
    
    // Calcular la valoración media
    const averageRating = totalRatings > 0 ? ratingSum / totalRatings : 0;
    
    // 3. Actualizar el producto con la nueva valoración media
    const updateResult = await graphqlRequest<UpdateProductResponse>(UPDATE_PRODUCT_RATING, {
      id: product.id,
      averageRating: parseFloat(averageRating.toFixed(1)),
      totalRatings: totalRatings
    });
    
    if (updateResult?.updateProduct?.data?.attributes) {
      console.log("GraphQL: Valoración guardada y promedio actualizado correctamente");
      return {
        averageRating: updateResult.updateProduct.data.attributes.averageRating || averageRating,
        totalRatings: updateResult.updateProduct.data.attributes.totalRatings || totalRatings
      };
    } else {
      console.error("GraphQL: No se pudo actualizar la valoración media");
      return {
        averageRating: parseFloat(averageRating.toFixed(1)),
        totalRatings: totalRatings
      };
    }
  } catch (error) {
    console.error("GraphQL: Error al enviar valoración:", error);
    return { averageRating: rating, totalRatings: 1 }; // Valor simulado en caso de error
  }
}
