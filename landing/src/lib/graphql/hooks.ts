//src/lib/graphql/hooks.ts

import { useQuery } from "@apollo/client";
import { GET_BRANDS, GET_PRODUCTS, GET_PRODUCTS_BY_BRAND } from "./queries";

// Hook para obtener todas las marcas
export function useGetBrands() {
  const { data, loading, error } = useQuery(GET_BRANDS);
  
  const brands = data?.brands?.data.map((brand: any) => ({
    id: brand.id,
    brandName: brand.attributes.brandName,
    slug: brand.attributes.slug,
    mainimage: {
      url: brand.attributes.mainimage?.data?.attributes?.url || "",
      formats: brand.attributes.mainimage?.data?.attributes?.formats || {}
    }
  })) || [];
  
  return {
    brands,
    loading,
    error: error ? error.message : null
  };
}

// Hook para obtener productos filtrados por marca
export function useGetProductsByBrand(brandSlug: string, page = 1, pageSize = 12) {
  const { data, loading, error } = useQuery(GET_PRODUCTS_BY_BRAND, {
    variables: { brandSlug, page, pageSize },
    skip: !brandSlug
  });

  // Formatea los datos para que coincidan con la estructura esperada por los componentes
  const products = data?.products?.data.map((product: any) => formatProductData(product)) || [];
  
  return {
    products,
    meta: data?.products?.meta || { pagination: { total: 0, page: 1, pageSize: 12, pageCount: 1 } },
    loading,
    error: error ? error.message : null
  };
}

// Hook para obtener todos los productos
export function useGetProducts(page = 1, pageSize = 12) {
  const { data, loading, error } = useQuery(GET_PRODUCTS, {
    variables: { page, pageSize }
  });
  
  // Formatea los datos para que coincidan con la estructura esperada por los componentes
  const products = data?.products?.data.map((product: any) => formatProductData(product)) || [];
  
  return {
    products,
    meta: data?.products?.meta || { pagination: { total: 0, page: 1, pageSize: 12, pageCount: 1 } },
    loading,
    error: error ? error.message : null
  };
}

// Función auxiliar para formatear los datos de producto
function formatProductData(product: any) {
  return {
    id: product.id,
    productName: product.attributes.productName,
    slug: product.attributes.slug,
    description: product.attributes.description,
    price: product.attributes.price,
    active: product.attributes.active,
    isFeatured: product.attributes.isFeatured,
    createdAt: product.attributes.createdAt,
    cityName: product.attributes.cityName,
    state: product.attributes.state,
    // Formatear las imágenes
    images: product.attributes.images?.data.map((img: any) => ({
      id: img.id,
      url: img.attributes.url,
      formats: img.attributes.formats
    })) || [],
    // Formatear las categorías
    categories: product.attributes.categories?.data.map((cat: any) => ({
      id: cat.id,
      categoryName: cat.attributes.categoryName,
      slug: cat.attributes.slug
    })) || [],
    // Formatear las marcas
    brands: product.attributes.brands?.data.map((brand: any) => ({
      id: brand.id,
      brandName: brand.attributes.brandName,
      slug: brand.attributes.slug
    })) || []
  };
}
