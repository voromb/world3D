//src/app/shop/page.tsx
'use client';

import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import Link from 'next/link';
import { CategoryType, FilterType, ProductType } from '@/types';
import { queryStringToFilters } from '@/lib/utils/filterUtils';

// Componentes
import ProductGrid from '@/components/ui/product/ProductGrid';
import FilterBar from '@/components/ui/filter/FilterBar';

// Interfaz para extender ProductType con metadatos
interface ProductWithMeta extends ProductType {
  __meta?: {
    pagination: {
      total: number;
    }
  }
}

export default function ShopPage() {
  const searchParams = useSearchParams();
  
  // Estados
  const [loading, setLoading] = useState(true);
  const [initialLoad, setInitialLoad] = useState(true);
  const [products, setProducts] = useState<ProductWithMeta[]>([]);
  const [categories, setCategories] = useState<CategoryType[]>([]);
  const [cities, setCities] = useState<string[]>([]);
  const [totalPages, setTotalPages] = useState(1);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalItems, setTotalItems] = useState(0);
  
  // Obtener filtros iniciales de URL
  const filters = queryStringToFilters(searchParams.toString());
  
  // Cargar datos iniciales (categorías, ciudades)
  useEffect(() => {
    const fetchFilterData = async () => {
      try {
        const response = await fetch('/api/categories?type=all');
        const data = await response.json();
        
        setCategories(data.categories || []);
        setCities(data.cities || []);
      } catch (error) {
        console.error('Error fetching filter data:', error);
      }
    };
    
    fetchFilterData();
  }, []);
  
  // Cargar productos con filtros
  useEffect(() => {
    const fetchProducts = async () => {
      if (!searchParams) return;
      
      setLoading(true);
      
      try {
        // Construir URL con filtros
        const apiUrl = `/api/products?${searchParams.toString()}`;
        const response = await fetch(apiUrl);
        const data = await response.json();
        
        setProducts(data.data || []);
        setTotalPages(data.meta?.pagination?.pageCount || 1);
        setTotalItems(data.meta?.pagination?.total || 0);
        setCurrentPage(parseInt(searchParams.get('page') || '1', 10));
        
        setLoading(false);
        setInitialLoad(false);
      } catch (error) {
        console.error('Error fetching products:', error);
        setLoading(false);
        setInitialLoad(false);
      }
    };
    
    fetchProducts();
  }, [searchParams]);
  
  // Generar título dinámico basado en los filtros
  const getPageTitle = () => {
    let title = 'Impresoras 3D';
    
    if (filters.category) {
      const category = categories.find(c => c.slug === filters.category);
      if (category) {
        title = category.categoryName;
      }
    }
    
    if (filters.city) {
      title += ` en ${filters.city}`;
    }
    
    if (filters.search) {
      title = `Resultados para "${filters.search}"`;
    }
    
    return title;
  };
  
  return (
    <main className="min-h-screen bg-gray-50 py-8">
      <div className="container mx-auto px-4">
        {/* Encabezado */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">{getPageTitle()}</h1>
          <div className="text-gray-600 flex items-center">
            <Link href="/" className="hover:underline">Inicio</Link>
            <span className="mx-2">/</span>
            <span>Tienda</span>
            {filters.category && (
              <>
                <span className="mx-2">/</span>
                <span>{categories.find(c => c.slug === filters.category)?.categoryName || filters.category}</span>
              </>
            )}
          </div>
        </div>
        
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
          {/* Barra de filtros */}
          <div className="lg:col-span-1">
            <FilterBar
              categories={categories}
              cities={cities}
              initialFilters={filters}
              className="sticky top-24"
            />
          </div>
          
          {/* Contenido principal */}
          <div className="lg:col-span-3">
            {/* Barra de resultados */}
            {!initialLoad && (
              <div className="bg-white rounded-lg shadow p-4 mb-6 flex flex-col sm:flex-row justify-between items-center">
                <div>
                  Mostrando{' '}
                  <span className="font-medium">{products.length}</span>{' '}
                  de{' '}
                  <span className="font-medium">
                    {totalItems}
                  </span>{' '}
                  resultados
                </div>
                
                <div className="mt-2 sm:mt-0">
                  {filters.search && (
                    <span className="inline-block bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                      Búsqueda: {filters.search}
                      <button
                        className="ml-2 text-blue-600 hover:text-blue-800"
                        onClick={() => {
                          const newParams = new URLSearchParams(searchParams.toString());
                          newParams.delete('search');
                          window.location.href = `/shop?${newParams.toString()}`;
                        }}
                      >
                        ×
                      </button>
                    </span>
                  )}
                </div>
              </div>
            )}
            
            {/* Lista de productos */}
            <ProductGrid 
              products={products} 
              loading={loading} 
              emptyMessage="No se encontraron productos que coincidan con tus filtros"
            />
            
            {/* Paginación */}
            {totalPages > 1 && !loading && (
              <div className="mt-8 flex justify-center">
                <nav className="flex items-center space-x-2">
                  <PageButton
                    onClick={() => {
                      const newParams = new URLSearchParams(searchParams.toString());
                      newParams.set('page', (currentPage - 1).toString());
                      window.location.href = `/shop?${newParams.toString()}`;
                    }}
                    disabled={currentPage === 1}
                  >
                    Anterior
                  </PageButton>
                  
                  {Array.from({ length: totalPages }, (_, i) => (
                    <PageButton
                      key={i}
                      onClick={() => {
                        const newParams = new URLSearchParams(searchParams.toString());
                        newParams.set('page', (i + 1).toString());
                        window.location.href = `/shop?${newParams.toString()}`;
                      }}
                      active={currentPage === i + 1}
                    >
                      {i + 1}
                    </PageButton>
                  ))}
                  
                  <PageButton
                    onClick={() => {
                      const newParams = new URLSearchParams(searchParams.toString());
                      newParams.set('page', (currentPage + 1).toString());
                      window.location.href = `/shop?${newParams.toString()}`;
                    }}
                    disabled={currentPage === totalPages}
                  >
                    Siguiente
                  </PageButton>
                </nav>
              </div>
            )}
          </div>
        </div>
      </div>
    </main>
  );
}

// Componente auxiliar para botones de paginación
interface PageButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  disabled?: boolean;
  active?: boolean;
}

const PageButton: React.FC<PageButtonProps> = ({ 
  children, 
  onClick, 
  disabled = false, 
  active = false 
}) => {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`px-3 py-1 rounded ${
        active 
          ? 'bg-blue-600 text-white' 
          : disabled 
            ? 'bg-gray-200 text-gray-500 cursor-not-allowed' 
            : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
      }`}
    >
      {children}
    </button>
  );
};