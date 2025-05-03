'use client';

import { useState } from 'react';
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
  SheetDescription,
  SheetFooter,
} from '@/components/ui/sheet';
import { Button } from '@/components/ui/button';
import { useCartStore } from '@/lib/store/cart-store';
import { paymentService } from '@/lib/services/payment-service';
import { toast } from 'react-hot-toast';
import { ShoppingCart, X, Minus, Plus, Trash2, CreditCard } from 'lucide-react';
import Image from 'next/image';
import Link from 'next/link';

export function CartDrawer() {
  const { items, totalItems, totalPrice, removeItem, updateQuantity, clearCart } = useCartStore();
  const [isOpen, setIsOpen] = useState(false);

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-ES', {
      style: 'currency',
      currency: 'EUR'
    }).format(price);
  };

  return (
    <Sheet open={isOpen} onOpenChange={setIsOpen}>
      <SheetTrigger asChild>
        <Button variant="outline" size="icon" className="relative">
          <ShoppingCart className="h-5 w-5" />
          {totalItems > 0 && (
            <span className="absolute -top-2 -right-2 bg-red-500 text-white rounded-full h-5 w-5 flex items-center justify-center text-xs">
              {totalItems}
            </span>
          )}
        </Button>
      </SheetTrigger>
      <SheetContent className="w-full sm:max-w-md flex flex-col bg-white border-l border-gray-200">
        <SheetHeader>
          <SheetTitle className="flex items-center gap-2">
            <ShoppingCart className="h-5 w-5" />
            Carrito de compra
            <span className="text-muted-foreground text-sm ml-auto">
              {totalItems} {totalItems === 1 ? 'artículo' : 'artículos'}
            </span>
          </SheetTitle>
        </SheetHeader>

        {items.length === 0 ? (
          <div className="flex-1 flex flex-col items-center justify-center text-center p-4">
            <ShoppingCart className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-medium">Tu carrito está vacío</h3>
            <p className="text-muted-foreground mt-1">
              Parece que no has añadido ningún producto a tu carrito todavía.
            </p>
            <Button 
              className="mt-6" 
              variant="outline"
              onClick={() => setIsOpen(false)}
            >
              Continuar comprando
            </Button>
          </div>
        ) : (
          <>
            <div className="flex-1 overflow-auto py-4">
              <ul className="space-y-4">
                {items.map((item) => (
                  <li key={item.documentId} className="border-b pb-4">
                    <div className="flex gap-4">
                      {item.imageUrl ? (
                        <div className="h-20 w-20 rounded-md overflow-hidden bg-secondary relative flex-shrink-0">
                          <Image
                            src={item.imageUrl}
                            alt={item.productName}
                            fill
                            className="object-cover"
                          />
                        </div>
                      ) : (
                        <div className="h-20 w-20 rounded-md overflow-hidden bg-secondary flex items-center justify-center flex-shrink-0">
                          <ShoppingCart className="h-8 w-8 text-muted-foreground" />
                        </div>
                      )}
                      <div className="flex-1">
                        <Link 
                          href={`/productos/${item.slug}`} 
                          className="font-medium hover:underline"
                          onClick={() => setIsOpen(false)}
                        >
                          {item.productName}
                        </Link>
                        <div className="text-muted-foreground text-sm">
                          {formatPrice(item.price)} por unidad
                        </div>
                        <div className="flex items-center gap-2 mt-2">
                          <Button
                            variant="outline"
                            size="icon"
                            className="h-7 w-7"
                            onClick={() => updateQuantity(item.documentId, item.quantity - 1)}
                          >
                            <Minus className="h-3 w-3" />
                          </Button>
                          <span className="w-6 text-center">{item.quantity}</span>
                          <Button
                            variant="outline"
                            size="icon"
                            className="h-7 w-7"
                            onClick={() => updateQuantity(item.documentId, item.quantity + 1)}
                          >
                            <Plus className="h-3 w-3" />
                          </Button>
                          <Button
                            variant="ghost"
                            size="icon"
                            className="h-7 w-7 ml-auto text-red-500"
                            onClick={() => removeItem(item.documentId)}
                          >
                            <Trash2 className="h-4 w-4" />
                          </Button>
                        </div>
                      </div>
                      <div className="text-right">
                        {formatPrice(item.price * item.quantity)}
                      </div>
                    </div>
                  </li>
                ))}
              </ul>
            </div>

            <div className="border-t pt-4 space-y-4">
              <div className="flex items-center justify-between font-medium">
                <span>Total</span>
                <span>{formatPrice(totalPrice)}</span>
              </div>

              <div className="grid grid-cols-2 gap-2">
                <Button variant="outline" onClick={clearCart}>
                  Vaciar carrito
                </Button>
                <Button 
                  onClick={() => {
                    // Mostrar mensaje de procesamiento
                    toast.loading('Procesando pago...', { id: 'drawer-payment' });
                    
                    // Definimos una función asíncrona interna
                    const processPayment = async () => {
                      try {
                        // Crear sesión de checkout con Stripe
                        const checkoutUrl = await paymentService.createCheckoutSession(items);
                        
                        if (checkoutUrl) {
                          toast.success('Redirigiendo a la página de pago...', { id: 'drawer-payment' });
                          // Redirigir a la página de checkout de Stripe
                          window.location.href = checkoutUrl;
                        } else {
                          toast.error('No se pudo crear la sesión de pago', { id: 'drawer-payment' });
                        }
                      } catch (err) {
                        console.error('Error al procesar el pago:', err);
                        toast.error('Error al procesar el pago', { id: 'drawer-payment' });
                      }
                    };
                    
                    // Ejecutamos la función asíncrona
                    processPayment();
                  }}
                >
                  <CreditCard className="mr-2 h-4 w-4" />
                  Finalizar compra
                </Button>
              </div>
            </div>
          </>
        )}
      </SheetContent>
    </Sheet>
  );
}
