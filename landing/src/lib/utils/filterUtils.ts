//src/lib/utils/filterUtils.ts

import { FilterType } from '@/types';

export function buildFilterUrl(
  baseUrl: string, 
  filters: FilterType, 
  populateFields: string[] = ['images', 'categories', 'brands']
): string {
  const url = new URL(baseUrl);
  
  // Ajustar paginación
  if (filters.page) {
    url.searchParams.append('pagination[page]', filters.page.toString());
  } else {
    url.searchParams.append('pagination[page]', '1');
  }
  
  url.searchParams.append('pagination[pageSize]', '12');
  
  // Aplicar filtros de búsqueda
  if (filters.category) {
    // Fix multi-categorias (,)
    const categories = filters.category.split(',');
    if (categories.length === 1) {
      url.searchParams.append('filters[categories][slug][$eq]', categories[0]);
    } else if (categories.length > 1) {
      categories.forEach((cat, index) => {
        url.searchParams.append(`filters[$or][${index}][categories][slug][$eq]`, cat);
      });
    }
  }
  
  if (filters.city) {
    // Ciudades multi-selección
    const cities = filters.city.split(',');
    if (cities.length === 1) {
      url.searchParams.append('filters[cityName][$eq]', cities[0]);
    } else if (cities.length > 1) {
      cities.forEach((city, index) => {
        url.searchParams.append(`filters[$or][${index}][cityName][$eq]`, city);
      });
    }
  }
  
  // Filtrado por fabricante
  if (filters.brand) {
    // Manejar múltiples marcas separadas por comas
    const brands = filters.brand.split(',');
    if (brands.length === 1) {
      url.searchParams.append('filters[brands][slug][$eq]', brands[0]);
    } else if (brands.length > 1) {
      brands.forEach((brand, index) => {
        url.searchParams.append(`filters[$or][${index}][brands][slug][$eq]`, brand);
      });
    }
    
    // Asegurar que incluimos brands en la población
    if (!populateFields.includes('brands')) {
      populateFields.push('brands');
    }
  }
  
  // Filtro de tipo de envío
  if (filters.shipping) {
    url.searchParams.append('filters[shipping_types][slug][$eq]', filters.shipping);
  }
  
  if (filters.state) {
    url.searchParams.append('filters[state][$eq]', filters.state);
  }
  
  // Búsqueda de texto
  if (filters.search) {
    url.searchParams.append('filters[productName][$containsi]', filters.search);
  }
  
  // Filtro de precio
  if (filters.price) {
    const priceRange = parsePriceRange(filters.price);
    if (priceRange.min !== undefined) {
      url.searchParams.append('filters[price][$gte]', priceRange.min.toString());
    }
    if (priceRange.max !== undefined) {
      url.searchParams.append('filters[price][$lte]', priceRange.max.toString());
    }
  }
  
  // Ordenación
  if (filters.sort) {
    const [field, order] = parseSortOption(filters.sort);
    url.searchParams.append('sort', `${field}:${order}`);
  } else {
    // Ordenación por defecto
    url.searchParams.append('sort', 'createdAt:desc');
  }
  
  // IMPORTANTE: Añadir los campos a poblar (populate) especificados
  // Esto permite que cada llamada decida qué relaciones necesita incluir
  populateFields.forEach(field => {
    url.searchParams.append('populate', field);
  });
  
  return url.toString();
}

/**
 * Convierte un string de rango de precios (e.g. "0-500") en un objeto con min y max
 */
export function parsePriceRange(priceRange: string): { min?: number, max?: number } {
  if (priceRange.endsWith('+')) {
    const min = parseInt(priceRange.slice(0, -1), 10);
    return { min };
  }
  
  const [min, max] = priceRange.split('-').map(p => parseInt(p, 10));
  
  return {
    min: isNaN(min) ? undefined : min,
    max: isNaN(max) ? undefined : max
  };
}

/**
 * Analiza la opción de ordenación
 */
export function parseSortOption(sortOption: string): [string, string] {
  if (sortOption.includes(':')) {
    return sortOption.split(':') as [string, string];
  }
  
  // Opciones de ordenación predefinidas
  const sortOptions: Record<string, [string, string]> = {
    'price-asc': ['price', 'asc'],
    'price-desc': ['price', 'desc'],
    'newest': ['createdAt', 'desc'],
    'oldest': ['createdAt', 'asc'],
    'name-asc': ['productName', 'asc'],
    'name-desc': ['productName', 'desc']
  };
  
  return sortOptions[sortOption] || ['createdAt', 'desc'];
}

/**
 * Convierte los filtros a parámetros de URL para la navegación del lado del cliente
 */
export function filtersToQueryString(filters: FilterType): string {
  const params = new URLSearchParams();
  
  Object.entries(filters).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== '') {
      params.append(key, value.toString());
    }
  });
  
  return params.toString();
}

/**
 * Convierte los parámetros de URL a un objeto de filtros
 */
export function queryStringToFilters(queryString: string): FilterType {
  const params = new URLSearchParams(queryString);
  const filters: FilterType = {};
  
  params.forEach((value, key) => {
    // Verificar que la clave es válida para FilterType
    if (isValidFilterKey(key)) {
      if (key === 'page' && !isNaN(parseInt(value, 10))) {
        filters.page = parseInt(value, 10);
      } else if (
        key === 'category' || 
        key === 'city' || 
        key === 'price' || 
        key === 'brand' || 
        key === 'state' || 
        key === 'search' || 
        key === 'sort' ||
        key === 'shipping'
      ) {
        // Asignar valores de string a las propiedades correspondientes
        filters[key] = value;
      }
    }
  });
  
  return filters;
}

/**
 * Verifica si una clave es válida para el tipo FilterType
 */
function isValidFilterKey(key: string): key is keyof FilterType {
  return [
    'category',
    'city',
    'price',
    'brand',
    'state',
    'search',
    'sort',
    'page',
    'shipping'
  ].includes(key);
}

/**
 * Genera opciones de rango de precios
 */
export function getPriceRangeOptions(): { label: string; value: string }[] {
  return [
    { label: 'Cualquier precio', value: '' },
    { label: '0€ - 500€', value: '0-500' },
    { label: '500€ - 1000€', value: '500-1000' },
    { label: '1000€ - 2000€', value: '1000-2000' },
    { label: '2000€ - 5000€', value: '2000-5000' },
    { label: 'Más de 5000€', value: '5000+' }
  ];
}

/**
 * Genera opciones de ordenación
 */
export function getSortOptions(): { label: string; value: string }[] {
  return [
    { label: 'Más recientes', value: 'newest' },
    { label: 'Más antiguos', value: 'oldest' },
    { label: 'Precio: de menor a mayor', value: 'price-asc' },
    { label: 'Precio: de mayor a menor', value: 'price-desc' },
    { label: 'Nombre: A-Z', value: 'name-asc' },
    { label: 'Nombre: Z-A', value: 'name-desc' }
  ];
}