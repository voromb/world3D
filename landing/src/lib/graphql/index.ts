// src/lib/graphql/index.ts
import { graphqlRequest } from './client';
import {
  FIND_PRODUCT_BY_SLUG,
  FIND_PRODUCT_BY_ID,
  FIND_PRODUCT_BY_DOCUMENT_ID,
  GET_ALL_PRODUCTS,
  UPDATE_PRODUCT_VIEWS,
  CREATE_RATING,
  GET_PRODUCT_RATINGS,
  UPDATE_PRODUCT_RATING,
  GET_USER_FAVORITES,
  ADD_TO_FAVORITE,
  REMOVE_FROM_FAVORITE,
  CHECK_PRODUCT_IN_FAVORITES,
  GET_PRODUCT_REACTIONS,
  GET_USER_REACTION,
  CREATE_REACTION,
  UPDATE_REACTION
} from './queries';
import { incrementProductViews, ID_TO_SLUG_MAP } from './utils';

// Re-exportar funciones y tipos específicos desde client.ts
// Usar 'export type' para interfaces y tipos cuando isolatedModules está habilitado
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

// Re-exportar la función incrementProductViews y el mapeo directamente
export { incrementProductViews, ID_TO_SLUG_MAP };

// Interfaz para estadísticas de reacciones
export interface ReactionStats {
  likes: number;
  dislikes: number;
  userReaction: { id: string; type: 'like' | 'dislike'; active: boolean } | null;
}

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

