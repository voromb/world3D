// src/app/api/categories/route.ts

import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const type = searchParams.get('type') || 'main';
    
    // URL base
    let apiUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/categories`;
    
    // Si se solicitan todas las categorías
    if (type === 'all') {
      apiUrl += '?populate=*';
    } else {
      // Para categorías principales
      apiUrl += '?filters[isMainCategory][$eq]=true&populate=*';
    }
    
    console.log('Fetching categories from:', apiUrl);
    
    const response = await fetch(apiUrl);
    
    if (!response.ok) {
      throw new Error(`Error fetching categories: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Obtener también las ciudades si se solicitan todas las categorías
    let cities: string[] = [];
    if (type === 'all') {
      try {
        const citiesUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/cities`;
        const citiesResponse = await fetch(citiesUrl);
        
        if (citiesResponse.ok) {
          const citiesData = await citiesResponse.json();
          cities = citiesData.data?.map((city: any) => {
            return city.attributes?.cityName || city.cityName || '';
          }).filter(Boolean) || [];
        }
      } catch (cityError) {
        console.error('Error fetching cities:', cityError);
      }
    }
    
    // Procesar las categorías
    const categories = data.data?.map((category: any) => {
      const categoryData = category.attributes || category;
      return {
        id: category.id,
        categoryName: categoryData.categoryName || 'Sin nombre',
        slug: categoryData.slug || '',
        isMainCategory: categoryData.isMainCategory || false,
        image: categoryData.image || null
      };
    }) || [];
    
    // Log para debugging
    console.log(`Received ${categories.length} categories and ${cities.length} cities`);
    
    return NextResponse.json({
      categories,
      cities
    });
  } catch (error) {
    console.error('Error in categories API route:', error);
    // En caso de error, devolver arrays vacíos para evitar errores en el cliente
    return NextResponse.json(
      { categories: [], cities: [] },
      { status: 500 }
    );
  }
}