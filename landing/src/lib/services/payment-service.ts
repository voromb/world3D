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
        console.log("Cart is empty, cannot create checkout");
        toast.error('No hay productos en el carrito');
        return null;
      }
      
      console.log("Creating checkout session with items:", JSON.stringify(items, null, 2));

      // Calculamos el total del pedido
      const total = items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
      console.log('Procesando pago por un total de:', total);
      
      // Intentamos obtener el carrito, pero continuamos incluso si no existe
      const cartId = await cartService.getOrCreateCart();
      console.log('ID del carrito obtenido para el pago:', cartId || 'No disponible (continuando)');
      
      // IMPORTANTE: Continuamos con el proceso aunque no exista un carrito en la base de datos
      // El usuario todavía puede realizar un pedido sin un carrito guardado
      
      // Crear un ID de pedido único
      const orderId = 'ORD-' + Math.floor(1000 + Math.random() * 9000);
      const session = await getSession();
      const userId = session?.user?.id;
      
      console.log('Sesión para crear pedido:', session ? 'Disponible' : 'No disponible');
      console.log('JWT disponible:', session?.jwt ? 'Sí' : 'No');
      console.log('Usuario ID para pedido:', userId || 'No disponible');
      
      // Usar el modelo Cart existente en Strapi para guardar los pedidos
      // Estructura mejorada para depuración, testeo y mejor compatibilidad
      console.log('-------------- INICIANDO PROCESO DE GUARDADO DE PEDIDO --------------');
      console.log('Token API utilizado:', process.env.NEXT_PUBLIC_STRAPI_API_TOKEN?.substring(0, 10) + '...');
      
      const cartData = {
        data: {
          cartId: orderId, 
          price: total,
          quantity: items.reduce((sum, item) => sum + item.quantity, 0),
          time: new Date().toISOString(),
          createAt: 'Pedido completado', // Este es nuestro marcador para distinguir pedidos
          createBy: userId ? `Usuario ${userId}` : 'Invitado',
        }
      };
      
      // Sólo añadir la relación de usuario si realmente tenemos un ID
      if (userId) {
        console.log(`Añadiendo relación con usuario ID: ${userId}`);
        // @ts-ignore - Ignoramos error de tipado ya que sabemos que esto funciona con Strapi
        cartData.data.users_permissions_user = userId;
      }

      // Imprimir todos los campos que estamos enviando para depuración
      console.log('Cart Data simplificado:', JSON.stringify(cartData, null, 2));
      
      console.log('Datos del pedido (usando modelo Cart):', JSON.stringify(cartData, null, 2));
      
      // Opciones para la solicitud
      const requestOptions: RequestInit = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          // Usar siempre el token de API para poder guardar el carrito
          // sin importar si el usuario está autenticado o no
          'Authorization': `Bearer ${process.env.NEXT_PUBLIC_STRAPI_API_TOKEN}`
        },
        body: JSON.stringify(cartData),
      };

      console.log('Usando token de API para crear el carrito');
      
      // Nota: Ya no necesitamos el token JWT del usuario porque usamos
      // el token de API que es más confiable

      // Crear el pedido
      try {
        // Creamos un pedido dummy que podemos usar incluso si no hay autenticación
        let createdOrderId = `ORD-${Math.floor(Math.random() * 1000000)}`;
        let savedOrderData = null;

        // Intentar guardar en la base de datos usando el modelo Cart existente
        try {
          console.log('Enviando pedido a Strapi usando modelo Cart. URL:', `${API_URL}/api/carts`);
          console.log('Opciones de la solicitud:', JSON.stringify(requestOptions, (key, value) => 
            // No incluir el cuerpo completo en el log para evitar demasiada información
            key === 'body' ? '(contenido omitido)' : value
          ));

          const response = await fetch(`${API_URL}/api/carts`, requestOptions);
          console.log('Respuesta de Strapi - Status:', response.status, response.statusText);
          const data = await response.json();
          console.log('Respuesta completa de Strapi:', JSON.stringify(data, null, 2));
          
          // Mostrar mensaje específico si hay error de permisos
          if (response.status === 403) {
            console.error('ERROR DE PERMISOS: No hay permisos suficientes para crear carritos en Strapi.');
            console.error('Por favor, configura los permisos del modelo Cart y CartItem en el panel de administración de Strapi.');
            console.error('Instrucciones: Ve a Settings -> Users & Permissions Plugin -> Roles -> Public/Authenticated -> Cart -> Habilita find/create/update');
          }
          
          if (data.data?.id) {
            savedOrderData = data;
            createdOrderId = data.data.id;
            // Crear items del carrito para cada producto comprado
            for (const item of items) {
              // Crear item de carrito usando el formato correcto para relaciones
              const cartItemData = {
                data: {
                  // Conectar con el carrito principal usando formato relacional correcto
                  cart: {
                    connect: [data.data.id]
                  },
                  // Conectar con el producto usando formato relacional correcto
                  product: {
                    connect: [item.documentId]
                  },
                  // Campos básicos
                  quantity: item.quantity,
                  price: item.price
                }
              };
              
              console.log(`Datos del item ${item.productName}:`, JSON.stringify(cartItemData, null, 2));
              
              const itemRequestOptions: RequestInit = {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  // Usar el token de API para estar seguro
                  'Authorization': `Bearer ${process.env.NEXT_PUBLIC_STRAPI_API_TOKEN}`
                },
                body: JSON.stringify(cartItemData),
              };
              
              try {
                // Usar el endpoint correcto según Strapi v5
                console.log(`Creando item de carrito para producto: ${item.productName}`);
                console.log(`URL para crear item: ${API_URL}/api/cart-items`);
                
                const itemResponse = await fetch(`${API_URL}/api/cart-items`, itemRequestOptions);
                console.log(`Respuesta al crear item - Status: ${itemResponse.status}`);
                
                if (itemResponse.ok) {
                  const itemData = await itemResponse.json();
                  console.log('Item de carrito creado con éxito:', JSON.stringify(itemData, null, 2));
                } else {
                  const errorText = await itemResponse.text();
                  console.error(`Error al crear item (${itemResponse.status}):`, errorText);
                }
              } catch (itemError) {
                console.error('Error al crear item de carrito:', itemError);
                // Seguimos con el siguiente aunque haya error
              }
            }
          }
        } catch (err) {
          console.error('Error al crear el pedido en la base de datos:', err);
          // Continuamos con el proceso aunque falle la creación en BD
        }
        
        // Si no hay sesión, lo notificamos
        if (!session?.jwt) {
          console.log('Usuario no autenticado, generando pedido temporal');
        }
        
        // Vaciar el carrito después de crear el pedido si existe un carrito válido
        if (cartId) {
          setTimeout(async () => {
            try {
              await cartService.clearCart(cartId);
              console.log('Carrito vaciado después del pago');
            } catch (err) {
              console.error('Error al vaciar el carrito:', err);
            }
          }, 2000); // Pequeño retraso para el procesamiento
        } else {
          console.log('No hay carrito para vaciar');
        }
        
        // Redirección a página de éxito con ID del pedido
        return `/checkout/success?session_id=${createdOrderId}`;
      } catch (error) {
        console.error('Error al crear sesión de checkout:', error);
        toast.error('Error al procesar el pago. Inténtalo de nuevo.');
        return null;
      }
    } catch (error) {
      console.error('Error al crear sesión de checkout:', error);
      toast.error('Error al procesar el pago. Inténtalo de nuevo.');
      return null;
    }
  }

  // Procesar un pago exitoso
  async processSuccessfulPayment(sessionId: string): Promise<boolean> {
    try {
      // Verificar que el sessionId es válido
      if (!sessionId) {
        console.error('ID de sesión de pago no válido');
        return false;
      }
      
      console.log('Procesando pago exitoso para sesión:', sessionId);
      
      const session = await getSession();
      const userId = session?.user?.id || null;
      console.log('Usuario autenticado:', userId ? `ID: ${userId}` : 'No autenticado');
      
      // Intentar obtener el carrito, pero continuamos incluso si no existe
      const cartId = await cartService.getOrCreateCart();
      
      // Generar datos para la solicitud
      // Basado en los carritos existentes, solo usamos campos que Strapi acepta directamente
      const orderNumber = `ORD-${Math.floor(Math.random() * 10000)}`;
      const timestamp = new Date().toISOString();
      
      const paymentData: any = {
        data: {
          // Campos validados con los datos existentes en debug/carts
          createAt: 'Pedido completado',  // Este campo lo usamos para marcar pedidos completados
          cartId: orderNumber,            // ID visible del pedido
          time: timestamp,                // Timestamp del pedido 
          price: 0,                      // Se actualizará con los datos reales del carrito
          createBy: userId ? `Usuario ${userId}` : null, // Usuario que hizo el pedido
          quantity: 1                     // Campo requerido por el modelo
        }
      };
      
      // Guardamos el sessionId en un console.log para referencia
      console.log(`Creando pedido con referencia a session_id ${sessionId} con orderNumber ${orderNumber}`);
      
      // Si tenemos el ID del carrito, lo incluimos y vaciamos el carrito
      if (cartId) {
        console.log('Usando carrito existente:', cartId);
        paymentData.data.cartId = cartId;
        
        // Obtener los productos del carrito para incluir el precio
        try {
          const cartProducts = await cartService.getCartItems(cartId);
          if (cartProducts && cartProducts.length > 0) {
            paymentData.data.price = cartProducts.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            // Establecer la cantidad según los items
            paymentData.data.quantity = cartProducts.length;
          }
        } catch (error) {
          console.log('Error al obtener productos del carrito:', error);
          // Usamos un precio por defecto si no se puede calcular
          paymentData.data.price = 0;
        }
        
        // Limpiar el carrito después
        // Solo llamar a clearCart si cartId es un número (el método lo requiere)
        if (typeof cartId === 'number') {
          setTimeout(() => cartService.clearCart(cartId), 1000);
        } else {
          console.log('No se pudo limpiar el carrito porque cartId no es un número válido');
        }
      } else {
        console.log('No se pudo obtener el ID del carrito, continuando con proceso simplificado');
      }
      
      // Si el usuario está autenticado, establecemos la relación
      if (userId) {
        paymentData.data.users_permissions_user = userId;
      }
      
      // Opciones para la solicitud con token de API
      const requestOptions: RequestInit = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${process.env.NEXT_PUBLIC_STRAPI_API_TOKEN}`
        },
        body: JSON.stringify(paymentData),
      };

      console.log('Creando registro de pedido en la base de datos...');
      console.log('Enviando datos:', JSON.stringify(paymentData, null, 2));

      // Guardar el pedido en Strapi usando la API directa
      const response = await fetch(`${API_URL}/api/carts`, requestOptions);
      
      if (!response.ok) {
        const errorText = await response.text();
        console.error(`Error al guardar pedido (${response.status}):`, errorText);
        return false;
      } else {
        const data = await response.json();
        console.log('Pedido guardado exitosamente:', data);
        toast.success('¡Pedido completado correctamente!');
        return true;
      }
    } catch (error) {
      console.error('Error al procesar pago exitoso:', error);
      return false;
    }
  }
}

export const paymentService = PaymentService.getInstance();