// Función para encontrar un producto por slug o ID - más robusta para manejar errores
export async function findProductBySlugOrId(slugOrId: string): Promise<TransformedProduct | null> {
  try {
    console.log(`GraphQL: Buscando producto con identificador "${slugOrId}"...`);
    
    // Para evitar problemas de CORS, crear un array con los productos cargados
    // Primero obtener todos los productos disponibles
    try {
      console.log("GraphQL: Obteniendo lista de todos los productos disponibles...");
      const allProducts = await graphqlRequest(GET_ALL_PRODUCTS);
      if (allProducts?.products && Array.isArray(allProducts.products)) {
        console.log(`GraphQL: ${allProducts.products.length} productos disponibles`);
        
        // Mostrar los productos disponibles para depuración
        const availableProducts = allProducts.products.map((p: any) => 
          `${p.documentId}: ${p.slug}`
        );
        console.log('GraphQL productos disponibles:', availableProducts);
        
        // Buscar el producto directamente en la lista completa
        // Intentar coincidir por documentId primero (más preciso)
        const productByDocumentId = allProducts.products.find(
          (product: any) => product.documentId === slugOrId
        );
        
        if (productByDocumentId) {
          console.log(`Producto encontrado por documentId coincidente en la lista completa:`, productByDocumentId);
          return {
            id: productByDocumentId.documentId,
            ...productByDocumentId
          };
        }
        
        // Luego intentar coincidir por slug
        const productBySlug = allProducts.products.find(
          (product: any) => product.slug === slugOrId
        );
        
        if (productBySlug) {
          console.log(`Producto encontrado por slug coincidente en la lista completa:`, productBySlug);
          return {
            id: productBySlug.documentId,
            ...productBySlug
          };
        }
        
        // Finalmente por id numérico si es aplicable
        if (!isNaN(parseInt(slugOrId))) {
          const numericId = parseInt(slugOrId);
          const productById = allProducts.products.find(
            (product: any) => product.id === numericId
          );
          
          if (productById) {
            console.log(`Producto encontrado por ID numérico coincidente en la lista completa:`, productById);
            return {
              id: productById.documentId,
              ...productById
            };
          }
        }
      }
    } catch (listError) {
      console.error("Error al obtener lista completa de productos:", listError);
    }
    
    // Si no funcionaron los métodos anteriores, informar que no encontramos el producto
    console.log(`No se pudo encontrar el producto con identificador: ${slugOrId}`);
    return null;
  } catch (error) {
    console.error('Error general al buscar producto:', error);
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

    // Intentar obtener información del producto primero
    const product = await findProductBySlugOrId(slugOrId);
    if (!product) {
      console.log(`No se encontró el producto ${slugOrId}, usando valor simulado`); 
      return { averageRating: rating, totalRatings: 1 };
    }
    
    const productId = product.documentId || product.id;
    console.log(`Producto encontrado con ID: ${productId}, enviando valoración: ${rating}`);
    
    // 1. Crear la valoración directamente
    try {
      const createResult = await graphqlRequest(CREATE_RATING, {
        rating: rating,
        productId: productId
      });
      
      console.log('Resultado creación valoración:', JSON.stringify(createResult, null, 2));
      
      // Verificar que la creación de la valoración fue exitosa
      if (!createResult?.data?.createProductRating) {
        console.error('Error al crear valoración - formato de respuesta incorrecto');
        return { averageRating: rating, totalRatings: 1 };
      }
      
      // Extraer el rating directamente del campo rating
      const ratingValue = createResult.data.createProductRating.rating;
      
      console.log(`Valoración creada correctamente con rating: ${ratingValue}`);
      
      
      // 2. Actualizar la media y el total de valoraciones del producto
      // Como ya tenemos el rating actual, añadimos 1 al total y recalculamos
      const currentAverage = product.averageRating || 0;
      const currentTotal = product.totalRatings || 0;
      
      // Calcular nuevo promedio y total
      let newTotal = currentTotal + 1;
      let newAverage: number;
      
      if (currentTotal === 0) {
        // Si es la primera valoración, el promedio es igual al rating
        newAverage = rating;
      } else {
        // Recalcular: (promedio_actual * total_actual + nuevo_rating) / (total_actual + 1)
        newAverage = ((currentAverage * currentTotal) + rating) / newTotal;
      }
      
      // Redondear a un decimal
      const roundedAverage = parseFloat(newAverage.toFixed(1));
      
      console.log(`Actualizando valoración: anterior (${currentAverage}/${currentTotal}) -> nueva (${roundedAverage}/${newTotal})`);
      
      // 3. Actualizar el producto con la nueva media y total
      try {
        const updateResult = await graphqlRequest(UPDATE_PRODUCT_RATING, {
          documentId: productId,
          averageRating: roundedAverage,
          totalRatings: newTotal
        });
        
        console.log('Resultado actualización producto:', JSON.stringify(updateResult, null, 2));
        
        // Verificar que la actualización fue exitosa
        if (updateResult?.data?.updateProduct) {
          const updatedProduct = updateResult.data.updateProduct;
          console.log(`Valoración guardada con éxito: ${rating}`);
          console.log(`Nueva valoración media: ${updatedProduct.averageRating}, Total de valoraciones: ${updatedProduct.totalRatings}`);
          
          // Usar los valores devueltos por la API, o los calculados si no hay valores devueltos
          return {
            averageRating: updatedProduct.averageRating || roundedAverage,
            totalRatings: updatedProduct.totalRatings || newTotal
          };
        } else {
          console.warn('La actualización del producto no devuelvió datos esperados, usando valores calculados');
          return {
            averageRating: roundedAverage,
            totalRatings: newTotal
          };
        }
      } catch (updateError) {
        console.error('Error al actualizar producto:', updateError);
        // Devolver los valores calculados aunque la actualización haya fallado
        return {
          averageRating: roundedAverage,
          totalRatings: newTotal
        };
      }
    } catch (createError) {
      console.error('Error al crear valoración:', createError);
      return { averageRating: rating, totalRatings: 1 };
    }
  } catch (error) {
    console.error("GraphQL: Error general al enviar valoración:", error);
    return { averageRating: rating, totalRatings: 1 }; // Valor simulado en caso de error
  }
}

