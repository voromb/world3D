/**
 * Rutas personalizadas para la API de reacciones
 */

export default {
  routes: [
    {
      method: 'POST',
      path: '/toggle',
      handler: 'reaction.toggleReaction',
      config: {
        policies: [],
        middlewares: [],
        auth: {
          scope: ['api::reaction.reaction.toggleReaction'],
        },
      },
    },
    {
      method: 'GET',
      path: '/stats/:productId',
      handler: 'reaction.getProductReactionsStats',
      config: {
        policies: [],
        middlewares: [],
        auth: {
          scope: ['api::reaction.reaction.getProductReactionsStats'],
          required: false, // No requiere autenticación
        },
      },
    },
  ],
};
