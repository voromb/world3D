'use client';

import React, { useState, useEffect } from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { HeroImageType } from '@/types';

interface HeroCarouselProps {
  images: HeroImageType[];
}

const HeroCarousel: React.FC<HeroCarouselProps> = ({ images }) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  
  // Cambiar imagen cada 5 segundos
  useEffect(() => {
    if (images.length <= 1) return;
    
    const interval = setInterval(() => {
      setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
    }, 5000);
    
    return () => clearInterval(interval);
  }, [images.length]);

  if (!images || images.length === 0) {
    return (
      <div className="relative w-full h-[500px] bg-gray-100 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-3xl font-bold text-gray-800">Sin imágenes disponibles</h1>
        </div>
      </div>
    );
  }

  const handlePrev = () => {
    setCurrentIndex((prevIndex) => (prevIndex - 1 + images.length) % images.length);
  };

  const handleNext = () => {
    setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
  };

  const currentImage = images[currentIndex];

  return (
    <div className="relative w-full h-[500px] bg-gray-100">
      {/* Imagen de fondo */}
      <div className="absolute inset-0 w-full h-full">
        <Image
  src={currentImage.url ?? "/placeholder.jpg"}
  alt={currentImage.imageGeneralName ?? "Imagen de impresora 3D"}
  fill
  className="object-cover"
  priority
/>
      </div>
      
      {/* Contenido superpuesto */}
      <div className="absolute inset-0 flex flex-col justify-center px-8 md:px-16 z-10 bg-black bg-opacity-30">
        <div className="max-w-3xl">
          <h1 className="text-3xl md:text-5xl font-bold text-white mb-4">
            {currentImage.text_general?.title ?? 'Encuentra tu impresora 3D ideal'}
          </h1>
          <p className="text-lg md:text-xl text-white mb-8">
            {currentImage.text_general?.subtitle ?? 'Explora nuestra selección de impresoras 3D de segunda mano'}
          </p>
          <div className="flex flex-wrap gap-4">
            {currentImage.links && currentImage.links.length > 0 ? (
  currentImage.links.map((link, idx) => (
    <Link
      key={idx}
      href={link.url ?? "#"}
      className="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg transition-colors"
    >
      {link.text ?? "Ver más"}
    </Link>
              ))
            ) : (
              <Link 
                href="/shop" 
                className="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg transition-colors"
              >
                Explorar productos
              </Link>
            )}
          </div>
        </div>
      </div>

      {/* Controles de navegación */}
      {images.length > 1 && (
        <>
          <button 
            onClick={handlePrev}
            className="absolute top-1/2 left-4 transform -translate-y-1/2 bg-white/30 hover:bg-white/50 rounded-full p-2 z-20"
            aria-label="Previous slide"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="15 18 9 12 15 6"></polyline>
            </svg>
          </button>
          <button 
            onClick={handleNext}
            className="absolute top-1/2 right-4 transform -translate-y-1/2 bg-white/30 hover:bg-white/50 rounded-full p-2 z-20"
            aria-label="Next slide"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="9 18 15 12 9 6"></polyline>
            </svg>
          </button>

          {/* Indicadores */}
          <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2 z-20">
            {images.map((_, idx) => (
              <button
                key={idx}
                className={`w-3 h-3 rounded-full ${
                  idx === currentIndex ? 'bg-white' : 'bg-white/50'
                }`}
                onClick={() => setCurrentIndex(idx)}
                aria-label={`Go to slide ${idx + 1}`}
              />
            ))}
          </div>
        </>
      )}
    </div>
  );
};

export default HeroCarousel;