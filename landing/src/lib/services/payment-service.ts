import { getSession } from 'next-auth/react';
import { cartService } from './cart-service';
import { toast } from 'react-hot-toast';

// URL base para la API
const API_URL = process.env.NEXT_PUBLIC_STRAPI_API_URL || 'http://localhost:1337';

// Interfaz para el item de pago
export interface PaymentItem {
  productName: string;
  price: number;
  quantity: number;
  slug: string;
  documentId: string;
  imageUrl?: string;
}

// Clase para gestionar los pagos con Stripe
export class PaymentService {
  private static instance: PaymentService;
  
  // Patrón Singleton
  public static getInstance(): PaymentService {
    if (!PaymentService.instance) {
      PaymentService.instance = new PaymentService();
    }
    return PaymentService.instance;
  }

  // Simular una sesión de checkout con Stripe y crear pedido real
  async createCheckoutSession(items: PaymentItem[]): Promise<string | null> {
    try {
      // Comprobamos si hay items en el carrito
      if (!items || items.length === 0) {
        toast.error('No hay productos en el carrito');
        return null;
      }

      // Calculamos el total del pedido
      const total = items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
      console.log('Procesando pago por un total de:', total);
      
      const cartId = await cartService.getOrCreateCart();
      if (!cartId) {
        toast.error('Error al obtener el carrito');
        return null;
      }
      
      // Crear un ID de pedido único
      const orderId = 'ORD-' + Math.floor(1000 + Math.random() * 9000);
      const session = await getSession();
      const userId = session?.user?.id;
      
      // Crear el pedido en la base de datos de Strapi
      const orderData = {
        data: {
          orderNumber: orderId,
          status: 'pendiente',
          total: total,
          shippingName: session?.user?.name || 'Cliente',
          shippingAddress: 'Dirección de envío predeterminada',
          shippingCity: 'Madrid',
          shippingPostalCode: '28001',
          paymentMethod: 'Tarjeta de crédito',
          users_permissions_user: userId || null,
          // Fecha actual en formato ISO
          createdAt: new Date().toISOString()
        }
      };
      
      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(orderData),
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Crear el pedido
      try {
        const response = await fetch(`${API_URL}/api/orders`, requestOptions);
        const data = await response.json();
        console.log('Pedido creado:', data);
        
        if (data.data?.id) {
          // Crear items del pedido (para cada producto en el carrito)
          for (const item of items) {
            const orderItemData = {
              data: {
                productName: item.productName,
                price: item.price,
                quantity: item.quantity,
                slug: item.slug,
                imageUrl: item.imageUrl,
                order: data.data.id  // Relación con el pedido
              }
            };
            
            const itemRequestOptions: RequestInit = {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                ...(session?.jwt ? { Authorization: `Bearer ${session.jwt}` } : {})
              },
              body: JSON.stringify(orderItemData),
            };
            
            // Crear el item del pedido
            await fetch(`${API_URL}/api/order-items`, itemRequestOptions);
          }
        }
      } catch (err) {
        console.error('Error al crear el pedido en la base de datos:', err);
        // Continuamos con el proceso aunque falle la creación en DB
      }
      
      // Vaciar el carrito después de crear el pedido
      setTimeout(async () => {
        try {
          await cartService.clearCart(cartId);
          console.log('Carrito vaciado después del pago');
        } catch (err) {
          console.error('Error al vaciar el carrito:', err);
        }
      }, 2000); // Pequeño retraso para el procesamiento
      
      // Redirección a página de éxito con ID del pedido
      return `/checkout/success?session_id=${orderId}`;
    } catch (error) {
      console.error('Error al crear sesión de checkout:', error);
      toast.error('Error al procesar el pago. Inténtalo de nuevo.');
      return null;
    }
  }

  // Procesar un pago exitoso
  async processSuccessfulPayment(sessionId: string): Promise<boolean> {
    try {
      const session = await getSession();
      const cartId = await cartService.getOrCreateCart();
      
      if (!cartId) {
        console.error('No se pudo obtener el ID del carrito');
        return false;
      }

      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          stripeSessionId: sessionId,
          cartId: cartId,
          userId: session?.user?.id || null
        }),
      };

      // Añadir token de autenticación si el usuario está autenticado
      if (session?.jwt) {
        requestOptions.headers = {
          ...requestOptions.headers,
          Authorization: `Bearer ${session.jwt}`,
        };
      }

      // Procesar el pago exitoso
      const response = await fetch(`${API_URL}/api/orders/create-from-payment`, requestOptions);
      
      if (!response.ok) {
        const errorData = await response.json();
        console.error('Error al procesar pago exitoso:', errorData);
        throw new Error(errorData.error?.message || 'Error al procesar el pago');
      }
      
      // Limpiar el carrito después de un pago exitoso
      await cartService.clearCart(cartId);
      
      return true;
    } catch (error) {
      console.error('Error al procesar pago exitoso:', error);
      return false;
    }
  }
}

export const paymentService = PaymentService.getInstance();
