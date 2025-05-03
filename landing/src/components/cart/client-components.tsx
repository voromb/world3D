'use client';

import dynamic from 'next/dynamic';

// Importamos el inicializador del carrito de forma dinámica
const CartInitializer = dynamic(() => import('./cart-initializer'), { ssr: false });

// Este componente cliente actuará como wrapper
export function CartInitializerWrapper() {
  return <CartInitializer />;
}
