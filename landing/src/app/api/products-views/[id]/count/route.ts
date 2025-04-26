// src/app/api/products-views/[id]/count/route.ts

import { NextRequest, NextResponse } from 'next/server';

// Accedemos al mismo objeto global que usa el endpoint de increment
// Esto asegura que ambos endpoints trabajen con los mismos datos
const simulatedViews: Record<string, number> = 
  (global as any).__simulatedViews || {};

// Si no existe, lo inicializamos en el objeto global para compartirlo
if (!(global as any).__simulatedViews) {
  (global as any).__simulatedViews = simulatedViews;
}

export async function GET(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Acceder a los parámetros de forma asíncrona
    const params = await Promise.resolve(context.params);
    
    if (!params || !params.id) {
      return NextResponse.json(
        { message: 'ID de producto no proporcionado' },
        { status: 400 }
      );
    }
    
    // Obtener el ID del producto
    const productId = params.id;
    
    // Usar las variables de entorno
    const strapiBaseUrl = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:1337';
    
    console.log(`Consultando vistas para el producto ${productId}`);
    
    try {
      // Primero intentamos obtener las vistas desde Strapi
      const strapiUrl = `${strapiBaseUrl}/api/products/${productId}?fields[0]=views`;
      console.log('URL de consulta a Strapi:', strapiUrl);
      
      const response = await fetch(strapiUrl, {
        method: 'GET',
        headers: {
          // Sin token para usar permisos públicos
        }
      });
      
      if (response.ok) {
        // Si la consulta fue exitosa, devolvemos los datos reales
        const data = await response.json();
        const views = data.data?.attributes?.views || 0;
        
        console.log(`Vistas reales del producto ${productId} en Strapi:`, views);
        
        // Actualizar el contador simulado con el valor real
        simulatedViews[productId] = views;
        
        return NextResponse.json({
          views: views,
          source: 'strapi'
        });
      } else {
        // Si hay error, devolvemos el contador simulado
        console.log('Error al consultar Strapi, devolviendo contador simulado');
        
        // Inicializar si no existe
        if (!simulatedViews[productId]) {
          simulatedViews[productId] = 0;
        }
        
        return NextResponse.json({
          views: simulatedViews[productId],
          source: 'simulated'
        });
      }
    } catch (error) {
      console.error('Error al consultar vistas:', error);
      
      // Inicializar si no existe
      if (!simulatedViews[productId]) {
        simulatedViews[productId] = 0;
      }
      
      return NextResponse.json({
        views: simulatedViews[productId],
        source: 'simulated'
      });
    }
  } catch (error) {
    console.error('Error general al consultar vistas:', error);
    return NextResponse.json({
      views: 0,
      source: 'error'
    });
  }
}
