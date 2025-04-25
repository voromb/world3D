import { CategoryType } from '@/types';

/**
 * Obtiene todas las categorías
 */
export async function fetchCategories(): Promise<CategoryType[]> {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/categories`);
    
    if (!response.ok) {
      throw new Error(`Error fetching categories: ${response.status}`);
    }
    
    const data = await response.json();
    
    return data.data || [];
  } catch (error) {
    console.error('Error fetching categories:', error);
    return [];
  }
}

/**
 * Obtiene las ciudades únicas de todos los productos
 */
export async function fetchCities(): Promise<string[]> {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/products?fields=cityName`);
    
    if (!response.ok) {
      throw new Error(`Error fetching cities: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Extraer ciudades únicas con tipado explícito
    const cityValues: string[] = data.data
      .map((item: any) => item.cityName as string)
      .filter((city: string | null) => city && city.trim() !== '');
    
    // Crear conjunto de valores únicos y convertir de nuevo a array
    const uniqueCities = [...new Set(cityValues)];
    
    // Ordenar alfabéticamente
    return uniqueCities.sort();
  } catch (error) {
    console.error('Error fetching cities:', error);
    return [];
  }
}

/**
 * Obtiene los estados únicos de los productos
 */
export async function fetchStates(): Promise<string[]> {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/products?fields=state`);
    
    if (!response.ok) {
      throw new Error(`Error fetching states: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Extraer estados únicos con tipado explícito
    const stateValues: string[] = data.data
      .map((item: any) => item.state as string)
      .filter((state: string | null) => state && state.trim() !== '');
    
    // Crear conjunto de valores únicos y convertir de nuevo a array
    const uniqueStates = [...new Set(stateValues)];
    
    // Ordenar alfabéticamente
    return uniqueStates.sort();
  } catch (error) {
    console.error('Error fetching states:', error);
    return [];
  }
}

/**
 * Obtiene las marcas únicas de los productos
 */
export async function fetchBrands(): Promise<{id: number, brandName: string, slug: string}[]> {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/brands`);
    
    if (!response.ok) {
      throw new Error(`Error fetching brands: ${response.status}`);
    }
    
    const data = await response.json();
    
    return (data.data || []).map((brand: any) => ({
      id: brand.id,
      brandName: brand.brandName,
      slug: brand.slug
    }));
  } catch (error) {
    console.error('Error fetching brands:', error);
    return [];
  }
}