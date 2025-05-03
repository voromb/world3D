'use client';

import { useEffect, useState } from 'react';
import { useCartStore, CartItem } from '@/lib/store/cart-store';
import { Button } from '@/components/ui/button';
import { paymentService } from '@/lib/services/payment-service';
import { ShoppingCart, Trash2, Plus, Minus, ArrowLeft, CreditCard } from 'lucide-react';
import Link from 'next/link';
import Image from 'next/image';
import { useSession } from 'next-auth/react';
import { toast } from 'react-hot-toast';
import { getStripe } from '@/lib/stripe/stripe-client';

export default function CartPage() {
  const { items, totalItems, totalPrice, removeItem, updateQuantity, clearCart } = useCartStore();
  const [mounted, setMounted] = useState(false);

  // Para evitar errores de hidratación con Zustand y NextJS
  useEffect(() => {
    setMounted(true);
  }, []);

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-ES', {
      style: 'currency',
      currency: 'EUR'
    }).format(price);
  };

  // Para evitar errores de hidratación
  if (!mounted) {
    return (
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-8">Cargando carrito...</h1>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-3xl font-bold">Tu carrito</h1>
        <Link href="/productos" className="flex items-center gap-2 text-blue-600 hover:text-blue-800">
          <ArrowLeft className="h-4 w-4" />
          <span>Continuar comprando</span>
        </Link>
      </div>

      {items.length === 0 ? (
        <div className="text-center py-12 border rounded-lg bg-gray-50">
          <ShoppingCart className="h-16 w-16 text-gray-400 mx-auto mb-4" />
          <h2 className="text-2xl font-semibold mb-2">Tu carrito está vacío</h2>
          <p className="text-gray-600 mb-6">Parece que no has añadido ningún producto a tu carrito todavía.</p>
          <Link href="/productos">
            <Button className="mt-2">
              Ver productos
            </Button>
          </Link>
        </div>
      ) : (
        <div className="grid md:grid-cols-3 gap-8">
          <div className="md:col-span-2">
            <div className="border rounded-lg overflow-hidden">
              <table className="w-full">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Producto</th>
                    <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Cantidad</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Precio</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Acciones</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {items.map((item) => (
                    <tr key={item.documentId}>
                      <td className="px-6 py-4">
                        <div className="flex items-center">
                          <div className="h-20 w-20 flex-shrink-0 rounded-md overflow-hidden bg-gray-100 mr-4">
                            {item.imageUrl ? (
                              <Image
                                src={item.imageUrl}
                                alt={item.productName}
                                width={80}
                                height={80}
                                className="object-cover w-full h-full"
                              />
                            ) : (
                              <div className="w-full h-full flex items-center justify-center">
                                <ShoppingCart className="h-8 w-8 text-gray-400" />
                              </div>
                            )}
                          </div>
                          <div>
                            <Link 
                              href={`/productos/${item.slug}`} 
                              className="font-medium text-gray-900 hover:text-blue-600"
                            >
                              {item.productName}
                            </Link>
                            <p className="text-gray-500 text-sm mt-1">
                              {formatPrice(item.price)} por unidad
                            </p>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center justify-center gap-2">
                          <Button
                            variant="outline"
                            size="icon"
                            className="h-8 w-8"
                            onClick={() => updateQuantity(item.documentId, item.quantity - 1)}
                          >
                            <Minus className="h-3 w-3" />
                          </Button>
                          <span className="w-8 text-center">{item.quantity}</span>
                          <Button
                            variant="outline"
                            size="icon"
                            className="h-8 w-8"
                            onClick={() => updateQuantity(item.documentId, item.quantity + 1)}
                          >
                            <Plus className="h-3 w-3" />
                          </Button>
                        </div>
                      </td>
                      <td className="px-6 py-4 text-right font-medium">
                        {formatPrice(item.price * item.quantity)}
                      </td>
                      <td className="px-6 py-4 text-right">
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-red-500 hover:text-red-700 hover:bg-red-50"
                          onClick={() => removeItem(item.documentId)}
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            <div className="mt-4 flex justify-end">
              <Button variant="outline" onClick={clearCart} className="text-red-500 hover:bg-red-50 hover:text-red-700">
                Vaciar carrito
              </Button>
            </div>
          </div>

          <div>
            <div className="border rounded-lg p-6 bg-gray-50 sticky top-4">
              <h2 className="text-lg font-semibold mb-4">Resumen del pedido</h2>
              
              <div className="space-y-2 border-b pb-4 mb-4">
                <div className="flex justify-between text-sm">
                  <span>Subtotal ({totalItems} productos)</span>
                  <span>{formatPrice(totalPrice)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span>Gastos de envío</span>
                  <span>Gratis</span>
                </div>
              </div>
              
              <div className="flex justify-between font-bold text-lg mb-6">
                <span>Total</span>
                <span>{formatPrice(totalPrice)}</span>
              </div>
              
              <Button
                className="w-full" 
                size="lg" 
                onClick={() => {
                  // Mostrar mensaje de procesamiento
                  toast.loading('Procesando pago...', { id: 'processing-payment' });
                  
                  // Definimos una función asíncrona interna
                  const processPayment = async () => {
                    try {
                      // Crear sesión de checkout con Stripe
                      const checkoutUrl = await paymentService.createCheckoutSession(items);
                      
                      if (checkoutUrl) {
                        toast.success('Redirigiendo a la página de pago...', { id: 'processing-payment' });
                        // Redirigir a la página de checkout de Stripe
                        window.location.href = checkoutUrl;
                      } else {
                        toast.error('No se pudo crear la sesión de pago', { id: 'processing-payment' });
                      }
                    } catch (err) {
                      console.error('Error al procesar el pago:', err);
                      toast.error('Error al procesar el pago', { id: 'processing-payment' });
                    }
                  };
                  
                  // Ejecutamos la función asíncrona
                  processPayment();
                }}
              >
                <CreditCard className="mr-2 h-5 w-5" />
                Finalizar compra
              </Button>
              
              <p className="text-xs text-gray-500 mt-4 text-center">
                Los impuestos están incluidos en el precio
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
