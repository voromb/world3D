import { gql } from 'graphql-request';

// Consultas para productos - Usando sintaxis más simple y compatible
export const FIND_PRODUCT_BY_SLUG = gql`
  query FindProductBySlug($slug: String!) {
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

export const FIND_PRODUCT_BY_ID = gql`
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

export const GET_ALL_PRODUCTS = gql`
  query GetAllProducts {
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

// Consulta para obtener todas las valoraciones de un producto
export const GET_PRODUCT_RATINGS = gql`
  query GetProductRatings($productId: ID!) {
    productRatings(filters: {product: {id: {eq: $productId}}}) {
      data {
        id
        attributes {
          rating
        }
      }
    }
  }
`;

// Mutaciones para productos
export const UPDATE_PRODUCT_VIEWS = gql`
  mutation UpdateProductViews($id: ID!, $views: Int!) {
    updateProduct(id: $id, data: {views: $views}) {
      data {
        id
        attributes {
          slug
          productName
          views
        }
      }
    }
  }
`;

export const CREATE_RATING = gql`
  mutation CreateRating($rating: Int!, $product: ID!) {
    createProductRating(data: {rating: $rating, product: $product}) {
      data {
        id
        attributes {
          rating
          product {
            data {
              id
            }
          }
        }
      }
    }
  }
`;

export const UPDATE_PRODUCT_RATING = gql`
  mutation UpdateProductRating($id: ID!, $averageRating: Float!, $totalRatings: Int!) {
    updateProduct(id: $id, data: {averageRating: $averageRating, totalRatings: $totalRatings}) {
      data {
        id
        attributes {
          averageRating
          totalRatings
        }
      }
    }
  }
`;
