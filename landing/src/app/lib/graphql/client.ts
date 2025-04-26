import { request } from 'graphql-request';

// URL del servidor GraphQL de Strapi
const STRAPI_GRAPHQL_URL = 'http://localhost:1337/graphql';

// Añadir cabeceras para evitar errores CSRF
const requestHeaders = {
  'Apollo-Require-Preflight': 'true'
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
  attributes: ProductAttribute;
}

export interface ProductsResponse {
  products?: {
    data?: ProductData[];
  };
}

export interface ProductResponse {
  product?: {
    data?: ProductData;
  };
}

export interface RatingsResponse {
  productRatings?: {
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

// Cliente GraphQL básico para hacer peticiones a Strapi
export async function graphqlRequest<T = any>(query: string, variables = {}): Promise<T> {
  try {
    // Usar request con encabezados para evitar errores CSRF
    return await request(
      STRAPI_GRAPHQL_URL,
      query,
      variables,
      requestHeaders
    ) as T;
  } catch (error) {
    console.error('Error en la petición GraphQL:', error);
    throw error;
  }
}
