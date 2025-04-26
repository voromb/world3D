//src/app/lib/graphql/queries.ts

import { gql } from 'graphql-request';

// Consultas para productos - Esquema correcto confirmado
export const FIND_PRODUCT_BY_SLUG = gql`
  query FindProductBySlug($slug: String!) {
    products(filters: {slug: {eq: $slug}}, pagination: { limit: 1 }) {
      documentId
      slug
      productName
      views
      averageRating
      totalRatings
    }
  }
`;

export const FIND_PRODUCT_BY_ID = gql`
  query GetProduct($documentId: ID!) {
    products(filters: {documentId: {eq: $documentId}}, pagination: { limit: 1 }) {
      documentId
      productName
      views
      averageRating
      totalRatings
      slug
    }
  }
`;

export const GET_ALL_PRODUCTS = gql`
  query GetAllProducts {
    products(pagination: { limit: 100 }) {
      documentId
      slug
      productName
    }
  }
`;

// Consulta para obtener todas las valoraciones de un producto
export const GET_PRODUCT_RATINGS = gql`
  query GetProductRatings($productId: ID!) {
    productRatings(filters: {products: {documentId: {eq: $productId}}}) {
      documentId
      rating
    }
  }
`;

// Mutaciones para productos
export const UPDATE_PRODUCT_VIEWS = gql`
  mutation UpdateProductViews($documentId: ID!, $views: Int!) {
    updateProduct(
      documentId: $documentId,
      data: {
        views: $views
      }
    ) {
      documentId
      views
    }
  }
`;

export const CREATE_RATING = gql`
  mutation CreateRating($rating: Int!, $productId: ID!) {
    createProductRating(
      data: {
        rating: $rating
        products: [$productId]
      }
    ) {
      documentId
      rating
      products {
        documentId
        productName
      }
    }
  }
`;

export const UPDATE_PRODUCT_RATING = gql`
  mutation UpdateProductRating($documentId: ID!, $averageRating: Float!, $totalRatings: Int!) {
    updateProduct(
      documentId: $documentId,
      data: {
        averageRating: $averageRating
        totalRatings: $totalRatings
      }
    ) {
      documentId
      productName
      averageRating
      totalRatings
    }
  }
`;