// Función para obtener los favoritos de un usuario
export async function getUserFavorites(userId: string): Promise<any[]> {
  try {
    console.log(`GraphQL: Obteniendo favoritos para el usuario ${userId}`);
    
    // Hacemos una solicitud directa al servidor Strapi para obtener los favoritos
    const response = await fetch('http://localhost:1337/graphql', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        query: `
          query {
            favorites(pagination: {limit: 100}) {
              documentId
              products {
                documentId
                slug
                productName
                description
                price
                images {
                  url
                  alternativeText
                }
                averageRating
              }
            }
          }
        `
      }),
    });
    
    const responseData = await response.json();
    console.log('Respuesta directa del servidor Strapi:', JSON.stringify(responseData, null, 2));
    
    if (responseData?.data?.favorites && Array.isArray(responseData.data.favorites)) {
      // Procesamiento de favoritos
      const userFavorites = responseData.data.favorites.map((fav: any) => {
        // Verificar que los productos existan
        const products = Array.isArray(fav.products) ? fav.products : [];
        
        return {
          documentId: fav.documentId,
          products: products.map((product: any) => ({
            documentId: product.documentId,
            slug: product.slug || '',
            productName: product.productName || 'Producto sin nombre',
            description: product.description || '',
            price: product.price || 0,
            images: Array.isArray(product.images) ? product.images.map((img: any) => ({
              url: img.url.startsWith('/uploads/') ? `http://localhost:1337${img.url}` : img.url,
              alternativeText: img.alternativeText || ''
            })) : [],
            averageRating: product.averageRating || 0
          }))
        };
      });
      
      console.log(`Se encontraron ${userFavorites.length} favoritos con ${userFavorites.reduce((total: number, fav: any) => total + (fav.products?.length || 0), 0)} productos`);
      return userFavorites;
    }
    
    console.warn('No se encontraron favoritos en la respuesta GraphQL');
    return [];
  } catch (error) {
    console.error('Error al obtener favoritos:', error);
    return [];
  }
}

// Función para añadir un producto a favoritos
export async function addToFavorites(userId: string, productId: string): Promise<boolean> {
  try {
    console.log(`GraphQL: Añadiendo producto ${productId} a favoritos del usuario ${userId}`);
    
    // Primero verificamos si ya está en favoritos
    const checkResult = await graphqlRequest(CHECK_PRODUCT_IN_FAVORITES, { 
      userId, 
      productId 
    });
    
    if (checkResult?.data?.favorites && checkResult.data.favorites.length > 0) {
      console.log('El producto ya está en favoritos');
      return true; // Ya está en favoritos
    }
    
    // Si no está en favoritos, lo añadimos
    const result = await graphqlRequest(ADD_TO_FAVORITE, { 
      userId, 
      productId 
    });
    
    if (result?.data?.createFavorite?.documentId) {
      console.log('Producto añadido a favoritos con éxito');
      return true;
    }
    
    console.warn('No se pudo añadir el producto a favoritos');
    return false;
  } catch (error) {
    console.error('Error al añadir a favoritos:', error);
    return false;
  }
}

// Función para eliminar un producto de favoritos
export async function removeFromFavorites(favoriteId: string): Promise<boolean> {
  try {
    console.log(`GraphQL: Eliminando favorito con ID ${favoriteId}`);
    
    const result = await graphqlRequest(REMOVE_FROM_FAVORITE, { documentId: favoriteId });
    
    if (result?.data?.deleteFavorite?.documentId) {
      console.log('Producto eliminado de favoritos con éxito');
      return true;
    }
    
    console.warn('No se pudo eliminar el producto de favoritos');
    return false;
  } catch (error) {
    console.error('Error al eliminar de favoritos:', error);
    return false;
  }
}

