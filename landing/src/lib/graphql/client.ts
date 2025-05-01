// src/lib/graphql/client.ts
import { request } from "graphql-request";
import { ApolloClient, InMemoryCache, HttpLink, DocumentNode } from "@apollo/client";

// Detectar si estamos en un entorno de navegador o de servidor
const isBrowser = typeof window !== "undefined";

// URL del servidor GraphQL de Strapi basada en variables de entorno
// En el navegador, hacemos las peticiones a través de nuestra API interna para evitar problemas de CORS
export const STRAPI_GRAPHQL_URL = isBrowser
  ? "/api/graphql/proxy" // URL relativa para peticiones desde el navegador
  : process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL ||
    "http://localhost:1337/graphql"; // URL completa para el servidor

// URL absoluta completa para el servidor, usada para peticiones directas
export const FULL_STRAPI_GRAPHQL_URL = isBrowser
  ? new URL("/api/graphql/proxy", window.location.origin).toString() // URL absoluta para navegador
  : process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL || "http://localhost:1337/graphql"; // URL para servidor

// Función para crear un cliente Apollo (para compatibilidad con componentes existentes)
export function createApolloClient() {
  return new ApolloClient({
    ssrMode: !isBrowser,
    link: new HttpLink({
      uri: STRAPI_GRAPHQL_URL,
      credentials: 'same-origin',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Apollo-Require-Preflight": "true",
        "X-Request-ID": `${Date.now()}-${Math.random()}`,
      }
    }),
    cache: new InMemoryCache(),
  });
}

console.log(
  `GraphQL Client inicializado en entorno: ${
    isBrowser ? "Navegador" : "Servidor"
  } con URL: ${STRAPI_GRAPHQL_URL}`
);

// Función para obtener las cabeceras de la petición, incluyendo autorización si está disponible
function getRequestHeaders(token?: string) {
  return {
    "Apollo-Require-Preflight": "true",
    "Content-Type": "application/json",
    // Añadimos un ID único de petición para evitar cachés y facilitar depuración
    "X-Request-ID": isBrowser
      ? `browser-${Date.now()}-${Math.random()}`
      : `server-${Date.now()}-${Math.random()}`,
    // Si hay un token JWT disponible, lo incluimos en las cabeceras
    ...(token ? { 'Authorization': `Bearer ${token}` } : {})
  };
}

// Interfaces para tipos de respuesta GraphQL
export interface ProductAttribute {
  slug?: string;
  productName?: string;
  views?: number;
  averageRating?: number;
  totalRatings?: number;
}

export interface ProductData {
  id: string;
  documentId?: string;
  attributes: ProductAttribute;
}

export interface ProductsResponse {
  products?: ProductData[] | {
    data?: ProductData[];
  };
}

export interface ProductResponse {
  product?: ProductData | {
    data?: ProductData;
  };
}

export interface RatingsResponse {
  productRatings?: Array<{ documentId: string; rating: number }> | {
    data?: Array<{
      id: string;
      attributes: {
        rating: number;
      };
    }>;
  };
}

export interface CreateRatingResponse {
  createProductRating?: {
    documentId: string;
    rating: number;
  } | {
    data?: {
      id: string;
      attributes: {
        rating: number;
      };
    };
  };
}

export interface UpdateProductResponse {
  updateProduct?: {
    documentId: string;
    views?: number;
    averageRating?: number;
    totalRatings?: number;
  } | {
    data?: {
      id: string;
      attributes: {
        views?: number;
        averageRating?: number;
        totalRatings?: number;
      };
    };
  };
}

// Función auxiliar para esperar un tiempo especificado
const wait = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

/**
 * Realiza una petición con reintentos y backoff exponencial
 * @param fn Función que realiza la petición y devuelve una promesa
 * @param retries Número de reintentos
 * @param backoffMs Tiempo inicial de espera entre reintentos (ms)
 * @param maxBackoffMs Tiempo máximo de espera entre reintentos (ms)
 */
async function withRetry<T>(
  fn: () => Promise<T>, 
  retries = 3, 
  backoffMs = 300,
  maxBackoffMs = 5000
): Promise<T> {
  try {
    return await fn();
  } catch (error) {
    if (retries <= 0) throw error;
    
    // Calcular tiempo de espera con jitter para evitar tormentas de peticiones
    const jitter = Math.random() * 0.3 + 0.85; // 0.85-1.15 factor de aleatoriedad
    const waitTime = Math.min(backoffMs * jitter, maxBackoffMs);
    
    console.log(`Reintentando petición en ${Math.round(waitTime)}ms... (${retries} intentos restantes)`);
    await wait(waitTime);
    
    return withRetry(fn, retries - 1, backoffMs * 2, maxBackoffMs);
  }
}

