// src/app/api/graphql/proxy/route.ts
import { NextRequest, NextResponse } from 'next/server';

/**
 * Endpoint de proxy para redirigir peticiones GraphQL desde el cliente al servidor de Strapi.
 * Evita problemas de CORS cuando se hacen peticiones directas desde el navegador.
 */
export async function POST(request: NextRequest) {
  try {
    // Obtener el cuerpo de la petición que contiene la consulta GraphQL
    const body = await request.json();
    
    // URL completa del servidor GraphQL de Strapi
    const strapiGraphQLUrl = process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL || 'http://localhost:1337/graphql';
    console.log(`Proxy GraphQL: reenviando petición a ${strapiGraphQLUrl}`);
    console.log('Contenido:', JSON.stringify(body, null, 2));
    
    // Enviar la petición al servidor Strapi
    const strapiResponse = await fetch(strapiGraphQLUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // Podemos añadir cabeceras de autorización aquí si es necesario
        // 'Authorization': `Bearer ${process.env.STRAPI_TOKEN}`
      },
      body: JSON.stringify(body)
    });

    // Obtener la respuesta como JSON
    const data = await strapiResponse.json();
    
    console.log('Proxy GraphQL: respuesta recibida');
    
    // Devolver la respuesta al cliente
    return NextResponse.json(data, {
      status: strapiResponse.status,
      statusText: strapiResponse.statusText
    });
  } catch (error) {
    console.error('Error en el proxy GraphQL:', error);
    return NextResponse.json(
      { 
        errors: [{ 
          message: 'Error en el servidor proxy de GraphQL',
          extensions: { 
            error: error instanceof Error ? error.message : 'Error desconocido'
          }
        }]
      },
      { status: 500 }
    );
  }
}
