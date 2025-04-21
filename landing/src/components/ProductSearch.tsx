'use client';

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { CategoryType } from '@/types';

interface ProductSearchProps {
  categories: CategoryType[];
  cities: string[];
  className?: string;
}

const ProductSearch: React.FC<ProductSearchProps> = ({ 
  categories, 
  cities,
  className = '' 
}) => {
  const router = useRouter();
  const [selectedCategory, setSelectedCategory] = useState<string>('');
  const [selectedCity, setSelectedCity] = useState<string>('');
  const [priceRange, setPriceRange] = useState<string>('');
  const [searchQuery, setSearchQuery] = useState<string>('');

  const handleSearch = () => {
    const queryParams = new URLSearchParams();
    
    if (selectedCategory) {
      queryParams.append('category', selectedCategory);
    }
    
    if (selectedCity) {
      queryParams.append('city', selectedCity);
    }
    
    if (priceRange) {
      queryParams.append('price', priceRange);
    }
    
    if (searchQuery) {
      queryParams.append('search', searchQuery);
    }
    
    router.push(`/shop?${queryParams.toString()}`);
  };

  // Manejar búsqueda con tecla Enter
  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      handleSearch();
    }
  };

  return (
    <div className={`w-full max-w-4xl mx-auto bg-white rounded-full shadow-lg p-2 ${className}`}>
      <div className="flex flex-col md:flex-row">
        {/* Campo de búsqueda */}
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3">
          <label className="block text-sm text-gray-500 mb-1">Buscar</label>
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="¿Qué impresora 3D buscas?"
            className="w-full bg-transparent text-gray-800 focus:outline-none"
          />
        </div>
        
        {/* Categoría */}
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3">
          <label className="block text-sm text-gray-500 mb-1">Categoría</label>
          <select
            value={selectedCategory}
            onChange={(e) => setSelectedCategory(e.target.value)}
            className="w-full bg-transparent text-gray-800 focus:outline-none"
          >
            <option value="">Todas las impresoras</option>
            {categories.map((category) => (
              <option key={category.id} value={category.slug}>
                {category.categoryName}
              </option>
            ))}
          </select>
        </div>
        
        {/* Ciudad */}
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3">
          <label className="block text-sm text-gray-500 mb-1">Ciudad</label>
          <select
            value={selectedCity}
            onChange={(e) => setSelectedCity(e.target.value)}
            className="w-full bg-transparent text-gray-800 focus:outline-none"
          >
            <option value="">Todas las ciudades</option>
            {cities.map((city, index) => (
              <option key={index} value={city}>
                {city}
              </option>
            ))}
          </select>
        </div>
        
        {/* Precio */}
        <div className="flex-1 p-3">
          <label className="block text-sm text-gray-500 mb-1">Precio</label>
          <select
            value={priceRange}
            onChange={(e) => setPriceRange(e.target.value)}
            className="w-full bg-transparent text-gray-800 focus:outline-none"
          >
            <option value="">Cualquier precio</option>
            <option value="0-500">0€ - 500€</option>
            <option value="500-1000">500€ - 1000€</option>
            <option value="1000-2000">1000€ - 2000€</option>
            <option value="2000-5000">2000€ - 5000€</option>
            <option value="5000+">5000€+</option>
          </select>
        </div>
        
        {/* Botón de búsqueda */}
        <div className="p-3">
          <button
            onClick={handleSearch}
            className="bg-blue-600 hover:bg-blue-700 text-white h-10 w-10 rounded-full flex items-center justify-center transition-colors"
            aria-label="Buscar"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProductSearch;