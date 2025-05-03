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
    // Función para cargar pedidos
    const loadOrders = async () => {
      if (status === 'authenticated') {
        try {
          const userOrders = await orderService.getUserOrders();
          setOrders(userOrders);
        } catch (error) {
          console.error('Error al cargar pedidos:', error);
          toast.error('No se pudieron cargar los pedidos');
        }
      }
      setLoading(false);
    };
    
    // Cargamos los pedidos después de un pequeño retraso para mostrar el estado de carga
    setTimeout(() => {
      loadOrders();
    }, 1000);
  }, [status]);

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
                      <div key={item.id} className="flex items-center gap-4">
                        <div className="h-16 w-16 bg-gray-100 rounded-md overflow-hidden relative flex-shrink-0">
                          {item.imageUrl ? (
                            <Image
                              src={item.imageUrl}
                              alt={item.productName}
                              fill
                              className="object-cover"
                            />
                          ) : (
                            <div className="flex items-center justify-center h-full w-full text-gray-400">
                              <Package className="h-8 w-8" />
                            </div>
                          )}
                        </div>
                        <div className="flex-grow">
                          <p className="font-medium">{item.productName}</p>
                          <div className="flex items-center text-sm text-gray-500">
                            <span>{formatPrice(item.price)} x {item.quantity}</span>
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
