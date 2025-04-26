// Cliente GraphQL para hacer peticiones a Strapi
import { request, gql } from 'graphql-request';

// URL del servidor GraphQL de Strapi
const STRAPI_GRAPHQL_URL = 'http://localhost:1337/graphql';

// Añadir cabeceras para evitar errores CSRF
const requestHeaders = {
  'Apollo-Require-Preflight': 'true'
};

// Interfaces para tipos de respuesta de GraphQL
interface ProductAttribute {
  slug?: string;
  productName?: string;
  views?: number;
  averageRating?: number;
  totalRatings?: number;
}

interface ProductData {
  id: string;
  attributes: ProductAttribute;
}

interface ProductsResponse {
  products?: {
    data?: ProductData[];
  };
}

interface ProductResponse {
  product?: {
    data?: ProductData;
  };
}

interface DiagnosticResponse {
  products?: {
    data?: Array<{
      id: string;
      attributes: {
        slug?: string;
        productName?: string;
      };
    }>;
  };
}

// Cliente GraphQL básico
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

// Interfaces para tipos de respuesta GraphQL
interface ProductAttribute {
  slug?: string;
  productName?: string;
  views?: number;
  averageRating?: number;
  totalRatings?: number;
}

interface ProductData {
  id: string;
  attributes: ProductAttribute;
}

interface ProductsResponse {
  products?: {
    data?: ProductData[];
  };
}

interface ProductResponse {
  product?: {
    data?: ProductData;
  };
}

interface DiagnosticResponse {
  products?: {
    data?: Array<{
      id: string;
      attributes: {
        slug?: string;
        productName?: string;
      };
    }>;
  };
}

// Encuentra un producto por slug o ID
export async function findProductBySlugOrId(slugOrId: string) {
  // Primero intenta buscar por slug (que es lo más probable con i18n)
  const findBySlugQuery = gql`
    query GetProductBySlug($slug: String!) {
      products(filters: {slug: {eq: $slug}}) {
        data {
          id
          attributes {
            slug
            productName
            views
            averageRating
            totalRatings
          }
        }
      }
    }
  `;

  // Consulta para buscar un producto por ID
  const findByIdQuery = gql`
    query GetProductById($id: ID!) {
      product(id: $id) {
        data {
          id
          attributes {
            slug
            productName
            views
            averageRating
            totalRatings
          }
        }
      }
    }
  `;

  try {
    console.log(`GraphQL: Buscando producto por slug "${slugOrId}"...`);
    
    // Intenta primero por slug
    const slugResult = await graphqlRequest<ProductsResponse>(findBySlugQuery, { slug: slugOrId });
    console.log('GraphQL respuesta de búsqueda por slug:', JSON.stringify(slugResult, null, 2));
    
    if (slugResult?.products?.data && slugResult.products.data.length > 0) {
      console.log('Producto encontrado por slug en GraphQL:', slugResult.products.data[0]);
      return {
        id: slugResult.products.data[0].id,
        ...slugResult.products.data[0].attributes
      };
    }

    // Si no funciona, intenta por ID (si es un número)
    if (!isNaN(parseInt(slugOrId))) {
      console.log(`GraphQL: Intentando buscar por ID "${slugOrId}"...`);
      
      const idResult = await graphqlRequest<ProductResponse>(findByIdQuery, { id: slugOrId });
      console.log('GraphQL respuesta de búsqueda por ID:', JSON.stringify(idResult, null, 2));
      
      if (idResult?.product?.data) {
        console.log('Producto encontrado por ID en GraphQL:', idResult.product.data);
        return {
          id: idResult.product.data.id,
          ...idResult.product.data.attributes
        };
      }
    }
    
    // Prueba con una consulta más simple para diagnosticar problemas
    console.log('GraphQL: Realizando consulta de diagnóstico para ver todos los productos...');
    const diagnosticQuery = gql`
      query DiagnosticQuery {
        products {
          data {
            id
            attributes {
              slug
              productName
            }
          }
        }
      }
    `;
    
    const diagResult = await graphqlRequest<DiagnosticResponse>(diagnosticQuery);
    console.log('GraphQL productos disponibles:', 
      diagResult?.products?.data ? 
      diagResult.products.data.map((p: any) => `${p.id}: ${p.attributes.slug || 'sin slug'}`) : 
      'Ninguno encontrado');
    

    return null; // No se encontró el producto
  } catch (error) {
    console.error('Error al buscar producto por GraphQL:', error);
    return null;
  }
}
