'use client';

import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { useCartStore, CartItem } from '@/lib/store/cart-store';
import { ShoppingCart, Plus, Minus, Check } from 'lucide-react';

interface AddToCartButtonProps {
  product: {
    documentId: string;
    productName: string;
    price: number;
    slug: string;
    imageUrl?: string;
  };
  variant?: 'default' | 'outline' | 'secondary' | 'destructive' | 'ghost' | 'link';
  size?: 'default' | 'sm' | 'lg' | 'icon';
}

export function AddToCartButton({ product, variant = 'default', size = 'default' }: AddToCartButtonProps) {
  const { addItem } = useCartStore();
  const [quantity, setQuantity] = useState(1);
  const [added, setAdded] = useState(false);

  const handleAddToCart = () => {
    const cartItem: CartItem = {
      documentId: product.documentId,
      productName: product.productName,
      price: product.price,
      quantity: quantity,
      slug: product.slug,
      imageUrl: product.imageUrl
    };

    addItem(cartItem);
    
    // Mostrar confirmación visual
    setAdded(true);
    setTimeout(() => {
      setAdded(false);
    }, 2000);
  };

  return (
    <div className="flex flex-col gap-2">
      <div className="flex items-center gap-2 mb-2">
        <Button
          type="button"
          variant="outline"
          size="icon"
          onClick={() => setQuantity(prev => Math.max(1, prev - 1))}
          className="h-8 w-8"
        >
          <Minus className="h-4 w-4" />
        </Button>
        <span className="w-8 text-center">{quantity}</span>
        <Button
          type="button"
          variant="outline"
          size="icon"
          onClick={() => setQuantity(prev => prev + 1)}
          className="h-8 w-8"
        >
          <Plus className="h-4 w-4" />
        </Button>
      </div>
      
      <Button
        variant={variant}
        size={size}
        onClick={handleAddToCart}
        className="flex items-center gap-2"
        disabled={added}
      >
        {added ? (
          <>
            <Check className="h-4 w-4" />
            <span>Añadido</span>
          </>
        ) : (
          <>
            <ShoppingCart className="h-4 w-4" />
            <span>Añadir al carrito</span>
          </>
        )}
      </Button>
    </div>
  );
}
