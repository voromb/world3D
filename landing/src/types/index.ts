//src/types/index.ts

// Tipo para StrapiBlock que se usa en el carrusel
export type StrapiBlock = {
  type: string;
  children: { text: string; type: string }[];
};

// Tipo para la estructura de imagen (adaptada a estructura plana de API v5)
export type ProductImageType = {
  id: number;
  documentId?: string;
  name: string;
  alternativeText: string | null;
  caption: string | null;
  width: number | null;
  height: number | null;
  formats: {
    small?: { url: string /* otros campos... */ };
    thumbnail?: { url: string /* otros campos... */ };
    medium?: { url: string /* otros campos... */ };
    large?: { url: string /* otros campos... */ };
  } | null;
  hash: string;
  ext: string;
  mime: string;
  size: number;
  url: string; // URL principal
  previewUrl: string | null;
  provider: string;
  provider_metadata: any | null;
  createdAt: string;
  updatedAt: string;
  publishedAt?: string;
};

// Tipos simplificados para otras relaciones (ajusta si necesitas más detalle)
export type ProductCategoryType = {
  id: number;
  documentId?: string;
  categoryName?: string;
  slug?: string;
  createdAt?: string;
  updatedAt?: string;
  publishedAt?: string;
};

// Tipo para las marcas
export type BrandType = {
  id: number;
  documentId?: string;
  brandName: string;
  slug: string;
  mainImage?: {
    url: string;
  };
  createdAt: string;
  updatedAt: string;
  publishedAt: string;
};

export type ProductShippingType = {
  id: number;
  documentId?: string;
  shippingType?: string;
  slug?: string;
  nameShippingType?: string;
  createdAt?: string;
  updatedAt?: string;
  publishedAt?: string;
};

// --- Tipo Principal del Producto (Estructura Plana v5) ---
export type ProductType = {
  id: number;
  documentId?: string;
  productName: string;
  slug: string;
  description: string | null;
  active: boolean;
  price: number | null;
  isFeatured: boolean | null; // Permite null
  createdAt: string;
  updatedAt: string;
  publishedAt: string | null;
  weight: number | null;
  dimensions: string | null;
  dateManufactured: string | null; // O Date si lo transformas
  remainingWarranty?: string; // Corregido y opcional
  state?: string; // Corregido casing y opcional
  cityName: string | null;
  provinceName: string | null;
  countryName: string | null;
  directionName: string | null;
  latitud: number | null;
  longitud: number | null;
  views?: number; // Número de vistas del producto
  averageRating?: number; // Valoración media del producto
  totalRatings?: number; // Número total de valoraciones
  // Relaciones: Asume que son arrays de los tipos definidos arriba
  images: ProductImageType[];
  categories: ProductCategoryType[];
  brands: BrandType[];
  shipping_types: ProductShippingType[];
};

// --- Tipos de Respuesta API (Productos) ---
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

export type SingleProductResponse = {
  data: ProductType;
  meta: {}; // Meta puede estar vacío para findOne
};

// --- Tipo para Banner / ImageGeneral ---
export type HeroImageType = {
  id: number;
  documentId?: string; // camelCase y opcional
  imageGeneralName?: string; // camelCase y opcional
  slug: string;
  text_general: {
    title: string;
    subtitle?: string; // Opcional
  };
  links: { url: string; text: string }[] | null; // Permite null
  url: string; // URL completa de la imagen ya procesada
};

// --- Otros Tipos ---

// Tipo para categorías (si necesitas usarlo directamente)
export type CategoryType = {
  id: number;
  documentId?: string;
  categoryName: string;
  slug: string;
  createdAt?: string;
  updatedAt?: string;
  publishedAt?: string;
};

// Tipo para un filtro de búsqueda
export type FilterType = {
  category?: string;
  city?: string;
  price?: string;
  brand?: string;
  state?: string;
  search?: string;
  sort?: string;
  page?: number;
  shipping?: string;
  // Campo para especificar qué relaciones se deben poblar (populate)
  populateFields?: string[];
};

// Tipo para rango de precios
export type PriceRangeType = {
  min: number;
  max: number;
};

// Tipo genérico para respuestas API (usado por los hooks)
export type ResponseType = {
  result: any; // Puedes intentar hacerlo más específico: ProductType[] | HeroImageType[] | null, etc.
  loading: boolean;
  error: string | null;
};
