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

// Función auxiliar para buscar un producto por slug en lugar de por ID
async function findProductBySlugOrId(slugOrId: string): Promise<{ id: number, slug: string } | null> {
  try {
    const strapiBaseUrl = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:1337';
    
    // Primero intentamos buscar por ID
    const idResponse = await fetch(`${strapiBaseUrl}/api/products/${slugOrId}?fields[0]=id&fields[1]=slug`);
    
    if (idResponse.ok) {
      const data = await idResponse.json();
      return { 
        id: data.data.id, 
        slug: data.data.attributes?.slug || slugOrId 
      };
    }
    
    // Si no funciona, intentamos buscar por slug
    const slugResponse = await fetch(
      `${strapiBaseUrl}/api/products?filters[slug][$eq]=${slugOrId}&fields[0]=id&fields[1]=slug`
    );
    
    if (slugResponse.ok) {
      const data = await slugResponse.json();
      if (data.data && data.data.length > 0) {
        return { 
          id: data.data[0].id, 
          slug: data.data[0].attributes?.slug || slugOrId 
        };
      }
    }
    
    return null;
  } catch (error) {
    console.error('Error al buscar producto:', error);
    return null;
  }
}

export async function POST(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Acceder a los parámetros de forma asíncrona (requerido en Next.js 14+)
    const params = await Promise.resolve(context.params);
    
    if (!params || !params.id) {
      // Devolver una respuesta simulada incluso en caso de error
      return NextResponse.json({
        views: 1,
        message: 'Vista simulada (ID no proporcionado)'
      });
    }
    
    // Obtener el ID o slug del producto
    const productIdOrSlug = params.id;
    
    // Usar las variables de entorno
    const strapiBaseUrl = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:1337';
    
    console.log(`Incrementando vistas para el producto ${productIdOrSlug}`);
    
    // Inicializar el contador simulado si no existe
    if (!simulatedViews[productIdOrSlug]) {
      simulatedViews[productIdOrSlug] = 0;
    }
    
    // Inicializamos el contador de llamadas si no existe
    if (!callCounter[productIdOrSlug]) {
      callCounter[productIdOrSlug] = 0;
    }
    
    // Incrementamos el contador de llamadas
    callCounter[productIdOrSlug]++;
    
    // Solo incrementamos el contador real en las llamadas pares
    // Así, cada visita real (dos llamadas) incrementa el contador en 1
    if (callCounter[productIdOrSlug] % 2 === 0) {
      simulatedViews[productIdOrSlug]++;
    }
    
    console.log(`Llamada #${callCounter[productIdOrSlug]} para producto ${productIdOrSlug}, contador: ${simulatedViews[productIdOrSlug]}`);
    
    // Guardar el valor actual para devolverlo en la respuesta (caso fallido)
    const currentViews = simulatedViews[productIdOrSlug];
    
    // Buscar el producto real en Strapi (por ID o por slug)
    const product = await findProductBySlugOrId(productIdOrSlug);
    
    if (!product) {
      console.log(`Producto ${productIdOrSlug} no encontrado en Strapi, usando contador simulado`);
      return NextResponse.json({
        views: currentViews,
        message: 'Vistas simuladas (producto no encontrado)'
      });
    }
    
    // Si encontramos el producto, intentamos actualizar las vistas en Strapi
    console.log(`Producto encontrado en Strapi con ID real: ${product.id}`);
    
    // Solo actualizamos en Strapi en las llamadas pares (para evitar duplicados)
    if (callCounter[productIdOrSlug] % 2 === 0) {
      try {
        const payload = {
          data: {
            views: {
              increment: 1
            }
          }
        };
        
        console.log(`Enviando payload a Strapi para producto ID ${product.id}:`, JSON.stringify(payload));
        
        const strapiUrl = `${strapiBaseUrl}/api/products/${product.id}`;
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
          
          console.log(`¡Éxito! Vistas actualizadas en Strapi para producto ${product.id} a ${updatedViews}`);
          
          return NextResponse.json({
            views: updatedViews,
            message: 'Vistas incrementadas correctamente en la base de datos'
          });
        } else {
          // Error al actualizar en Strapi
          console.log(`Error al actualizar vistas en Strapi (${response.status}), usando contador simulado`);
          const errorText = await response.text();
          try {
            const errorJson = JSON.parse(errorText);
            console.error('Error detallado:', JSON.stringify(errorJson, null, 2));
          } catch {
            console.error('Error en texto plano:', errorText);
          }
          
          return NextResponse.json({
            views: currentViews,
            message: 'Vistas simuladas (error al actualizar en Strapi)'
          });
        }
      } catch (error) {
        // Error al intentar actualizar en Strapi
        console.error('Error al comunicarse con Strapi:', error);
        return NextResponse.json({
          views: currentViews,
          message: 'Vistas simuladas (error de comunicación con Strapi)'
        });
      }
    } else {
      // En llamadas impares, simplemente devolvemos el contador simulado actual
      return NextResponse.json({
        views: currentViews,
        message: 'Contador intermedio (esperando segunda llamada)'
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
