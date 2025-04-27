//src/types/product.ts

// Tipo para un producto individual
export type ProductType = {
  id: number;
  documentId: string;
  productName: string;
  slug: string;
  description: string;
  active: boolean;
  price: number;
  isFeatured: boolean;
  createdAt: string;
  updatedAt: string;
  publishedAt: string;
  weight: number;
  dimensions: string;
  dateManufactured: string;
  remaininWarranty?: string;
  State: string; 
  cityName: string;
  provinceName: string;
  countryName: string;
  directionName: string;
  latitud: number;
  longitud: number;
  views?: number;
  averageRating?: number;
  totalRatings?: number;
  images: {
    id: number;
    documentId: string;
    name: string;
    alternativeText: string | null;
    caption: string | null;
    width: number;
    height: number;
    formats: {
      small?: {
        ext: string;
        url: string;
        hash: string;
        mime: string;
        name: string;
        path: string | null;
        size: number;
        width: number;
        height: number;
        sizeInBytes: number;
      };
      medium?: {
        ext: string;
        url: string;
        hash: string;
        mime: string;
        name: string;
        path: string | null;
        size: number;
        width: number;
        height: number;
        sizeInBytes: number;
      };
      thumbnail: {
        ext: string;
        url: string;
        hash: string;
        mime: string;
        name: string;
        path: string | null;
        size: number;
        width: number;
        height: number;
        sizeInBytes: number;
      };
      large?: {
        ext: string;
        url: string;
        hash: string;
        mime: string;
        name: string;
        path: string | null;
        size: number;
        width: number;
        height: number;
        sizeInBytes: number;
      };
    };
    hash: string;
    ext: string;
    mime: string;
    size: number;
    url: string;
    previewUrl: string | null;
    provider: string;
    provider_metadata: string | null;
    createdAt: string;
    updatedAt: string;
    publishedAt: string;
  }[];
  categories: {
    id: number;
    documentId: string;
    categoryName: string;
    slug: string;
    createdAt: string;
    updatedAt: string;
    publishedAt: string;
  }[];
  brands: {
    id: number;
    documentId: string;
    brandName: string;
    slug: string;
    createdAt: string;
    updatedAt: string;
    publishedAt: string;
  }[];
  shipping_types: {
    id: number;
    documentId: string;
    shippingType: string;
    slug: string;
    nameShippingType: string;
    createdAt: string;
    updatedAt: string;
    publishedAt: string;
  }[];
};

// Tipo para una respuesta con varios productos
export type ProductsResponse = {
  data: ProductType[];
  meta: {
    pagination: {
      page: number;
      pageSize: number;
      pageCount: number;
      total: number;
    };
  };
};

// Tipo para una respuesta de un solo producto
export type SingleProductResponse = {
  data: ProductType;
  meta: {};
};