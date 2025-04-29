// src/lib/graphql/product-crud.ts
import { gql } from '@apollo/client';

// consulta básica para obtener todos los productos
export const GET_PRODUCTS_FOR_DASHBOARD = `
  query {
    products {
      documentId
      productName
      slug
      description
      price
      active
      createdAt
      updatedAt
      publishedAt
      owner_id
      images {
        documentId
        url
        formats
      }
    }
  }
`;

// crear un producto nuevo
export const CREATE_PRODUCT = `
  mutation CreateProduct($data: ProductInput!) {
    createProduct(data: $data) {
      documentId
      productName
      slug
      description
      price
      active
      createdAt
    }
  }
`;

// actualizar un producto existente
export const UPDATE_PRODUCT = `
  mutation UpdateProduct($documentId: ID!, $data: ProductInput!) {
    updateProduct(documentId: $documentId, data: $data) {
      documentId
      productName
      slug
      description
      price
      active
      createdAt
    }
  }
`;

// eliminar un producto
export const DELETE_PRODUCT = `
  mutation DeleteProduct($documentId: ID!) {
    deleteProduct(documentId: $documentId) {
      documentId
    }
  }
`;

// obtener un producto especifico por ID
export const GET_PRODUCT_BY_ID = `
  query GetProductById($documentId: ID!) {
    product(documentId: $documentId) {
      documentId
      productName
      slug
      description
      price
      active
      createdAt
      images {
        documentId
        url
        formats
      }
    }
  }
`;

// generar un slug a partir del nombre del producto
export function generateSlug(productName: string): string {
  return productName
    .toLowerCase()
    .replace(/[^\w\s]/gi, '')  // quitar caracteres especiales
    .replace(/\s+/g, '-')      // cambiar espacios por guiones
    .replace(/-+/g, '-')       // evitar guiones multiples
    .replace(/^-|-$/g, '');    // quitar guiones al inicio y final
}

// interfaz para el modelo de producto
export interface Product {
  documentId?: string;
  id?: string;
  productName: string;
  slug: string;
  description: string;
  price: number;
  views?: number;
  active?: boolean;
  isFeatured?: boolean;
  weight?: number;
  dimensions?: string;
  dateManufactured?: string;
  remaininWarranty?: string;
  State?: string;
  cityName?: string;
  provinceName?: string;
  countryName?: string;
  directionName?: string;
  latitud?: number;
  longitud?: number;
  createdAt?: string;
  userId?: string;
  createBy?: string;
  // Campo simple para filtrar por usuario
  owner_id?: string;
  // Mantenemos el campo pero no lo usaremos en consultas
  users_permissions_users?: string | {id: string; username?: string};
  hasImages?: boolean;
  images?: any[];
}

// interfaz para los datos de entrada de producto
export interface ProductInput {
  productName?: string;
  slug?: string;
  description?: string;
  price?: number;
  active?: boolean;
  isFeatured?: boolean;
  weight?: number;
  dimensions?: string;
  dateManufactured?: string;
  remaininWarranty?: string;
  State?: string;
  cityName?: string;
  provinceName?: string;
  countryName?: string;
  directionName?: string;
  latitud?: number;
  longitud?: number;
  userId?: string;
  owner_id?: string; // Campo simple para filtrar por usuario
  users_permissions_users?: string[];
}
