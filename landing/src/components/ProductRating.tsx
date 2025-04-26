// src/components/ProductRating.tsx
'use client';

import { useState, useEffect } from 'react';
import { Star } from 'lucide-react';

interface ProductRatingProps {
  productSlug: string;
  initialRating?: number;
  initialTotalRatings?: number;
  initialViews?: number;
  onRatingSuccess?: (newRating: number, totalRatings: number) => void;
  onViewsUpdated?: (newViews: number) => void;
}

export default function ProductRating({
  productSlug,
  initialRating = 0,
  initialTotalRatings = 0,
  initialViews = 0,
  onRatingSuccess,
  onViewsUpdated
}: ProductRatingProps) {
  const [averageRating, setAverageRating] = useState(initialRating);
  const [totalRatings, setTotalRatings] = useState(initialTotalRatings);
  const [views, setViews] = useState(initialViews);
  const [userRating, setUserRating] = useState(0);
  const [hoverRating, setHoverRating] = useState(0);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [message, setMessage] = useState('');
  
  // Incrementar vistas al montar el componente
  useEffect(() => {
    const incrementViews = async () => {
      try {
        console.log(`Incrementando vistas para: ${productSlug}`);
        const response = await fetch(`/api/products-views/${productSlug}/increment`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          }
        });
        
        if (response.ok) {
          const data = await response.json();
          console.log('Vista registrada correctamente:', data);
          
          if (data.views && data.success) {
            setViews(data.views);
            if (onViewsUpdated) {
              onViewsUpdated(data.views);
            }
          }
        } else {
          console.log('No se pudo registrar la vista (puede ser por límite de frecuencia)');
        }
      } catch (error) {
        console.error('Error al incrementar vistas:', error);
      }
    };
    
    incrementViews();
  }, [productSlug, onViewsUpdated]);
  
  // Manejar envío de valoración
  const handleRatingSubmit = async (rating: number) => {
    if (isSubmitting) return;
    
    setIsSubmitting(true);
    setMessage('');
    
    try {
      console.log(`Enviando valoración de ${rating} para producto ${productSlug}`);
      const response = await fetch(`/api/product-ratings/${productSlug}/rate`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ rating })
      });
      
      const data = await response.json();
      
      if (response.ok) {
        setUserRating(rating);
        setAverageRating(data.averageRating);
        setTotalRatings(data.totalRatings);
        setMessage('¡Gracias por tu valoración!');
        
        if (onRatingSuccess) {
          onRatingSuccess(data.averageRating, data.totalRatings);
        }
      } else {
        setMessage(`Error: ${data.error || 'No se pudo enviar la valoración'}`);
      }
    } catch (error) {
      console.error('Error al enviar valoración:', error);
      setMessage('Error de conexión. Inténtalo de nuevo más tarde.');
    } finally {
      setIsSubmitting(false);
    }
  };
  
  return (
    <div className="product-rating">
      {/* Mostrar valoración promedio */}
      <div className="average-rating">
        <div className="flex items-center mb-2">
          <div className="mr-2 font-semibold">{averageRating.toFixed(1)}</div>
          <div className="flex">
            {[1, 2, 3, 4, 5].map((star) => (
              <Star
                key={`avg-${star}`}
                size={18}
                className={`${
                  star <= Math.round(averageRating)
                    ? 'text-yellow-400 fill-yellow-400'
                    : 'text-gray-300'
                }`}
              />
            ))}
          </div>
          <div className="ml-2 text-sm text-gray-500">
            ({totalRatings} {totalRatings === 1 ? 'valoración' : 'valoraciones'})
          </div>
        </div>
        <div className="text-sm text-gray-500">
          {views} {views === 1 ? 'vista' : 'vistas'}
        </div>
      </div>
      
      {/* Interfaz para valorar */}
      <div className="user-rating mt-4">
        <p className="text-sm mb-1">¿Qué te parece este producto?</p>
        <div className="flex items-center">
          {[1, 2, 3, 4, 5].map((star) => (
            <Star
              key={`input-${star}`}
              size={24}
              className={`cursor-pointer transition-colors ${
                star <= (hoverRating || userRating)
                  ? 'text-yellow-400 fill-yellow-400'
                  : 'text-gray-300'
              }`}
              onMouseEnter={() => setHoverRating(star)}
              onMouseLeave={() => setHoverRating(0)}
              onClick={() => handleRatingSubmit(star)}
            />
          ))}
          {isSubmitting && <span className="ml-2 text-sm">Enviando...</span>}
        </div>
        
        {message && (
          <p className={`text-sm mt-1 ${message.includes('Error') ? 'text-red-500' : 'text-green-500'}`}>
            {message}
          </p>
        )}
      </div>
    </div>
  );
}