// Cliente GraphQL mejorado para hacer peticiones a Strapi con mejor manejo de errores
export async function graphqlRequest<T = any>(
  query: DocumentNode,
  variables: any = {},
  token?: string
): Promise<T> {
  console.log('GraphQL Request Variables:', JSON.stringify(variables, null, 2));
  console.log('GraphQL Query:', query.loc?.source.body);
  
  // Determinar si es una mutación
  const isMutation = query.loc?.source.body.includes("mutation");
  console.log(`Tipo de operación: ${isMutation ? "Mutación" : "Consulta"}`);
  
  // Lista de URLs a intentar, comenzando con la preferida
  const urlsToTry = isBrowser ? 
    [
      STRAPI_GRAPHQL_URL,              // URL relativa preferida para navegador
      FULL_STRAPI_GRAPHQL_URL,         // URL completa alternativa
      "http://localhost:1337/graphql"  // URL directa como último recurso
    ] : [
      FULL_STRAPI_GRAPHQL_URL,         // URL completa para servidor
      "http://localhost:1337/graphql"   // URL directa como respaldo
    ];
  
  let lastError: any = null;
  
  // Número de reintentos (más para mutaciones ya que son críticas)
  const maxRetries = isMutation ? 3 : 2;
  
  // Intentar cada URL en secuencia
  for (const url of urlsToTry) {
    try {
      // Usar reintentos con backoff exponencial para cada URL
      return await withRetry(async () => {
        console.log('Intentando petición GraphQL a:', url);
        console.log('Headers:', JSON.stringify(getRequestHeaders(token), null, 2));
        
        if (isMutation && isBrowser) {
          console.log("Enviando mutación directamente usando fetch");
          
          const headers = getRequestHeaders(token);
          console.log("Cabeceras de autenticación:", token ? "Token JWT presente" : "Sin token JWT");
          
          // Asegurarnos de que tenemos una URL válida para fetch
          const fetchUrl = url.startsWith('http') ? url : 
                          (url.startsWith('/') ? window.location.origin + url : window.location.origin + '/' + url);
          
          // Utilizar AbortController para establecer timeout
          const controller = new AbortController();
          const timeoutId = setTimeout(() => controller.abort(), 15000); // 15 segundos timeout
          
          try {
            const response = await fetch(fetchUrl, {
              method: 'POST',
              headers: headers,
              body: JSON.stringify({
                query: query.loc?.source.body,
                variables: variables
              }),
              cache: 'no-store' as RequestCache,
              signal: controller.signal
            });
            
            clearTimeout(timeoutId); // Limpiar el timeout si la petición se completa
            
            if (!response.ok) {
              throw new Error(`Error en la respuesta HTTP: ${response.status} ${response.statusText}`);
            }
            
            const data = await response.json();
            console.log("Respuesta de mutación:", JSON.stringify(data, null, 2));
            
            if (data.errors) {
              throw new Error(`Error en mutación GraphQL: ${JSON.stringify(data.errors)}`);
            }
            
            return data as T;
          } catch (fetchError) {
            clearTimeout(timeoutId); // Limpiar el timeout en caso de error
            throw fetchError; // Re-lanzar el error para que sea manejado por withRetry
          }
        } else {
          // Para consultas normales con graphql-request
          // Si es una URL relativa en el navegador, convertirla a absoluta
          const requestUrl = !url.startsWith('http') && isBrowser
            ? `${window.location.origin}${url.startsWith('/') ? '' : '/'}${url}`
            : url;
          
          try {
            const result = await request<T>(
              requestUrl, 
              query, 
              variables, 
              getRequestHeaders(token)
            );
            console.log('Respuesta GraphQL exitosa');
            return result;
          } catch (requestError: any) {
            // Verificar si el error es por timeout o problemas de red
            if (
              requestError.message?.includes('Failed to fetch') ||
              requestError.message?.includes('Network request failed') ||
              requestError.message?.includes('timeout')
            ) {
              console.error('Error de red/timeout en consulta GraphQL:', requestError.message);
              throw requestError; // Propagar el error para reintentar
            }
            
            // Si es un error de GraphQL (ej. validación), no reintentar
            if (requestError.response?.errors) {
              console.error('Error GraphQL (no se reintenta):', requestError.response.errors);
              throw requestError;
            }
            
            // Otros errores, reintentar
            throw requestError;
          }
        }
      }, maxRetries, 300, 5000);
    } catch (error: any) {
      console.error(`Error en todos los intentos a ${url}:`, error);
      if (error.response) {
        console.error('Detalles de error:', JSON.stringify(error.response, null, 2));
      }
      lastError = error;
      // Continuar con la siguiente URL
    }
  }
  
  // Si llegamos aquí, todas las URLs fallaron
  console.error('Todos los intentos de conexión GraphQL fallaron');
  throw lastError || new Error('Falló la conexión con la API GraphQL');
}