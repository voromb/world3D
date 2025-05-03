import { getSession } from 'next-auth/react';
import { CartItem } from '@/lib/store/cart-store';

// URL base para la API
const API_URL = process.env.NEXT_PUBLIC_STRAPI_API_URL || 'http://localhost:1337';

// Clase para gestionar el carrito con Strapi
export class CartService {
  private static instance: CartService;
  
  // Método para obtener una instancia única (patrón Singleton)
  public static getInstance(): CartService {
    if (!CartService.instance) {
      CartService.instance = new CartService();
    }
    return CartService.instance;
  }

  // Obtener o crear un carrito para el usuario actual
  async getOrCreateCart(): Promise<number | null> {
    try {
      const session = await getSession();
      const userId = session?.user?.id;
      
      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Buscar carrito existente para el usuario
      let response;
      let existingCartId = null;
      
      if (userId) {
        // Usuario autenticado - buscar por userId
        response = await fetch(
          `${API_URL}/api/carts?filters[users_permissions_user][id][$eq]=${userId}`,
          requestOptions
        );
        
        const userData = await response.json();
        if (userData.data && userData.data.length > 0) {
          existingCartId = userData.data[0].id;
        }
      } else {
        // Usuario anónimo - solo usar en el navegador
        if (typeof window !== 'undefined') {
          const anonymousCartId = localStorage.getItem('anonymousCartId');
          if (anonymousCartId) {
            try {
              response = await fetch(
                `${API_URL}/api/carts/${anonymousCartId}`,
                requestOptions
              );
              const anonData = await response.json();
              if (anonData.data && anonData.data.id) {
                existingCartId = anonData.data.id;
              }
            } catch (e) {
              console.error('Error al recuperar carrito anónimo:', e);
            }
          }
        }
      }

      // Si ya existe un carrito, devolverlo
      if (existingCartId) {
        return existingCartId;
      }
      
      // Si no existe, crear uno nuevo
      return this.createNewCart(userId);
    } catch (error) {
      console.error('Error al obtener el carrito:', error);
      return null;
    }
  }

  // Crear un nuevo carrito
  private async createNewCart(userId?: string): Promise<number | null> {
    try {
      const session = await getSession();

      // Datos para crear el carrito
      const cartData = {
        data: {
          users_permissions_user: userId || null,
          status: 'active'
        }
      };

      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(cartData),
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Crear el carrito
      const response = await fetch(`${API_URL}/api/carts`, requestOptions);
      const data = await response.json();

      // Si es un carrito anónimo, guardar el ID en localStorage (solo en navegador)
      if (!userId && typeof window !== 'undefined' && data?.data?.id) {
        localStorage.setItem('anonymousCartId', data.data.id);
      }

      return data?.data?.id || null;
    } catch (error) {
      console.error('Error al crear el carrito:', error);
      return null;
    }
  }

  // Obtener items del carrito
  async getCartItems(cartId: number): Promise<CartItem[]> {
    try {
      const session = await getSession();

      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Obtener items del carrito
      const response = await fetch(
        `${API_URL}/api/cart-items?filters[carts][id][$eq]=${cartId}&populate=products`,
        requestOptions
      );
      
      const data = await response.json();
      
      // Transformar los datos de Strapi al formato que usa nuestro store
      if (data.data && data.data.length > 0) {
        return data.data.map((item: any) => {
          const product = item.attributes.products.data;
          let imageUrl = undefined;
          
          if (product.attributes.images && 
              product.attributes.images.data && 
              product.attributes.images.data.length > 0) {
            imageUrl = product.attributes.images.data[0].attributes.url;
          }
            
          return {
            documentId: String(item.id),
            productName: product.attributes.title,
            price: item.attributes.price,
            quantity: item.attributes.countProduct,
            slug: product.attributes.slug,
            imageUrl: imageUrl ? `${API_URL}${imageUrl}` : undefined
          };
        });
      }
      
      return [];
    } catch (error) {
      console.error('Error al obtener items del carrito:', error);
      return [];
    }
  }

  // Añadir un item al carrito
  async addItem(cartId: number, product: any, quantity: number): Promise<boolean> {
    try {
      const session = await getSession();

      // Comprobar si el producto ya está en el carrito
      const items = await this.getCartItems(cartId);
      const existingItem = items.find(item => Number(item.documentId) === product.id);

      if (existingItem) {
        // Actualizar la cantidad
        return this.updateItemQuantity(
          Number(existingItem.documentId), 
          existingItem.quantity + quantity
        );
      }

      // Datos para crear el item
      const itemData = {
        data: {
          carts: cartId,
          products: product.id,
          countProduct: quantity,
          price: product.attributes.price,
          addedAt: new Date().toISOString()
        }
      };

      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(itemData),
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Crear el item
      const response = await fetch(`${API_URL}/api/cart-items`, requestOptions);
      const data = await response.json();

      return !!data.data;
    } catch (error) {
      console.error('Error al añadir item al carrito:', error);
      return false;
    }
  }

  // Eliminar un item del carrito
  async removeItem(itemId: number): Promise<boolean> {
    try {
      const session = await getSession();

      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Eliminar el item
      const response = await fetch(`${API_URL}/api/cart-items/${itemId}`, requestOptions);
      const data = await response.json();

      return !!data.data;
    } catch (error) {
      console.error('Error al eliminar item del carrito:', error);
      return false;
    }
  }

  // Actualizar la cantidad de un item
  async updateItemQuantity(itemId: number, quantity: number): Promise<boolean> {
    try {
      // Si la cantidad es 0 o menor, eliminar el item
      if (quantity <= 0) {
        return this.removeItem(itemId);
      }

      const session = await getSession();

      // Datos para actualizar el item
      const itemData = {
        data: {
          countProduct: quantity
        }
      };

      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(itemData),
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Actualizar el item
      const response = await fetch(`${API_URL}/api/cart-items/${itemId}`, requestOptions);
      const data = await response.json();

      return !!data.data;
    } catch (error) {
      console.error('Error al actualizar cantidad del item:', error);
      return false;
    }
  }

  // Vaciar el carrito
  async clearCart(cartId: number): Promise<boolean> {
    try {
      const items = await this.getCartItems(cartId);
      
      // Eliminar todos los items
      const promises = items.map(item => this.removeItem(Number(item.documentId)));
      await Promise.all(promises);
      
      return true;
    } catch (error) {
      console.error('Error al vaciar el carrito:', error);
      return false;
    }
  }
}

export const cartService = CartService.getInstance();
