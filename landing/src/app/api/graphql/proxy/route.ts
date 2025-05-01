// src/app/api/graphql/proxy/route.ts
import { NextRequest, NextResponse } from 'next/server';

/**
 * Realiza un reintento de una petición fetch con un retraso exponencial
 * @param url URL a la que hacer la petición
 * @param options Opciones para fetch
 * @param retries Número de reintentos máximos
 * @param backoff Tiempo base de espera entre reintentos (ms)
 */
async function fetchWithRetry(
  url: string, 
  options: RequestInit, 
  retries = 3, 
  backoff = 300
): Promise<Response> {
  try {
    return await fetch(url, options);
  } catch (err) {
    if (retries <= 0) {
      throw err;
    }
    
    console.log(`Reintentando petición a ${url} en ${backoff}ms... (${retries} intentos restantes)`);
    
    // Esperar con backoff exponencial
    await new Promise(resolve => setTimeout(resolve, backoff));
    
    // Reintentar con tiempo de espera incrementado
    return fetchWithRetry(url, options, retries - 1, backoff * 2);
  }
}

/**
 * Endpoint de proxy para redirigir peticiones GraphQL desde el cliente al servidor de Strapi.
 * Evita problemas de CORS cuando se hacen peticiones directas desde el navegador.
 * Implementa reintentos automáticos para mejorar la fiabilidad.
 */
export async function POST(request: NextRequest) {
  try {
    // Obtener el cuerpo de la petición que contiene la consulta GraphQL
    const body = await request.json();
    
    // URL completa del servidor GraphQL de Strapi (intentar URL principal y fallback)
    const strapiGraphQLUrl = process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL || 'http://localhost:1337/graphql';
    console.log(`Proxy GraphQL: reenviando petición a ${strapiGraphQLUrl}`);
    
    // Determinar si es una mutación
    const isMutation = body.query?.toLowerCase().includes('mutation');
    const operationType = isMutation ? 'MUTACIÓN' : 'CONSULTA';
    console.log(`Proxy GraphQL: Tipo de operación: ${operationType}`);
    
    // Log condensado para reducir ruido en la consola
    console.log(`Proxy GraphQL: Enviando ${operationType} con variables:`, body.variables || {});
    
    // Obtener el token de autorización de la petición entrante, si existe
    const authHeader = request.headers.get('authorization');
    
    // Configurar las cabeceras para la petición a Strapi
    const headers: HeadersInit = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Request-ID': `proxy-${Date.now()}-${Math.random().toString(36).substring(2, 10)}`
    };
    
    // Si hay un token de autorización, lo reenviamos a Strapi
    if (authHeader) {
      headers['Authorization'] = authHeader;
    }
    
    // Configuración de la petición a Strapi
    const fetchOptions: RequestInit = {
      method: 'POST',
      headers,
      body: JSON.stringify(body),
      cache: 'no-store' as RequestCache,
      // Añadir timeout para evitar peticiones colgadas
      signal: AbortSignal.timeout(15000) // 15 segundos de timeout
    };
    
    // Número de reintentos basado en el tipo de operación
    // Las mutaciones son más sensibles, así que intentamos más veces
    const maxRetries = isMutation ? 4 : 3;
    
    try {
      // Enviar la petición al servidor Strapi con reintentos
      const strapiResponse = await fetchWithRetry(
        strapiGraphQLUrl, 
        fetchOptions, 
        maxRetries
      );

      // Obtener la respuesta como JSON
      const data = await strapiResponse.json();
      
      // Verificar si hay errores en la respuesta
      if (data.errors) {
        console.error('Proxy GraphQL: La respuesta contiene errores:', 
          data.errors.map((e: any) => ({ message: e.message, path: e.path })));
      } else {
        console.log('Proxy GraphQL: Respuesta exitosa');
      }
      
      // Devolver la respuesta al cliente
      return NextResponse.json(data, {
        status: strapiResponse.status,
        statusText: strapiResponse.statusText
      });
    } catch (fetchError) {
      // Capturar errores específicos de la petición fetch
      console.error(`Error al comunicarse con Strapi (${strapiGraphQLUrl}):`, fetchError);
      
      // Intentar URL alternativa si la primera falla
      // Esta lógica es importante porque a veces el proxy puede
      // intentar utilizar localhost cuando ejecuta en diferentes entornos
      const alternativeUrl = 'http://127.0.0.1:1337/graphql';
      
      if (strapiGraphQLUrl !== alternativeUrl) {
        console.log(`Intentando con URL alternativa: ${alternativeUrl}`);
        try {
          const alternativeResponse = await fetchWithRetry(
            alternativeUrl, 
            fetchOptions, 
            2 // Menos reintentos para la alternativa
          );
          
          const alternativeData = await alternativeResponse.json();
          console.log('Proxy GraphQL: Respuesta recibida de URL alternativa');
          
          return NextResponse.json(alternativeData, {
            status: alternativeResponse.status,
            statusText: alternativeResponse.statusText
          });
        } catch (altError) {
          console.error('Error con URL alternativa:', altError);
          throw fetchError; // Lanzar el error original para el manejo general
        }
      } else {
        throw fetchError;
      }
    }
  } catch (error) {
    // Capturar cualquier otro error y devolver una respuesta de error estructurada
    console.error('Error en el proxy GraphQL:', error);
    
    let errorMessage = 'Error en el servidor proxy de GraphQL';
    let errorDetails = 'Error desconocido';
    
    if (error instanceof Error) {
      errorMessage = `Error en la comunicación GraphQL: ${error.name}`;
      errorDetails = error.message;
      
      // Mensaje más amigable para errores comunes
      if (error.message.includes('fetch')) {
        errorMessage = 'No se pudo conectar al servidor de Strapi';
        errorDetails = 'Comprueba que el servidor esté ejecutándose y sea accesible';
      } else if (error.name === 'AbortError') {
        errorMessage = 'La petición excedió el tiempo máximo de espera';
        errorDetails = 'El servidor tardó demasiado en responder';
      }
    }
    
    return NextResponse.json(
      { 
        errors: [{ 
          message: errorMessage,
          extensions: { 
            error: errorDetails,
            timestamp: new Date().toISOString(),
            path: request.url
          }
        }]
      },
      { status: 500 }
    );
  }
}
