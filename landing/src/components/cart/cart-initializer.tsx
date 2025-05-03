'use client';

import { useEffect, useState } from 'react';
import { useCartStore } from '@/lib/store/cart-store';
import { cartService } from '@/lib/services/cart-service';

// Este componente se encarga de inicializar el carrito al cargar la aplicación
export default function CartInitializer() {
  const [isInitialized, setIsInitialized] = useState(false);
  
  useEffect(() => {
    const initializeCart = async () => {
      try {
        // Obtener o crear el carrito
        const cartId = await cartService.getOrCreateCart();
        
        if (cartId) {
          console.log('Carrito inicializado con ID:', cartId);
          
          // Obtener los elementos del carrito
          const items = await cartService.getCartItems(cartId);
          
          // Calcular totales
          const totalItems = items.reduce((sum, item) => sum + item.quantity, 0);
          const totalPrice = items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
          
          // Actualizar el store con los elementos del carrito
          useCartStore.setState({
            items,
            totalItems,
            totalPrice
          });
          
          console.log('Elementos del carrito cargados:', items);
        }
      } catch (error) {
        console.error('Error al inicializar el carrito:', error);
      } finally {
        setIsInitialized(true);
      }
    };
    
    initializeCart();
  }, []);
  
  // Este componente no renderiza nada visible
  return null;
}
