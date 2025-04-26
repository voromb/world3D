// src/lib/graphql/client.ts
import { request } from "graphql-request";
import { ApolloClient, InMemoryCache, HttpLink } from "@apollo/client";

// Detectar si estamos en un entorno de navegador o de servidor
const isBrowser = typeof window !== "undefined";

// URL del servidor GraphQL de Strapi basada en variables de entorno
// En el navegador, hacemos las peticiones a través de nuestra API interna para evitar problemas de CORS
const STRAPI_GRAPHQL_URL = isBrowser
  ? "/api/graphql/proxy" // URL relativa para peticiones desde el navegador
  : process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL ||
    "http://localhost:1337/graphql"; // URL completa para el servidor

// Función para crear un cliente Apollo (para compatibilidad con componentes existentes)
export function createApolloClient() {
  return new ApolloClient({
    ssrMode: !isBrowser,
    link: new HttpLink({
      uri: STRAPI_GRAPHQL_URL,
      credentials: 'same-origin',
      headers: {
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

// Cabeceras necesarias para la comunicación correcta con GraphQL
const requestHeaders = {
  "Apollo-Require-Preflight": "true",
  "Content-Type": "application/json",
  // Añadimos un ID único de petición para evitar cachés y facilitar depuración
  "X-Request-ID": isBrowser
    ? `browser-${Date.now()}-${Math.random()}`
    : `server-${Date.now()}-${Math.random()}`,
  // Si tu Strapi requiere autenticación para operaciones de escritura,
  // descomenta la siguiente línea
  // 'Authorization': `Bearer ${process.env.STRAPI_API_TOKEN}`
};

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

// Cliente GraphQL mejorado para hacer peticiones a Strapi con mejor manejo de errores
export async function graphqlRequest<T = any>(
  query: string,
  variables = {}
): Promise<T> {
  try {
    console.log(`Enviando consulta GraphQL a ${STRAPI_GRAPHQL_URL}`);
    console.log(
      "Tipo de operación: " +
        (query.includes("mutation") ? "Mutación" : "Consulta")
    );
    console.log("Variables:", JSON.stringify(variables, null, 2));

    // Usar request con encabezados para evitar errores CSRF
    const response = (await request(
      STRAPI_GRAPHQL_URL,
      query,
      variables,
      requestHeaders
    )) as T;

    console.log("Respuesta GraphQL exitosa");
    return response;
  } catch (error: any) {
    console.error("Error en la petición GraphQL:", error);

    // Registrar más detalles del error para facilitar la depuración
    if (error.response) {
      console.error(
        "Detalles del error GraphQL:",
        JSON.stringify(error.response, null, 2)
      );
    }

    throw error;
  }
}