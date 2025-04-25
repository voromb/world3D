//src/app/shop/page.tsx

'use client';

import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import Link from 'next/link';
import { CategoryType, FilterType, ProductType } from '@/types';
import { queryStringToFilters } from '@/lib/utils/filterUtils';
import dynamic from 'next/dynamic';

// Componentes
import ProductGrid from '@/components/ui/product/ProductGrid';
import CollapsibleFilterBar from '@/components/ui/filter/CollapsibleFilterBar';

// Importación dinámica del componente de mapa para evitar problemas con SSR
const ProductMap = dynamic(() => import('@/components/ui/map/ProductMap'), {
  ssr: false,
  loading: () => <div className="w-full h-[800px] bg-gray-100 flex items-center justify-center">Cargando mapa...</div>
});

// Interfaz para extender ProductType con metadatos
interface ProductWithMeta extends ProductType {
  __meta?: {
    pagination: {
      total: number;
    }
  }
}

// Interfaz para la marca
interface Brand {
  id: number;
  brandName: string;
  slug: string;
}

export default function ShopPage() {
  const searchParams = useSearchParams();
  
  // Estados
  const [loading, setLoading] = useState(true);
  const [initialLoad, setInitialLoad] = useState(true);
  const [products, setProducts] = useState<ProductWithMeta[]>([]);
  const [categories, setCategories] = useState<CategoryType[]>([]);
  const [brands, setBrands] = useState<Brand[]>([]);
  const [cities, setCities] = useState<string[]>([]);
  const [totalPages, setTotalPages] = useState(1);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalItems, setTotalItems] = useState(0);
  
  // Obtener filtros iniciales de URL
  const filters = queryStringToFilters(searchParams.toString());
  
  // Estado para la marca actual (cuando se filtra por marca)
  const [currentBrand, setCurrentBrand] = useState<string>('');
  
  // Cargar datos iniciales (categorías, ciudades, marcas)
  useEffect(() => {
    const fetchFilterData = async () => {
      try {
        // Cargar categorías y ciudades
        const categoriesUrl = '/api/categories?type=all';
        
        const response = await fetch(categoriesUrl);
        const responseText = await response.text();
        
        let data;
        try {
          data = JSON.parse(responseText);
        } catch (parseError) {
          console.error('Error parsing categories response');
          return;
        }
        
        setCategories(data.categories || []);
        setCities(data.cities || []);
        
        // También cargar marcas para el filtro
        const brandsUrl = '/api/brands';
        const brandsResponse = await fetch(brandsUrl);
        const brandsResponseText = await brandsResponse.text();
        
        let brandsData;
        try {
          brandsData = JSON.parse(brandsResponseText);
        } catch (parseError) {
          console.error('Error parsing brands response');
          return;
        }
        
        if (brandsData && brandsData.data) {
          const parsedBrands: Brand[] = brandsData.data.map((brand: any) => {
            const brandData = brand.attributes || brand;
            return {
              id: brand.id,
              brandName: brandData.brandName || 'Sin nombre',
              slug: brandData.slug || '',
            };
          });
          
          setBrands(parsedBrands);
          
          // Si hay un filtro de marca activo, buscar el nombre de la marca
          if (filters.brand) {
            const matchingBrand = parsedBrands.find((b: Brand) => b.slug === filters.brand);
            if (matchingBrand) {
              setCurrentBrand(matchingBrand.brandName);
            } else {
              // Si no encontramos la marca en la lista, intentar buscarla directamente
              try {
                const singleBrandUrl = `/api/brands?slug=${encodeURIComponent(filters.brand)}`;
                
                const singleBrandResponse = await fetch(singleBrandUrl);
                const singleBrandData = await singleBrandResponse.json();
                
                if (singleBrandData.data && singleBrandData.data.length > 0) {
                  const brandData = singleBrandData.data[0].attributes || singleBrandData.data[0];
                  setCurrentBrand(brandData.brandName || filters.brand);
                } else {
                  setCurrentBrand(filters.brand); // Usar el slug si no se encuentra la marca
                }
              } catch (err) {
                console.error('Error fetching single brand');
                setCurrentBrand(filters.brand);
              }
            }
          }
        }
      } catch (error) {
        console.error('Error fetching filter data');
      }
    };
    
    fetchFilterData();
  }, [filters.brand]);

  // Cargar productos con filtros
  useEffect(() => {
    const fetchProducts = async () => {
      if (!searchParams) return;
      
      setLoading(true);
      
      // Extraer información de filtros para depuración
      const hasBrandFilter = searchParams.has('brand');
      const brandValue = searchParams.get('brand') || '';
      
      try {
        // Construir URL con filtros
        const apiUrl = `/api/products?${searchParams.toString()}`;
        
        const response = await fetch(apiUrl);
        const responseText = await response.text();
        
        let data;
        try {
          data = JSON.parse(responseText);
        } catch (parseError) {
          console.error('Error parsing products response');
          setLoading(false);
          setInitialLoad(false);
          return;
        }
        
        if (data.data?.length === 0 && hasBrandFilter) {
          console.error(`No se encontraron productos con la marca: ${brandValue}`);
        }
        
        setProducts(data.data || []);
        setTotalPages(data.meta?.pagination?.pageCount || 1);
        setTotalItems(data.meta?.pagination?.total || 0);
        setCurrentPage(parseInt(searchParams.get('page') || '1', 10));
        
        setLoading(false);
        setInitialLoad(false);
      } catch (error) {
        console.error('Error fetching products');
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
    
    if (filters.brand) {
      // Usar el nombre de la marca si lo tenemos, de lo contrario usar el slug
      title += ` - Marca ${currentBrand || filters.brand}`;
    }
    
    if (filters.search) {
      title = `Resultados para "${filters.search}"`;
    }
    
    return title;
  };
  
  // Función para eliminar un filtro
  const removeFilter = (filterType: string) => {
    const newParams = new URLSearchParams(searchParams.toString());
    newParams.delete(filterType);
    window.location.href = `/shop?${newParams.toString()}`;
  };
  
  return (
    <main className="min-h-screen bg-gray-50 py-8">
      <div className="container mx-auto px-4">
        {/* Encabezado */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">{getPageTitle()}</h1>
          <div className="flex items-center text-sm text-gray-500">
            <Link href="/" className="hover:text-blue-600">Inicio</Link>
            <span className="mx-2">/</span>
            <span>Tienda</span>
            {filters.category && (
              <>
                <span className="mx-2">/</span>
                <span>{filters.category}</span>
              </>
            )}
            {filters.brand && (
              <>
                <span className="mx-2">/</span>
                <span>{currentBrand || filters.brand}</span>
              </>
            )}
          </div>
          
          {/* Filtros activos como etiquetas */}
          {(filters.brand || filters.category || filters.search) && (
            <div className="mt-4 flex flex-wrap gap-2">
              {filters.brand && (
                <span className="inline-flex items-center bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                  Marca: {currentBrand || filters.brand}
                  <button
                    className="ml-2 text-blue-600 hover:text-blue-800"
                    onClick={() => removeFilter('brand')}
                    aria-label="Eliminar filtro de marca"
                  >
                    ×
                  </button>
                </span>
              )}
              
              {filters.category && (
                <span className="inline-flex items-center bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">
                  Categoría: {filters.category}
                  <button
                    className="ml-2 text-green-600 hover:text-green-800"
                    onClick={() => removeFilter('category')}
                    aria-label="Eliminar filtro de categoría"
                  >
                    ×
                  </button>
                </span>
              )}
              
              {filters.search && (
                <span className="inline-flex items-center bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm">
                  Búsqueda: {filters.search}
                  <button
                    className="ml-2 text-purple-600 hover:text-purple-800"
                    onClick={() => removeFilter('search')}
                    aria-label="Eliminar búsqueda"
                  >
                    ×
                  </button>
                </span>
              )}
            </div>
          )}
        </div>
        
        {/* Panel de filtros colapsable y resultados */}
        <div className="mb-8">
          <CollapsibleFilterBar
            categories={categories}
            cities={cities}
            brands={brands}
            initialFilters={filters}
          />
        </div>

        {/* Contenedor principal con mapa y productos */}
        <div className="flex flex-col md:flex-row gap-6">
          {/* Mapa en el lado izquierdo - Aumentado a 800px de altura para que llegue a la segunda card */}
          <div className="w-full md:w-1/3 md:sticky md:top-24 h-[800px] rounded-lg overflow-hidden shadow-md">
            <ProductMap products={products} height="800px" />
          </div>
          
          {/* Lista de productos en el lado derecho */}
          <div className="w-full md:w-2/3">
            {/* Barra de resultados */}
            {!initialLoad && products.length > 0 && (
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
              </div>
            )}
            
            {/* Lista de productos */}
            <ProductGrid 
              products={products} 
              loading={loading} 
              emptyMessage={
                filters.brand 
                  ? `No se encontraron productos de la marca ${currentBrand || filters.brand}. Intenta con otros filtros o ver todos los productos.` 
                  : "No se encontraron productos que coincidan con tus filtros. Intenta con otros filtros o ver todos los productos."
              }
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