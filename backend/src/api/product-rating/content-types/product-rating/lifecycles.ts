// src/api/product-rating/content-types/product-rating/lifecycles.ts

export default {
  // Hook que se ejecuta después de crear una nueva valoración
  async afterCreate(event) {
    try {
      const { result } = event;
      
      // Validación de seguridad para evitar errores
      if (!result || !result.products || !Array.isArray(result.products) || result.products.length === 0) {
        console.error('Error en afterCreate: La estructura de datos no es la esperada', result);
        return;
      }
      
      // Obtener el ID del producto de forma segura
      const productItem = result.products[0];
      const productId = productItem && typeof productItem === 'object' ? productItem.id : 
                         typeof productItem === 'string' ? productItem : null;
      
      if (!productId) {
        console.error('Error en afterCreate: No se pudo obtener el ID del producto', result.products);
        return;
      }
      
      // Obtener todas las valoraciones para este producto
      const ratings = await strapi.entityService.findMany('api::product-rating.product-rating', {
        filters: {
          products: {
            id: productId,
          },
        },
      });
      
      // Calcular la media de las valoraciones
      const totalRatings = ratings.length;
      const ratingSum = ratings.reduce((sum, item) => sum + (item.rating || 0), 0);
      const averageRating = totalRatings > 0 ? ratingSum / totalRatings : 0;
      
      // Actualizar el producto con las nuevas estadísticas
      await strapi.entityService.update('api::product.product', productId, {
        data: {
          averageRating: parseFloat(averageRating.toFixed(1)),
          totalRatings,
        },
      });
    } catch (error) {
      console.error('Error en el hook afterCreate de product-rating:', error);
    }
  },
  
  // Hook que se ejecuta después de eliminar una valoración
  async afterDelete(event) {
    try {
      const { result } = event;
      
      // Validación de seguridad para evitar errores
      if (!result || !result.products || !Array.isArray(result.products) || result.products.length === 0) {
        console.error('Error en afterDelete: La estructura de datos no es la esperada', result);
        return;
      }
      
      // Obtener el ID del producto de forma segura
      const productItem = result.products[0];
      const productId = productItem && typeof productItem === 'object' ? productItem.id : 
                         typeof productItem === 'string' ? productItem : null;
      
      if (!productId) {
        console.error('Error en afterDelete: No se pudo obtener el ID del producto', result.products);
        return;
      }
      
      // Consultar todas las valoraciones restantes para este producto
      const ratings = await strapi.entityService.findMany('api::product-rating.product-rating', {
        filters: {
          products: {
            id: productId,
          },
        },
      });
      
      // Calcular las nuevas estadísticas
      const totalRatings = ratings.length;
      const ratingSum = ratings.reduce((sum, item) => sum + (item.rating || 0), 0);
      const averageRating = totalRatings > 0 ? ratingSum / totalRatings : 0;
      
      // Actualizar el producto con las estadísticas actualizadas
      await strapi.entityService.update('api::product.product', productId, {
        data: {
          averageRating: parseFloat(averageRating.toFixed(1)),
          totalRatings,
        },
      });
    } catch (error) {
      console.error('Error en el hook afterDelete de product-rating:', error);
    }
  },
  
  // Hook que se ejecuta después de actualizar una valoración existente
  async afterUpdate(event) {
    try {
      const { result } = event;
      
      // Validación de seguridad para evitar errores
      if (!result || !result.products || !Array.isArray(result.products) || result.products.length === 0) {
        console.error('Error en afterUpdate: La estructura de datos no es la esperada', result);
        return;
      }
      
      // Obtener el ID del producto de forma segura
      const productItem = result.products[0];
      const productId = productItem && typeof productItem === 'object' ? productItem.id : 
                         typeof productItem === 'string' ? productItem : null;
      
      if (!productId) {
        console.error('Error en afterUpdate: No se pudo obtener el ID del producto', result.products);
        return;
      }
      
      // Obtener todas las valoraciones para este producto
      const ratings = await strapi.entityService.findMany('api::product-rating.product-rating', {
        filters: {
          products: {
            id: productId,
          },
        },
      });
      
      // Calcular la media de las valoraciones
      const totalRatings = ratings.length;
      const ratingSum = ratings.reduce((sum, item) => sum + (item.rating || 0), 0);
      const averageRating = totalRatings > 0 ? ratingSum / totalRatings : 0;
      
      // Actualizar el producto con las nuevas estadísticas
      await strapi.entityService.update('api::product.product', productId, {
        data: {
          averageRating: parseFloat(averageRating.toFixed(1)),
          totalRatings,
        },
      });
    } catch (error) {
      console.error('Error en el hook afterUpdate de product-rating:', error);
    }
  }
};