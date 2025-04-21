'use client';

import React, { useEffect, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { CategoryType, FilterType } from '@/types';
import { filtersToQueryString, getSortOptions } from '@/lib/utils/filterUtils';

// Componentes de filtro
import CategoryFilter from './CategoryFilter';
import CityFilter from './CityFilter';
import PriceFilter from './PriceFilter';

interface FilterBarProps {
  categories: CategoryType[];
  cities: string[];
  initialFilters?: FilterType;
  onFiltersChange?: (filters: FilterType) => void;
  className?: string;
}

const FilterBar: React.FC<FilterBarProps> = ({
  categories,
  cities,
  initialFilters = {},
  onFiltersChange,
  className = ''
}) => {
  const router = useRouter();
  const searchParams = useSearchParams();
  
  const [filters, setFilters] = useState<FilterType>({
    category: initialFilters.category || searchParams.get('category') || '',
    city: initialFilters.city || searchParams.get('city') || '',
    price: initialFilters.price || searchParams.get('price') || '',
    search: initialFilters.search || searchParams.get('search') || '',
    sort: initialFilters.sort || searchParams.get('sort') || 'newest',
  });
  
  const [mobileFiltersOpen, setMobileFiltersOpen] = useState(false);
  
  // Aplicar filtros
  const applyFilters = () => {
    // Construir query string
    const queryString = filtersToQueryString(filters);
    
    // Actualizar URL
    router.push(`/shop?${queryString}`);
    
    // Notificar cambios
    if (onFiltersChange) {
      onFiltersChange(filters);
    }
    
    // Cerrar filtros móviles
    setMobileFiltersOpen(false);
  };
  
  // Limpiar filtros
  const clearFilters = () => {
    const newFilters: FilterType = {
      category: '',
      city: '',
      price: '',
      search: filters.search, // Mantener búsqueda
      sort: 'newest'
    };
    
    setFilters(newFilters);
    
    // Aplicar inmediatamente
    router.push(`/shop${filters.search ? `?search=${filters.search}` : ''}`);
    
    if (onFiltersChange) {
      onFiltersChange(newFilters);
    }
    
    setMobileFiltersOpen(false);
  };
  
  // Manejar cambios en filtros
  const handleFilterChange = (key: keyof FilterType, value: string) => {
    setFilters((prev) => ({
      ...prev,
      [key]: value
    }));
  };
  
  // Opciones de ordenación
  const sortOptions = getSortOptions();
  
  return (
    <div className={`bg-white rounded-lg shadow p-4 ${className}`}>
      {/* Botón para mostrar/ocultar filtros en móvil */}
      <div className="lg:hidden mb-4">
        <button
          onClick={() => setMobileFiltersOpen(!mobileFiltersOpen)}
          className="w-full flex items-center justify-between bg-gray-100 p-3 rounded-md"
        >
          <span className="font-medium">Filtros</span>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="20"
            height="20"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className={`transition-transform ${mobileFiltersOpen ? 'rotate-180' : ''}`}
          >
            <polyline points="6 9 12 15 18 9"></polyline>
          </svg>
        </button>
      </div>

      {/* Contenedor de filtros */}
      <div className={`
        transition-all duration-300 overflow-hidden
        lg:max-h-full lg:opacity-100 lg:visible
        ${mobileFiltersOpen ? 'max-h-[1000px] opacity-100 visible' : 'max-h-0 opacity-0 invisible lg:visible'}
      `}>
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Filtro de categorías */}
          <CategoryFilter
            categories={categories}
            selectedCategory={filters.category || ''}
            onChange={(value) => handleFilterChange('category', value)}
          />
          
          {/* Filtro de ciudades */}
          <CityFilter
            cities={cities}
            selectedCity={filters.city || ''}
            onChange={(value) => handleFilterChange('city', value)}
          />
          
          {/* Filtro de precios */}
          <PriceFilter
            selectedPrice={filters.price || ''}
            onChange={(value) => handleFilterChange('price', value)}
          />
        </div>
        
        {/* Ordenación */}
        <div className="mt-6 pt-6 border-t border-gray-200">
          <h3 className="font-medium text-gray-900 mb-2">Ordenar por</h3>
          
          <select
            value={filters.sort || 'newest'}
            onChange={(e) => handleFilterChange('sort', e.target.value)}
            className="w-full p-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
          >
            {sortOptions.map((option, index) => (
              <option key={index} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        </div>
        
        {/* Botones de acción */}
        <div className="mt-6 flex flex-col sm:flex-row gap-3">
          <button
            onClick={applyFilters}
            className="flex-1 bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded transition-colors"
          >
            Aplicar filtros
          </button>
          
          <button
            onClick={clearFilters}
            className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-800 py-2 px-4 rounded transition-colors"
          >
            Limpiar filtros
          </button>
        </div>
      </div>
    </div>
  );
};

export default FilterBar;