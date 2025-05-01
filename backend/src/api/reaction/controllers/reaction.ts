/**
 * Controlador personalizado para reacciones (likes/dislikes)
 */

import { factories } from '@strapi/strapi';
import { Context } from 'koa';

export default factories.createCoreController('api::reaction.reaction', ({ strapi }) => ({
  // Método personalizado para crear o actualizar una reacción
  async toggleReaction(ctx: Context) {
    try {
      const { productId, type } = ctx.request.body;
      const userId = ctx.state.user.id;

      if (!productId || !type || !['like', 'dislike'].includes(type)) {
        return ctx.badRequest('Se requiere ID de producto y tipo válido (like/dislike)');
      }

      // Buscar si ya existe una reacción de este usuario para este producto
      const existingReaction = await strapi.db.query('api::reaction.reaction').findOne({
        where: {
          product: productId,
          users_permissions_user: userId,
        },
      });

      const now = new Date();

      if (existingReaction) {
        // Si ya existe una reacción, actualiza el tipo y el estado activo
        if (existingReaction.type === type) {
          // Si el usuario presiona el mismo botón, toggle el estado active
          await strapi.entityService.update('api::reaction.reaction', existingReaction.id, {
            data: {
              active: !existingReaction.active,
              timestamp: now,
            },
          });
        } else {
          // Si cambia de like a dislike o viceversa, actualiza el tipo y activa
          await strapi.entityService.update('api::reaction.reaction', existingReaction.id, {
            data: {
              type,
              active: true,
              timestamp: now,
            },
          });
        }

        const updatedReaction = await strapi.entityService.findOne('api::reaction.reaction', existingReaction.id, {
          populate: ['product', 'users_permissions_user'],
        });

        return updatedReaction;
      } else {
        // Si no existe, crea una nueva reacción
        const newReaction = await strapi.entityService.create('api::reaction.reaction', {
          data: {
            type,
            active: true,
            product: productId,
            users_permissions_user: userId,
            timestamp: now,
            publishedAt: now,
          },
        });

        return await strapi.entityService.findOne('api::reaction.reaction', newReaction.id, {
          populate: ['product', 'users_permissions_user'],
        });
      }
    } catch (error) {
      ctx.body = error;
      return ctx.badRequest(`Error al procesar la reacción: ${error.message}`);
    }
  },

  // Método para obtener las estadísticas de reacciones de un producto
  async getProductReactionsStats(ctx: Context) {
    try {
      const { productId } = ctx.params;

      if (!productId) {
        return ctx.badRequest('Se requiere ID de producto');
      }

      // Contar likes activos
      const likesCount = await strapi.db.query('api::reaction.reaction').count({
        where: {
          product: productId,
          type: 'like',
          active: true,
        },
      });

      // Contar dislikes activos
      const dislikesCount = await strapi.db.query('api::reaction.reaction').count({
        where: {
          product: productId,
          type: 'dislike',
          active: true,
        },
      });

      // Si el usuario está autenticado, obtener su reacción
      let userReaction = null;
      if (ctx.state.user) {
        userReaction = await strapi.db.query('api::reaction.reaction').findOne({
          where: {
            product: productId,
            users_permissions_user: ctx.state.user.id,
          },
        });
      }

      return {
        likes: likesCount,
        dislikes: dislikesCount,
        userReaction: userReaction ? {
          type: userReaction.type,
          active: userReaction.active,
        } : null,
      };
    } catch (error) {
      return ctx.badRequest(`Error al obtener estadísticas: ${error.message}`);
    }
  },
}));
