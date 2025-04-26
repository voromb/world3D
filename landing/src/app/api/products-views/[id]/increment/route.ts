// src/app/api/products-views/[id]/increment/route.ts

import { NextRequest, NextResponse } from 'next/server';

// Objeto global para simular almacenamiento de vistas cuando Strapi no está configurado
// Como este objeto se mantiene en memoria mientras el servidor esté en ejecución
// nos permite simular un contador persistente entre solicitudes
const simulatedViews: Record<string, number> = 
  (global as any).__simulatedViews || {};

// Objeto para contar las llamadas y solo incrementar en las llamadas pares
const callCounter: Record<string, number> = 
  (global as any).__callCounter || {};

// Si no existen, los inicializamos en el objeto global para compartirlos
if (!(global as any).__simulatedViews) {
  (global as any).__simulatedViews = simulatedViews;
}

if (!(global as any).__callCounter) {
  (global as any).__callCounter = callCounter;
}

export async function POST(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Acceder a los parámetros de forma asíncrona
    const params = await Promise.resolve(context.params);
    
    if (!params || !params.id) {
      // Devolver una respuesta simulada incluso en caso de error
      return NextResponse.json({
        views: 1,
        message: 'Vista simulada (ID no proporcionado)'
      });
    }
    
    // Obtener el ID del producto
    const productId = params.id;
    
    // Usar las variables de entorno
    const strapiBaseUrl = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:1337';
    
    console.log(`Incrementando vistas para el producto ${productId}`);
    
    // Inicializar el contador simulado si no existe
    if (!simulatedViews[productId]) {
      simulatedViews[productId] = 0;
    }
    
    // Inicializamos el contador de llamadas si no existe
    if (!callCounter[productId]) {
      callCounter[productId] = 0;
    }
    
    // Incrementamos el contador de llamadas
    callCounter[productId]++;
    
    // Solo incrementamos el contador real en las llamadas pares
    // Así, cada visita real (dos llamadas) incrementa el contador en 1
    if (callCounter[productId] % 2 === 0) {
      simulatedViews[productId]++;
    }
    
    console.log(`Llamada #${callCounter[productId]} para producto ${productId}, el contador es ${simulatedViews[productId]}`);
    
    // Guardar el valor actual para devolverlo en la respuesta
    const currentViews = simulatedViews[productId];
    
    console.log(`Contador simulado actual para producto ${productId}:`, simulatedViews[productId]);
    
    try {
      // Intentamos actualizar el contador de vistas en Strapi
      const payload = {
        data: {
          views: {
            increment: 1  // Usamos la función increment de Strapi
          }
        }
      };
      
      console.log('Enviando payload:', JSON.stringify(payload));
      
      const strapiUrl = `${strapiBaseUrl}/api/products/${productId}`;
      const response = await fetch(strapiUrl, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      });
      
      if (response.ok) {
        // Si la actualización fue exitosa, devolvemos los datos actualizados
        const data = await response.json();
        const updatedViews = data.data?.attributes?.views || currentViews;
        
        return NextResponse.json({
          views: updatedViews,
          message: 'Vistas incrementadas correctamente'
        });
      } else {
        // Si hay un error, simplemente devolvemos el contador simulado
        console.log('Error al actualizar vistas en Strapi, devolviendo contador simulado');
        return NextResponse.json({
          views: currentViews,
          message: 'Vistas simuladas (usando contador en memoria)'
        });
      }
    } catch (error) {
      // En caso de cualquier error, devolvemos el contador simulado
      console.error('Error al incrementar vistas:', error);
      return NextResponse.json({
        views: currentViews,
        message: 'Vistas simuladas (usando contador en memoria)'
      });
    }
  } catch (error) {
    // Error general
    console.error('Error general:', error);
    return NextResponse.json({
      views: 1,
      message: 'Vistas simuladas (error interno)'
    });
  }
}