// Función para verificar si un producto está en favoritos
export async function checkProductInFavorites(userId: string, productId: string): Promise<string | null> {
  try {
    console.log(`GraphQL: Verificando si el producto ${productId} está en favoritos del usuario ${userId}`);

    const result = await graphqlRequest(CHECK_PRODUCT_IN_FAVORITES, {});

    if (result?.favorites && Array.isArray(result.favorites)) {
      // Buscar si el producto está en alguno de los favoritos
      const favorite = result.favorites.find((fav: { products?: any[] }) => {
        if (fav.products && Array.isArray(fav.products)) {
          return fav.products.some((prod: { documentId: string }) => prod.documentId === productId);
        }
        return false;
      });

      if (favorite) {
        return favorite.documentId;
      }
    }

    return null;
  } catch (error) {
    console.error('Error al verificar si está en favoritos:', error);
    return null;
  }
}

// Función para obtener las estadísticas de reacciones de un producto
export async function getProductReactionStats(
  productId: string,
  userId?: string,
  token?: string
): Promise<ReactionStats> {
  try {
    console.log(`GraphQL: Obteniendo estadísticas de reacciones para producto ${productId}`);
    
    const result = await graphqlRequest(GET_PRODUCT_REACTIONS, { productId }, token);
    
    // Valores por defecto
    const stats: ReactionStats = {
      likes: 0,
      dislikes: 0,
      userReaction: null
    };
    
    // Depurar los resultados de la consulta
    console.log('Resultado completo de GET_PRODUCT_REACTIONS:', JSON.stringify(result, null, 2));
    
    // Procesar los resultados para contar likes y dislikes
    if (result?.reactions && Array.isArray(result.reactions)) {
      // Listar todas las reacciones para depuración
      console.log(`Reacciones encontradas (total: ${result.reactions.length}):`, 
                 result.reactions.map((r: any) => ({ documentId: r.documentId, type: r.type, active: r.active })));
      
      // Convertir los valores 'active' a booleanos si son strings
      const reaccionesProcesadas = result.reactions.map((r: any) => ({
        ...r,
        active: typeof r.active === 'string' ? r.active === 'true' : Boolean(r.active)
      }));
      
      console.log('Reacciones procesadas:', reaccionesProcesadas);
      
      // Contar likes activos
      const likesActivos = reaccionesProcesadas.filter(
        (r: any) => r.type === 'like' && r.active === true
      );
      stats.likes = likesActivos.length;
      console.log(`Likes activos encontrados: ${stats.likes}`, likesActivos);
      
      // Contar dislikes activos
      const dislikesActivos = reaccionesProcesadas.filter(
        (r: any) => r.type === 'dislike' && r.active === true
      );
      stats.dislikes = dislikesActivos.length;
      console.log(`Dislikes activos encontrados: ${stats.dislikes}`, dislikesActivos);
      
      // Si se proporcionó userId, intentamos encontrar la reacción directamente en las reacciones obtenidas
      // y como respaldo, usamos getUserReaction
      if (userId) {
        try {
          // Primero intentamos encontrar en el resultado que ya tenemos
          // Esto es más rápido que hacer otra consulta
          console.log(`Buscando reacción del usuario ${userId} entre ${result.reactions.length} reacciones:`);
          
          // Si tenemos reacciones, verificamos si alguna pertenece al usuario a través de una consulta adicional
          const userReactionResult = await getUserReaction(productId, userId, token);
          console.log('Reacción del usuario obtenida por separado:', userReactionResult);
          
          if (userReactionResult) {
            stats.userReaction = userReactionResult;
            console.log('Reacción del usuario final:', stats.userReaction);
          }
        } catch (error) {
          console.error('Error al obtener la reacción del usuario específico:', error);
        }
      }
    }
    
    console.log('Estadísticas de reacciones:', stats);
    return stats;
    
  } catch (error) {
    console.error('Error al obtener estadísticas de reacciones:', error);
    return {
      likes: 0,
      dislikes: 0,
      userReaction: null
    };
  }
}

