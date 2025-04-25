//src/components/ProductSearch.tsx

'use client';

import React, { useState, useEffect, useRef } from 'react';
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
  // Estados para gestionar los campos y autocompletado
  const [searchTerm, setSearchTerm] = useState('');
  const [suggestions, setSuggestions] = useState<string[]>([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const searchRef = useRef<HTMLDivElement>(null);
  const router = useRouter();

  // Ocultar sugerencias al hacer clic fuera del componente
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (searchRef.current && !searchRef.current.contains(event.target as Node)) {
        setShowSuggestions(false);
      }
    }

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, []);

  // Obtener sugerencias cuando cambia el término de búsqueda
  useEffect(() => {
    // Solo hacer la consulta si hay al menos 1 carácter
    if (searchTerm.length < 1) {
      setSuggestions([]);
      return;
    }

    // Función para obtener sugerencias
    const fetchSuggestions = async () => {
      setIsLoading(true);
      try {
        // Modificado para usar el mismo nombre de parámetro que en nuestro API
        const response = await fetch(`/api/suggestions?query=${encodeURIComponent(searchTerm)}`);
        if (response.ok) {
          const data = await response.json();
          console.log("Sugerencias recibidas:", data.suggestions);
          setSuggestions(data.suggestions || []);
        } else {
          console.error("Error en la respuesta de sugerencias:", response.status);
          setSuggestions([]);
        }
      } catch (error) {
        console.error('Error al obtener sugerencias:', error);
        setSuggestions([]);
      } finally {
        setIsLoading(false);
      }
    };

    // Debounce para evitar muchas peticiones
    const timer = setTimeout(() => {
      fetchSuggestions();
    }, 300);

    return () => clearTimeout(timer);
  }, [searchTerm]);

  // Manejar la selección de una sugerencia
  const handleSuggestionClick = (suggestion: string) => {
    // Si es una sugerencia de marca o categoría, extraer solo el nombre
    let searchValue = suggestion;
    
    if (suggestion.startsWith('Marca: ')) {
      searchValue = suggestion.substring(7); // Quitar "Marca: " del inicio
    } else if (suggestion.startsWith('Categoría: ')) {
      searchValue = suggestion.substring(11); // Quitar "Categoría: " del inicio
    }
    
    setSearchTerm(searchValue);
    setShowSuggestions(false);
    
    // Si es Prusa, usamos la ruta de búsqueda directa
    if (searchValue.toLowerCase() === 'prusa') {
      console.log("Búsqueda especial para Prusa");
      window.location.href = `/shop?search=${encodeURIComponent(searchValue)}&direct=true`;
      return;
    }
    
    // Usar la versión de formulario nativa para mejor compatibilidad
    const form = document.createElement('form');
    form.action = '/shop';
    form.method = 'get';
    
    // Crear y agregar el input para el término de búsqueda
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'search';
    input.value = searchValue;
    form.appendChild(input);
    
    // Añadir el formulario al documento y enviarlo
    document.body.appendChild(form);
    form.submit();
  };

  return (
    <div className={`w-full max-w-4xl mx-auto bg-white rounded-full shadow-lg p-2 ${className}`} ref={searchRef}>
      {/* Formulario HTML nativo que funcionará siempre */}
      <form action="/shop" method="get" className="flex flex-col md:flex-row">
        {/* Campo de búsqueda con autocompletado */}
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3 relative">
          <label htmlFor="search-input" className="block text-sm text-gray-500 mb-1">Buscar</label>
          <input
            id="search-input"
            name="search"
            type="text"
            placeholder="¿Qué producto estás buscando?"
            className="w-full bg-transparent text-gray-800 focus:outline-none"
            value={searchTerm}
            onChange={(e) => {
              setSearchTerm(e.target.value);
              setShowSuggestions(true);
            }}
            autoComplete="off" // Desactivar autocompletado nativo
          />
          
          {/* Lista de sugerencias */}
          {showSuggestions && searchTerm.length >= 1 && (
            <div className="absolute left-0 right-0 top-full mt-1 bg-white shadow-lg rounded-md z-10 max-h-60 overflow-y-auto">
              {isLoading ? (
                <div className="p-3 text-gray-500">Buscando...</div>
              ) : suggestions.length > 0 ? (
                <ul className="py-1">
                  {suggestions.map((suggestion, index) => (
                    <li 
                      key={index} 
                      className={`px-4 py-2 hover:bg-gray-100 cursor-pointer ${
                        suggestion.startsWith('Marca:') ? 'text-blue-600' : 
                        suggestion.startsWith('Categoría:') ? 'text-green-600' : ''
                      }`}
                      onClick={() => handleSuggestionClick(suggestion)}
                    >
                      {suggestion}
                    </li>
                  ))}
                </ul>
              ) : (
                <div className="p-3 text-gray-500">No se encontraron sugerencias</div>
              )}
            </div>
          )}
        </div>
        
        {/* Categoría */}
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3">
          <label htmlFor="category-select" className="block text-sm text-gray-500 mb-1">Categoría</label>
          <select 
            id="category-select"
            name="category"
            className="w-full bg-transparent text-gray-800 focus:outline-none"
          >
            <option value="">Todas las categorías</option>
            {categories.map((category) => (
              <option key={category.id} value={category.slug}>
                {category.categoryName}
              </option>
            ))}
          </select>
        </div>
        
        {/* Ciudad */}
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3">
          <label htmlFor="city-select" className="block text-sm text-gray-500 mb-1">Ciudad</label>
          <select 
            id="city-select"
            name="city"
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
        <div className="flex-1 border-b md:border-b-0 md:border-r border-gray-200 p-3">
          <label htmlFor="price-select" className="block text-sm text-gray-500 mb-1">Precio</label>
          <select 
            id="price-select"
            name="price"
            className="w-full bg-transparent text-gray-800 focus:outline-none"
          >
            <option value="">Cualquier precio</option>
            <option value="0-100">Hasta 100€</option>
            <option value="100-500">100€ - 500€</option>
            <option value="500-1000">500€ - 1.000€</option>
            <option value="1000-2000">1.000€ - 2.000€</option>
            <option value="2000+">Más de 2.000€</option>
          </select>
        </div>
        
        {/* Botón de búsqueda */}
        <div className="p-3 flex items-center">
          <button 
            type="submit"
            className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-full transition duration-300"
          >
            Buscar
          </button>
        </div>
      </form>
    </div>
  );
};

export default ProductSearch;