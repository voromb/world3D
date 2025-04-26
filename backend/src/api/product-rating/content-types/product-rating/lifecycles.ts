// src/api/product-rating/content-types/product-rating/lifecycles.ts

export default {
  // Hook que se ejecuta después de crear una nueva valoración
  async afterCreate(event) {
    const { result } = event;
    
    // Obtener el producto y sus valoraciones
    const productId = result.products[0].id;
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
  },
  
  // Hook que se ejecuta después de eliminar una valoración
  async afterDelete(event) {
    const { result } = event;
    
    // Obtener el producto asociado a la valoración eliminada
    const productId = result.products[0].id;
    
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
  },
  
  // Hook que se ejecuta después de actualizar una valoración existente
  async afterUpdate(event) {
    const { result } = event;
    
    // Obtener el producto y sus valoraciones
    const productId = result.products[0].id;
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
  }
};