// Función para obtener la reacción de un usuario en un producto
export async function getUserReaction(
  productId: string,
  userId: string,
  token?: string
): Promise<{ id: string; type: 'like' | 'dislike'; active: boolean } | null> {
  try {
    console.log(`GraphQL: Verificando reacción del usuario ${userId} para producto ${productId}`);
    
    // Como no podemos filtrar por userId en GraphQL debido a permisos,
    // obtenemos todas las reacciones del producto 
    const result = await graphqlRequest<any>(GET_USER_REACTION, { 
      productId
    }, token);
    
    console.log('Resultado de getUserReaction:', JSON.stringify(result, null, 2));
    
    // Como no podemos filtrar por usuario debido a las restricciones de permisos,
    // esta información debe venir del backend a través de la API REST
    // Por ahora, verificamos si hay alguna reacción
    if (result?.reactions && result.reactions.length > 0) {
      // Aquí deberíamos tener solo la reacción del usuario actual
      // Pero por ahora obtenemos la primera (esto se debe mejorar en el backend)
      const userReaction = result.reactions[0];
      
      console.log('Reacción encontrada:', userReaction);
      
      if (userReaction) {
        return {
          id: userReaction.documentId,
          type: userReaction.type as 'like' | 'dislike',
          active: userReaction.active
        };
      }
    }
    
    return null;
  } catch (error) {
    console.error('Error al obtener la reacción del usuario:', error);
    return null;
  }
}

// Función para alternar una reacción (like/dislike)
export async function toggleReaction(
  productId: string,
  userId: string,
  type: 'like' | 'dislike',
  token?: string
): Promise<boolean> {
  try {
    console.log(`GraphQL: Alternando reacción ${type} para usuario ${userId} en producto ${productId}`);
    
    // Verificar si ya existe una reacción
    // Asegurarse de que estamos usando documentId para productos y usuarios
    // Si productId parece ser un ID numérico, lo usamos directamente. Si no, asumimos que es documentId
    const isNumericProductId = /^\d+$/.test(String(productId));
    
    if (isNumericProductId) {
      console.log(`Usando ID numérico ${productId} para búsqueda, puede causar problemas si Strapi espera documentId`);
    } else {
      console.log(`Usando documentId ${productId} para búsqueda`);
    }
    
    const existingReaction = await getUserReaction(productId, userId, token);
    console.log('Reacción existente:', existingReaction);
    
    if (existingReaction) {
      // Si ya existe, actualizar
      let active: boolean;
      let newType: 'like' | 'dislike';
      
      if (existingReaction.type === type) {
        // Mismo tipo, alternar estado activo
        active = !existingReaction.active;
        newType = type;
      } else {
        // Diferente tipo, activar y cambiar tipo
        active = true;
        newType = type;
      }
      
      console.log(`Actualizando reacción: id=${existingReaction.id}, type=${newType}, active=${active}`);
      
      const updateResult = await graphqlRequest<any>(UPDATE_REACTION, {
        id: existingReaction.id,
        type: newType,
        active
      }, token);
      
      console.log('Resultado de actualización:', JSON.stringify(updateResult, null, 2));
      return !!updateResult?.updateReaction;
    } else {
      // Si no existe, crear una nueva
      console.log(`Creando nueva reacción: productId=${productId}, userId=${userId}, type=${type}`);
      
      const createResult = await graphqlRequest<any>(CREATE_REACTION, {
        productId,
        userId,
        type,
        active: true
      }, token);
      
      console.log('Resultado de creación:', JSON.stringify(createResult, null, 2));
      
      // Verificar si la creación fue exitosa - la respuesta de Strapi contiene datos en createReaction
      const success = createResult && 
                     createResult.data && 
                     createResult.data.createReaction && 
                     createResult.data.createReaction.documentId;
      
      console.log(`Reacción creada exitosamente: ${success ? 'Sí' : 'No'}`);
      if (success) {
        console.log(`ID de la nueva reacción: ${createResult.data.createReaction.documentId}`);
      }
      
      return success;
    }
  } catch (error) {
    console.error('Error al alternar reacción:', error);
    return false;
  }
}