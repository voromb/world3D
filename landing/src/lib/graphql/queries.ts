import { gql } from "@apollo/client";

// Consulta para obtener todas las marcas
export const GET_BRANDS = gql`
  query GetBrands {
    brands {
      data {
        id
        attributes {
          brandName
          slug
          mainimage {
            data {
              attributes {
                url
                formats
              }
            }
          }
        }
      }
    }
  }
`;

// Consulta para obtener productos filtrados por marca
export const GET_PRODUCTS_BY_BRAND = gql`
  query GetProductsByBrand($brandSlug: String!, $page: Int!, $pageSize: Int!) {
    products(
      filters: { brands: { slug: { eq: $brandSlug } } }
      pagination: { page: $page, pageSize: $pageSize }
    ) {
      data {
        id
        attributes {
          productName
          slug
          description
          price
          active
          isFeatured
          createdAt
          cityName
          state
          images {
            data {
              attributes {
                url
                formats
              }
            }
          }
          categories {
            data {
              attributes {
                categoryName
                slug
              }
            }
          }
          brands {
            data {
              attributes {
                brandName
                slug
              }
            }
          }
        }
      }
      meta {
        pagination {
          total
          page
          pageSize
          pageCount
        }
      }
    }
  }
`;

// Consulta para obtener todos los productos (páginados)
export const GET_PRODUCTS = gql`
  query GetProducts($page: Int!, $pageSize: Int!) {
    products(pagination: { page: $page, pageSize: $pageSize }) {
      data {
        id
        attributes {
          productName
          slug
          description
          price
          active
          isFeatured
          createdAt
          cityName
          state
          images {
            data {
              attributes {
                url
                formats
              }
            }
          }
          categories {
            data {
              attributes {
                categoryName
                slug
              }
            }
          }
          brands {
            data {
              attributes {
                brandName
                slug
              }
            }
          }
        }
      }
      meta {
        pagination {
          total
          page
          pageSize
          pageCount
        }
      }
    }
  }
`;
