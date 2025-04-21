import { NextRequest, NextResponse } from 'next/server';
import { fetchBrands, fetchCategories, fetchCities, fetchStates } from '@/lib/api/fetchCategories';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const type = searchParams.get('type');
    
    switch (type) {
      case 'cities':
        const cities = await fetchCities();
        return NextResponse.json(cities);
      
      case 'states':
        const states = await fetchStates();
        return NextResponse.json(states);
      
      case 'brands':
        const brands = await fetchBrands();
        return NextResponse.json(brands);
        
      case 'all':
        // Obtener todos los tipos de filtros en una sola solicitud
        const [categoriesData, citiesData, statesData, brandsData] = await Promise.all([
          fetchCategories(),
          fetchCities(),
          fetchStates(),
          fetchBrands()
        ]);
        
        return NextResponse.json({
          categories: categoriesData,
          cities: citiesData,
          states: statesData,
          brands: brandsData
        });
        
      default:
        // Por defecto, devolver solo categorías
        const categories = await fetchCategories();
        return NextResponse.json(categories);
    }
  } catch (error) {
    console.error('Error in categories API route:', error);
    return NextResponse.json(
      { error: 'Failed to fetch categories' },
      { status: 500 }
    );
  }
}