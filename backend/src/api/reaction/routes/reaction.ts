/**
 * Router estándar para reacciones
 */

import { factories } from '@strapi/strapi';

export default factories.createCoreRouter('api::reaction.reaction', {
  prefix: '',
  only: ['find', 'findOne', 'create', 'update', 'delete'],
  except: [],
  config: {
    find: {},
    findOne: {},
    create: {},
    update: {},
    delete: {},
  },
});
