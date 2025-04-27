//src/app/lib/graphql/queries.ts

import { gql } from '@apollo/client';

// Consultas para productos - Estructura correcta para Strapi v5
export const FIND_PRODUCT_BY_SLUG = gql`
query FindProductBySlug($slug: String!) {
  products(filters: {slug: {eq: $slug}}, pagination: {limit: 1}) {
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
  query FindProductById($id: ID!) {
    products(filters: {id: {eq: $id}}, pagination: { limit: 1 }) {
      documentId
      productName
      views
      averageRating
      totalRatings
      slug
    }
  }
`;

export const FIND_PRODUCT_BY_DOCUMENT_ID = gql`
  query FindProductByDocumentId($documentId: String!) {
    products(filters: {documentId: {eq: $documentId}}) {
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
    productRatings(filters: {product: {documentId: {eq: $productId}}}) {
      data {
        id
        attributes {
          rating
          createdAt
          product {
            data {
              id
              attributes {
                documentId
                productName
              }
            }
          }
        }
      }
    }
  }
`;

// Mutaciones para productos
export const UPDATE_PRODUCT_VIEWS = gql`
  mutation UpdateProductViews($documentId: ID!, $views: Int!) {
    updateProduct(
      documentId: $documentId
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
      rating
    }
  }
`;

export const UPDATE_PRODUCT_RATING = gql`
  mutation UpdateProductRating($documentId: ID!, $averageRating: Float!, $totalRatings: Int!) {
    updateProduct(
      documentId: $documentId
      data: {
        averageRating: $averageRating
        totalRatings: $totalRatings
      }
    ) {
      documentId
      averageRating
      totalRatings
    }
  }
`;

// Consultas y mutaciones para productos favoritos
export const GET_USER_FAVORITES = gql`
  query GetUserFavorites {
    favorites(pagination: {limit: 100}) {
      documentId
      products {
        documentId
        slug
        productName
        description
        price
        images {
          url
          alternativeText
        }
        averageRating
      }
    }
  }
`;

export const ADD_TO_FAVORITE = gql`
  mutation AddToFavorite($userId: ID!, $productId: ID!) {
    createFavorite(
      data: {
        users_permissions_user: $userId
        products: [$productId]
      }
    ) {
      documentId
    }
  }
`;

export const REMOVE_FROM_FAVORITE = gql`
  mutation RemoveFromFavorite($documentId: ID!) {
    deleteFavorite(
      documentId: $documentId
    ) {
      documentId
    }
  }
`;

export const CHECK_PRODUCT_IN_FAVORITES = gql`
  query CheckProductInFavorites {
    favorites(pagination: {limit: 100}) {
      documentId
      products {
        documentId
      }
    }
  }
`;