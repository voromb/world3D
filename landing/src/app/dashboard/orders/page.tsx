'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import Link from 'next/link';
import Image from 'next/image';
import { Button } from '@/components/ui/button';
import { 
  Package, 
  ShoppingBag, 
  Truck, 
  CheckCircle, 
  ArrowLeft,
  ShoppingCart,
  Calendar,
  User,
  CreditCard
} from 'lucide-react';
import { toast } from 'react-hot-toast';
import { Order, OrderItem, orderService } from '@/lib/services/order-service';

export default function OrdersPage() {
  const { data: session, status } = useSession();
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Función para cargar pedidos usando nuestra API personalizada
    const loadOrders = async () => {
      try {
        setLoading(true);
        
        if (status !== 'authenticated' || !session?.user?.id) {
          console.log('Usuario no autenticado o sin ID');
          setLoading(false);
          return;
        }
        
        console.log('Cargando pedidos para el usuario...');
        
        // Usar nuestra API personalizada en lugar del servicio directo
        const response = await fetch('/api/orders', {
          headers: {
            'x-user-id': session.user.id,
          }
        });
        const data = await response.json();
        
        console.log('Respuesta de API:', data);
        
        if (data?.data && data.data.length > 0) {
          // Transformar los datos al formato que espera nuestro componente
          const transformedOrders = data.data.map((order: any) => {
            // Obtener los items del pedido
            const items = order.attributes?.items?.data?.map((item: any) => {
              return {
                id: item.id,
                productName: item.attributes.productName,
                price: item.attributes.price,
                quantity: item.attributes.quantity,
                slug: item.attributes.slug,
                imageUrl: item.attributes.imageUrl || '/placeholder.svg'
              };
            }) || [];
            
            return {
              id: order.id,
              orderNumber: order.attributes.orderNumber || `ORD-${order.id}`,
              date: new Date(order.attributes.createdAt).toLocaleDateString('es-ES'),
              status: order.attributes.status || 'pendiente',
              total: order.attributes.total || 0,
              items: items,
              shippingAddress: {
                name: order.attributes.shippingName || session?.user?.name || 'Usuario',
                address: order.attributes.shippingAddress || 'Dirección no especificada',
                city: order.attributes.shippingCity || 'Ciudad no especificada',
                postalCode: order.attributes.shippingPostalCode || ''
              },
              paymentMethod: order.attributes.paymentMethod || 'Tarjeta de crédito'
            };
          });
          
          console.log('Pedidos transformados:', transformedOrders);
          setOrders(transformedOrders);
          
          // Mostrar notificación solo para pedidos reales (no simulados)
          if (transformedOrders.length > 0 && !(String(transformedOrders[0].id).includes('mock'))) {
            toast.success(`Se han encontrado ${transformedOrders.length} pedidos reales`);
          }
        } else {
          // Como último recurso, usar el servicio antiguo
          console.log('No se encontraron pedidos en la API, usando método de respaldo');
          const userOrders = await orderService.getUserOrders();
          console.log('Pedidos cargados con método de respaldo:', userOrders.length);
          setOrders(userOrders);
        }
      } catch (error) {
        console.error('Error al cargar pedidos:', error);
        
        // Intentar método de respaldo
        try {
          console.log('Error al usar API, intentando método de respaldo...');
          const userOrders = await orderService.getUserOrders();
          setOrders(userOrders);
        } catch (backupError) {
          console.error('Error en método de respaldo:', backupError);
          toast.error('No se pudieron cargar los pedidos');
        }
      } finally {
        setLoading(false);
      }
    };
    
    // Solo intentamos cargar pedidos si el usuario está autenticado
    if (status === 'authenticated') {
      loadOrders();
    } else if (status === 'unauthenticated') {
      // Si no está autenticado, dejamos de cargar
      setLoading(false);
    }
    // No hacemos nada si status es 'loading', esperamos a que cambie
  }, [status, session]);

  // Formatear precio en euros
  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-ES', {
      style: 'currency',
      currency: 'EUR'
    }).format(price);
  };

  if (status === 'loading' || loading) {
    return (
      <div className="container mx-auto px-4 py-16">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-lg text-gray-600">Cargando tus pedidos...</p>
        </div>
      </div>
    );
  }

  if (status === 'unauthenticated') {
    return (
      <div className="container mx-auto px-4 py-16">
        <div className="max-w-3xl mx-auto text-center bg-white rounded-lg shadow-md p-8">
          <User className="h-16 w-16 text-gray-400 mx-auto mb-4" />
          <h1 className="text-2xl font-bold mb-4">Inicia sesión para ver tus pedidos</h1>
          <p className="mb-6 text-gray-600">Necesitas iniciar sesión para acceder a tu historial de pedidos.</p>
          <Link href="/auth/login">
            <Button>Iniciar sesión</Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="max-w-5xl mx-auto">
        <div className="flex items-center justify-between mb-8">
          <h1 className="text-3xl font-bold">Mis pedidos</h1>
          <Link href="/dashboard">
            <Button variant="outline" className="flex items-center gap-2">
              <ArrowLeft className="h-4 w-4" />
              Volver al panel
            </Button>
          </Link>
        </div>

        {orders.length === 0 ? (
          <div className="bg-white rounded-lg shadow-md p-8 text-center">
            <ShoppingBag className="h-16 w-16 text-gray-400 mx-auto mb-4" />
            <h2 className="text-2xl font-semibold mb-2">No tienes pedidos todavía</h2>
            <p className="text-gray-600 mb-6">Parece que aún no has realizado ninguna compra.</p>
            <Link href="/shop">
              <Button className="flex items-center gap-2">
                <ShoppingCart className="h-4 w-4" />
                Explorar productos
              </Button>
            </Link>
          </div>
        ) : (
          <div className="space-y-6">
            {orders.map((order) => (
              <div key={order.id} className="bg-white rounded-lg shadow-md overflow-hidden">
                <div className="p-6 border-b">
                  <div className="flex flex-wrap items-center justify-between gap-4">
                    <div>
                      <p className="text-lg font-semibold">
                        Pedido {order.orderNumber || `#${order.id.slice(0, 8)}`}
                      </p>
                      <div className="flex items-center gap-2 mt-1">
                        <Calendar className="h-4 w-4 text-gray-500" />
                        <p className="text-sm">{order.date}</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div>
                        {order.status === 'pendiente' && (
                          <span className="inline-flex items-center px-3 py-1 text-sm font-medium rounded-full bg-blue-100 text-blue-800">
                            <Package className="h-4 w-4 mr-1" />
                            Pendiente
                          </span>
                        )}
                        {order.status === 'enviado' && (
                          <span className="inline-flex items-center px-3 py-1 text-sm font-medium rounded-full bg-orange-100 text-orange-800">
                            <Truck className="h-4 w-4 mr-1" />
                            Enviado
                          </span>
                        )}
                        {order.status === 'entregado' && (
                          <span className="inline-flex items-center px-3 py-1 text-sm font-medium rounded-full bg-green-100 text-green-800">
                            <CheckCircle className="h-4 w-4 mr-1" />
                            Entregado
                          </span>
                        )}
                      </div>
                      <p className="font-semibold">{formatPrice(order.total)}</p>
                    </div>
                  </div>
                </div>

                <div className="p-6">
                  <h3 className="font-semibold mb-4">Productos</h3>
                  <div className="space-y-4">
                    {order.items && order.items.map((item) => (
                      <div key={item.id} className="flex items-center space-x-3">
                        <div className="relative w-16 h-16 overflow-hidden rounded-md shadow-sm bg-gray-50">
                          <Image 
                            src={item.imageUrl || '/placeholder.svg'}
                            alt={item.productName}
                            fill
                            className="object-cover"
                            onError={(e) => {
                              // Si falla la carga, usar imagen de respaldo
                              (e.target as HTMLImageElement).src = '/placeholder.svg';
                            }}
                          />
                        </div>
                        
                        <div className="flex-1">
                          <p className="font-medium text-base">{item.productName}</p>
                          <div className="flex flex-wrap items-center mt-1 gap-2">
                            <span className="text-sm font-semibold text-blue-600">
                              {formatPrice(item.price)}
                            </span>
                            <span className="text-xs px-2 py-0.5 bg-gray-100 rounded-full">
                              {item.quantity} {item.quantity > 1 ? 'unidades' : 'unidad'}
                            </span>
                            {item.slug && (
                              <Link href={`/shop/${item.slug}`} className="text-xs text-blue-500 hover:underline">Ver producto</Link>
                            )}
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="font-semibold">{formatPrice(item.price * item.quantity)}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                  
                  <div className="mt-6 pt-6 border-t">
                    <div className="flex items-center justify-between mb-2">
                      <p className="text-gray-600">Subtotal</p>
                      <p>{formatPrice(order.total)}</p>
                    </div>
                    <div className="flex items-center justify-between mb-2">
                      <p className="text-gray-600">Envío</p>
                      <p>Gratis</p>
                    </div>
                    <div className="flex items-center justify-between font-semibold text-lg">
                      <p>Total</p>
                      <p>{formatPrice(order.total)}</p>
                    </div>
                  </div>
                  
                  <div className="mt-6 pt-6 border-t">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                      <div>
                        <h4 className="font-medium mb-2">Dirección de envío</h4>
                        <p className="text-sm">{order.shippingAddress.name}</p>
                        <p className="text-sm">{order.shippingAddress.address}</p>
                        <p className="text-sm">{order.shippingAddress.city}, {order.shippingAddress.postalCode}</p>
                      </div>
                      <div>
                        <h4 className="font-medium mb-2">Método de pago</h4>
                        <div className="flex items-center">
                          <CreditCard className="h-5 w-5 text-gray-500 mr-2" />
                          <p className="text-sm">{order.paymentMethod}</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
