//src/app/api/suggestions/route.ts

import { NextRequest, NextResponse } from "next/server";

// Endpoint para obtener sugerencias de búsqueda basadas en productos y marcas existentes
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    // Usamos "query" como nombre para mantener compatibilidad con tu implementación
    const query = searchParams.get("query");
    
    if (!query || query.length < 1) { // Permitimos búsquedas desde 1 carácter
      return NextResponse.json({ 
        suggestions: [] 
      });
    }

    console.log("Buscando sugerencias para:", query);
    
    // Array para almacenar todas las sugerencias
    let allSuggestions: string[] = [];
    
    // 1. Buscar productos que coincidan
    const productsUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?pagination[limit]=5&filters[$or][0][productName][$containsi]=${encodeURIComponent(query)}&filters[$or][1][description][$containsi]=${encodeURIComponent(query)}&filters[$or][2][reference][$containsi]=${encodeURIComponent(query)}`;
    
    console.log("URL de búsqueda productos:", productsUrl);
    
    try {
      const productsRes = await fetch(productsUrl);
      
      if (productsRes.ok) {
        const productsData = await productsRes.json();
        
        if (productsData.data && Array.isArray(productsData.data)) {
          const productSuggestions = productsData.data
            .map((item: any) => item.productName || (item.attributes && item.attributes.productName) || "")
            .filter(Boolean);
          
          allSuggestions = [...allSuggestions, ...productSuggestions];
          console.log("Sugerencias de productos:", productSuggestions);
        }
      }
    } catch (err) {
      console.error("Error al buscar productos:", err);
    }
    
    // 2. Buscar marcas que coincidan
    const brandsUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/brands?pagination[limit]=5&filters[brandName][$containsi]=${encodeURIComponent(query)}`;
    
    console.log("URL de búsqueda marcas:", brandsUrl);
    
    try {
      const brandsRes = await fetch(brandsUrl);
      
      if (brandsRes.ok) {
        const brandsData = await brandsRes.json();
        
        if (brandsData.data && Array.isArray(brandsData.data)) {
          const brandSuggestions = brandsData.data
            .map((item: any) => {
              // Intentar acceder a brandName directamente o a través de attributes
              const name = item.brandName || (item.attributes && item.attributes.brandName) || "";
              return name ? `Marca: ${name}` : "";
            })
            .filter(Boolean);
          
          allSuggestions = [...allSuggestions, ...brandSuggestions];
          console.log("Sugerencias de marcas:", brandSuggestions);
        }
      }
    } catch (err) {
      console.error("Error al buscar marcas:", err);
    }
    
    // 3. Buscar categorías que coincidan
    const categoriesUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/categories?pagination[limit]=3&filters[categoryName][$containsi]=${encodeURIComponent(query)}`;
    
    try {
      const categoriesRes = await fetch(categoriesUrl);
      
      if (categoriesRes.ok) {
        const categoriesData = await categoriesRes.json();
        
        if (categoriesData.data && Array.isArray(categoriesData.data)) {
          const categorySuggestions = categoriesData.data
            .map((item: any) => {
              const name = item.categoryName || (item.attributes && item.attributes.categoryName) || "";
              return name ? `Categoría: ${name}` : "";
            })
            .filter(Boolean);
          
          allSuggestions = [...allSuggestions, ...categorySuggestions];
        }
      }
    } catch (err) {
      console.error("Error al buscar categorías:", err);
    }
    
    // Eliminar duplicados y limitar resultados
    const uniqueSuggestions = [...new Set(allSuggestions)].slice(0, 10);
    
    console.log("Sugerencias finales:", uniqueSuggestions);
    
    return NextResponse.json({ suggestions: uniqueSuggestions });
  } catch (error) {
    console.error("Error al obtener sugerencias:", error);
    return NextResponse.json({ 
      suggestions: [],
      error: "Error al obtener sugerencias" 
    }, { status: 500 });
  }
}