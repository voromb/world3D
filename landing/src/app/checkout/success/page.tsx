'use client';

import { useEffect, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import { useCartStore } from '@/lib/store/cart-store';
import Link from 'next/link';
import { CheckCircle, ShoppingBag, ArrowLeft } from 'lucide-react';
import { Button } from '@/components/ui/button';

export default function CheckoutSuccessPage() {
  const searchParams = useSearchParams();
  const { clearCart } = useCartStore();
  const [orderDetails, setOrderDetails] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const sessionId = searchParams.get('session_id');

  useEffect(() => {
    // En producción, aquí deberías verificar el estado del pago con la API de Stripe
    if (sessionId) {
      // Simulamos la carga de detalles del pedido
      setTimeout(() => {
        setOrderDetails({
          id: `ORD-${Math.floor(Math.random() * 10000)}`,
          date: new Date().toLocaleDateString('es-ES'),
        });
        setLoading(false);
        
        // Limpiar el carrito después de una compra exitosa
        clearCart();
      }, 1500);
    } else {
      setLoading(false);
    }
  }, [sessionId, clearCart]);

  if (loading) {
    return (
      <div className="container max-w-4xl mx-auto py-16 px-4">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-lg text-gray-600">Procesando tu pedido...</p>
        </div>
      </div>
    );
  }

  if (!sessionId || !orderDetails) {
    return (
      <div className="container max-w-4xl mx-auto py-16 px-4">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-red-600 mb-4">Error en el proceso de pago</h1>
          <p className="mb-6">No hemos podido encontrar información sobre tu pedido. Es posible que haya ocurrido un error durante el proceso de pago.</p>
          <Link href="/cart">
            <Button>Volver al carrito</Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="container max-w-4xl mx-auto py-16 px-4">
      <div className="bg-white rounded-lg shadow-lg p-8 border border-gray-100">
        <div className="text-center mb-8">
          <CheckCircle className="w-16 h-16 text-green-500 mx-auto mb-4" />
          <h1 className="text-3xl font-bold text-gray-900 mb-2">¡Compra realizada con éxito!</h1>
          <p className="text-lg text-gray-600">
            Gracias por tu compra. Hemos recibido tu pedido y lo estamos procesando.
          </p>
        </div>

        <div className="border-t border-b border-gray-200 py-6 my-6">
          <h2 className="text-xl font-semibold mb-4">Detalles del pedido</h2>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <p className="text-gray-600">Número de pedido:</p>
              <p className="font-medium">{orderDetails.id}</p>
            </div>
            <div>
              <p className="text-gray-600">Fecha:</p>
              <p className="font-medium">{orderDetails.date}</p>
            </div>
          </div>
        </div>

        <div className="text-gray-600 mb-8">
          <p>Recibirás un correo electrónico con la confirmación de tu compra y los detalles de seguimiento cuando tu pedido sea enviado.</p>
        </div>

        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <Link href="/">
            <Button variant="outline" className="flex items-center gap-2">
              <ArrowLeft className="w-4 h-4" />
              Volver a la tienda
            </Button>
          </Link>
          <Link href="/dashboard">
            <Button className="flex items-center gap-2">
              <ShoppingBag className="w-4 h-4" />
              Ver mis pedidos
            </Button>
          </Link>
        </div>
      </div>
    </div>
  );
}
