// src/lib/graphql/product-crud.ts
import { gql } from '@apollo/client';

// consulta mínima para garantizar la compatibilidad con Strapi v5
export const GET_PRODUCTS_FOR_DASHBOARD = `
  query {
    products {
      documentId
      productName
      description
      price
      active
      owner_id
      slug
      isFeatured
      weight
      dimensions
      dateManufactured
      remaininWarranty
      State
      cityName
      provinceName
      countryName
      directionName
      latitud
      longitud
      createBy
      createdAt
      updatedAt
    }
  }
`;

// Mutación simplificada para crear productos (con campos mínimos requeridos)
export const CREATE_PRODUCT = `
  mutation CreateProduct($data: ProductInput!) {
    createProduct(data: $data) {
      documentId
      productName
      slug
      description
      price
      active
      isFeatured
      weight
      dimensions
      owner_id
      createdAt
    }
  }
`;

// NOTA: El DELETE_PRODUCT está declarado más abajo

// Versión optimizada para Strapi v5 con los campos esenciales
export const SIMPLIFIED_CREATE_PRODUCT = `
  mutation CreateProduct($data: ProductInput!) {
    createProduct(data: $data) {
      documentId
      productName
      price
      slug
      description
      active
      owner_id
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
      isFeatured
      weight
      dimensions
      dateManufactured
      remaininWarranty
      State
      cityName
      provinceName
      countryName
      directionName
      latitud
      longitud
      createBy
      owner_id
      createdAt
      updatedAt
      images {
        documentId
        url
      }
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
      isFeatured
      weight
      dimensions
      dateManufactured
      remaininWarranty
      State
      cityName
      provinceName
      countryName
      directionName
      latitud
      longitud
      views
      averageRating
      totalRatings
      createdAt
      updatedAt
      publishedAt
      createBy
      owner_id
      images {
        documentId
        url
        formats
      }
      categories {
        documentId
        name
      }
      shipping_types {
        documentId
        name
      }
      brands {
        documentId
        name
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
  updatedAt?: string;
  publishedAt?: string;
  userId?: string;
  createBy?: string;
  // Campo simple para filtrar por usuario
  owner_id?: string;
  // Relaciones
  users_permissions_users?: string[] | {id: string; username?: string}[];
  categories?: any[];
  shipping_types?: any[];
  brands?: any[];
  product_ratings?: any[];
  // Campos calculados
  averageRating?: number;
  totalRatings?: number;
  // Archivos
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
  createBy?: string;
  // Relaciones
  userId?: string;
  owner_id?: string; // Campo simple para filtrar por usuario
  users_permissions_users?: string[];
  categories?: string[];
  shipping_types?: string[];
  brands?: string[];
}
