'use client';

import React, { useState } from 'react';
import { FilterType, CategoryType } from '@/types';
import FilterBar from '@/components/ui/filter/FilterBar';

interface CollapsibleFilterBarProps {
  categories: CategoryType[];
  cities: string[];
  brands?: { id: number; brandName: string; slug: string }[];
  initialFilters: FilterType;
  className?: string;
}

const CollapsibleFilterBar: React.FC<CollapsibleFilterBarProps> = (props) => {
  const [isOpen, setIsOpen] = useState(false);
  
  return (
    <div className="mb-6">
      {/* Botón para mostrar/ocultar filtros */}
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="w-full flex items-center justify-between bg-white p-4 rounded-lg shadow mb-1 hover:bg-gray-50 transition-colors"
      >
        <div className="flex items-center">
          <svg 
            xmlns="http://www.w3.org/2000/svg" 
            className="h-5 w-5 mr-2 text-gray-500" 
            fill="none" 
            viewBox="0 0 24 24" 
            stroke="currentColor"
          >
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
          </svg>
          <span className="font-medium">Filtros</span>
        </div>
        
        {/* Icono de acordeón */}
        <svg 
          xmlns="http://www.w3.org/2000/svg" 
          className={`h-5 w-5 text-gray-500 transition-transform ${isOpen ? 'transform rotate-180' : ''}`} 
          fill="none" 
          viewBox="0 0 24 24" 
          stroke="currentColor"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
        </svg>
      </button>
      
      {/* Panel de filtros colapsable */}
      <div 
        className={`transition-all duration-300 overflow-hidden ${
          isOpen 
            ? 'max-h-[2000px] opacity-100' 
            : 'max-h-0 opacity-0'
        }`}
      >
        <FilterBar {...props} />
      </div>
      
      {/* Contador de filtros activos */}
      {!isOpen && Object.keys(props.initialFilters).length > 0 && (
        <div className="mt-2 text-sm text-gray-600">
          <span className="bg-blue-100 text-blue-800 px-2 py-1 rounded-full">
            {Object.keys(props.initialFilters).length} {Object.keys(props.initialFilters).length === 1 ? 'filtro activo' : 'filtros activos'}
          </span>
        </div>
      )}
    </div>
  );
};

export default CollapsibleFilterBar;