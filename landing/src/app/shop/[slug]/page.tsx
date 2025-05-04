//src/app/shop/[slug]/page.tsx

"use client";

import React, { useEffect, useState } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { ProductType } from "@/types";
import ProductGrid from "@/components/ui/product/ProductGrid";
import dynamic from "next/dynamic";
import { updateProductViewsGraphQL, submitRatingGraphQL, addToFavorites, checkProductInFavorites, removeFromFavorites } from "@/lib/graphql";
import { useGraphQLSetting } from "../../../lib/useGraphQLSetting";
import ReactionButtons from "@/components/ReactionButtons";
import { useCartStore } from "@/lib/store/cart-store";
import { ShoppingCart } from "lucide-react";
import { toast } from "react-hot-toast";

// Importación dinámica del componente de mapa para evitar problemas con SSR
const ProductMap = dynamic(() => import("@/components/ui/map/ProductMap"), {
  ssr: false,
  loading: () => (
    <div className="w-full h-96 bg-gray-100 flex items-center justify-center">
      Cargando mapa...
    </div>
  ),
});

// Función auxiliar para generar URLs de imágenes completas
const getImageUrl = (imagePath: string): string => {
  if (!imagePath) return "/placeholder.svg";
  if (imagePath.startsWith("http")) return imagePath;
  return `${process.env.NEXT_PUBLIC_BACKEND_URL}${imagePath}`;
};

// Interfaz para las props del componente StarRating
interface StarRatingProps {
  rating: number;
  setRating: (rating: number) => void;
  disabled?: boolean;
}

// Componente de estrellas para valoraciones
const StarRating = ({
  rating,
  setRating,
  disabled = false,
}: StarRatingProps) => {
  const [hover, setHover] = useState(0);

  return (
    <div className="flex items-center">
      {[...Array(5)].map((_, index) => {
        const ratingValue = index + 1;

        return (
          <button
            type="button"
            key={index}
            className={`bg-transparent border-none outline-none cursor-pointer ${
              disabled ? "cursor-default" : ""
            }`}
            onClick={() => !disabled && setRating(ratingValue)}
            onMouseEnter={() => !disabled && setHover(ratingValue)}
            onMouseLeave={() => !disabled && setHover(0)}
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill={ratingValue <= (hover || rating) ? "#FFD700" : "#e4e5e9"}
              stroke="#FFD700"
              strokeWidth="1"
              className="transition-colors duration-200"
            >
              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
            </svg>
          </button>
        );
      })}
    </div>
  );
};

// Interfaz para las props del componente RatingDisplay
interface RatingDisplayProps {
  averageRating: number;
  totalRatings: number;
}

// Componente para mostrar el promedio de valoraciones
const RatingDisplay = ({ averageRating, totalRatings }: RatingDisplayProps) => {
  return (
    <div className="flex items-center gap-2">
      <div className="flex">
        {[...Array(5)].map((_, index) => {
          return (
            <svg
              key={index}
              xmlns="http://www.w3.org/2000/svg"
              width="20"
              height="20"
              viewBox="0 0 24 24"
              fill={index < Math.round(averageRating) ? "#FFD700" : "#e4e5e9"}
              stroke="#FFD700"
              strokeWidth="1"
            >
              <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
            </svg>
          );
        })}
      </div>
      <span className="text-sm text-gray-600">
        {averageRating.toFixed(1)} ({totalRatings}{" "}
        {totalRatings === 1 ? "valoración" : "valoraciones"})
      </span>
    </div>
  );
};

// Interfaz para las props del componente ViewCounter
interface ViewCounterProps {
  views: number;
}

// Componente para mostrar el contador de visitas
const ViewCounter = ({ views }: ViewCounterProps) => {
  // Asegurarnos de que views siempre sea un número
  const viewCount = typeof views === 'number' ? views : 0;
  
  return (
    <div className="flex items-center text-gray-600">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="18"
        height="18"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
        className="mr-1"
      >
        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
        <circle cx="12" cy="12" r="3"></circle>
      </svg>
      <span>
        {viewCount} {viewCount === 1 ? "visita" : "visitas"}
      </span>
    </div>
  );
};

export default function ProductDetailPage() {
  const params = useParams();
  const slug = params?.slug as string;

  const [loading, setLoading] = useState(true);
  const [product, setProduct] = useState<ProductType | null>(null);
  const [relatedProducts, setRelatedProducts] = useState<ProductType[]>([]);
  const [essentialProducts, setEssentialProducts] = useState<ProductType[]>([]);
  const [selectedImage, setSelectedImage] = useState(0);
  const [essentialsPage, setEssentialsPage] = useState(1);
  const [relatedPage, setRelatedPage] = useState(1);
  const [totalEssentialsPages, setTotalEssentialsPages] = useState(1);
  const [totalRelatedPages, setTotalRelatedPages] = useState(1);
  const [loadingEssentials, setLoadingEssentials] = useState(true);
  const [loadingRelated, setLoadingRelated] = useState(true);
  const [productType, setProductType] = useState(""); // Para depuración
  const PRODUCTS_PER_PAGE = 6; // 6 productos por página

  // Estados para valoraciones y visitas
  const [userRating, setUserRating] = useState(0);
  const [averageRating, setAverageRating] = useState(0);
  const [totalRatings, setTotalRatings] = useState(0);
  const [hasRated, setHasRated] = useState(false);
  const [submittingRating, setSubmittingRating] = useState(false);
  const [productViews, setProductViews] = useState(0);
  const [viewsUpdated, setViewsUpdated] = useState(false);
  const [ratingSubmitted, setRatingSubmitted] = useState(false);

  // Estados para la funcionalidad de favoritos
  const [isFavorite, setIsFavorite] = useState(false);
  const [favoriteId, setFavoriteId] = useState<string | null>(null);
  const [processingFavorite, setProcessingFavorite] = useState(false);

  // Estado para controlar el uso de GraphQL
  const { settings: graphQLSettings } = useGraphQLSetting();

  useEffect(() => {
    // Verificar si el producto está en favoritos cuando cambie el producto
    if (product?.documentId) {
      checkFavoriteStatus();
    }
  }, [product]);

  useEffect(() => {
    const fetchProductData = async () => {
      if (!slug) return;

      try {
        setLoading(true);
        setLoadingEssentials(true);
        setLoadingRelated(true);

        // Obtener producto
        const productResponse = await fetch(`/api/products/${slug}`);

        if (!productResponse.ok) {
          throw new Error("Product not found");
        }

        const productData = await productResponse.json();
        
        // Depuración detallada: mostrar información completa del producto cargado
        console.log('=== INFORMACIÓN COMPLETA DEL PRODUCTO ===');
        console.log('ID:', productData.id);
        console.log('Slug:', productData.slug);
        console.log('Nombre:', productData.productName || productData.title || productData.name);
        
        // Verificar ID de Strapi si existe
        if (productData.strapiId || (productData.attributes && productData.attributes.id)) {
          console.log('ID de Strapi:', productData.strapiId || productData.attributes?.id);
        }
        
        // Verificar estructura para determinar si es un producto directo de Strapi
        if (productData.data && productData.data.id) {
          console.log('Estructura Strapi detectada - ID real:', productData.data.id);
        }
        
        console.log('Estructura completa:', productData);
        
        setProduct(productData);

        // Inicializar datos de valoraciones y visitas
        if (productData.averageRating !== undefined && productData.averageRating !== null) {
          console.log(`Valoración media del producto: ${productData.averageRating}`);
          setAverageRating(productData.averageRating);
        } else {
          console.log("El producto no tiene valoración media establecida");
        }

        if (productData.totalRatings !== undefined && productData.totalRatings !== null) {
          console.log(`Total de valoraciones del producto: ${productData.totalRatings}`);
          setTotalRatings(productData.totalRatings);
        } else {
          console.log("El producto no tiene total de valoraciones establecido");
        }

        // Siempre inicializar vistas aunque sea con 0
        const views = productData.views || 0;
        console.log(`Contador de vistas inicializado: ${views}`);
        setProductViews(views);

        // Verificar si el usuario ya ha valorado este producto
        // Usar documentId para verificar valoraciones previas
        checkUserRating(productData.documentId || productData.id);

        // Determinar tipo de producto para debugging
        determineProductType(productData);

        // Cargar los productos relacionados y esenciales en paralelo
        await Promise.all([
          loadRelatedProducts(productData, 1), // Forzar página 1 en carga inicial
          loadEssentialProducts(productData, 1), // Forzar página 1 en carga inicial
        ]);

        setLoading(false);

        // Incrementar el contador de vistas solo si no se ha actualizado ya
        // Usamos un ref para evitar doble actualización en StrictMode
        if (viewsUpdated === false) {
          // Marcamos como actualizado antes de la llamada para evitar duplicidad
          setViewsUpdated(true);
          // Usar documentId para actualizar vistas, ya que es lo que espera Strapi v5
          updateProductViews(productData.documentId || productData.slug || productData.id);
          console.log(`Actualizando vistas usando: ${productData.documentId ? 'documentId' : (productData.slug ? 'slug' : 'ID')}`);
        }
      } catch (error) {
        console.error("Error fetching product:", error);
        setProduct(null);
        setLoading(false);
        setLoadingEssentials(false);
        setLoadingRelated(false);
      }
    };

    fetchProductData();
  }, [slug]);

  // Verificar si el usuario ya ha valorado este producto
  const checkUserRating = async (productId: string) => {
    // En lugar de usar sessionStorage, consultamos las valoraciones actuales en Strapi
    // utilizando GraphQL, igual que hicimos con las visitas
    try {
      if (!product) return;
      
      // Usar preferentemente documentId, pero aceptar también id como fallback
      const realProductId = product.documentId || productId;
      console.log(`Consultando valoraciones para producto: ${realProductId}`);
      
      // Comprobar si el producto ya tiene valoraciones
      if (product.averageRating && product.totalRatings) {
        console.log(`Producto con valoración media: ${product.averageRating}, Total valoraciones: ${product.totalRatings}`);
        setAverageRating(product.averageRating);
        setTotalRatings(product.totalRatings);
        
        // No podemos determinar si el usuario actual ha valorado ya el producto
        // sin autenticación, pero podemos mostrarle las valoraciones actuales
      }
      
      // En una aplicación real con autenticación, aquí determinaríamos si el usuario
      // ya ha valorado el producto consultando sus valoraciones personales
    } catch (error) {
      console.error("Error al verificar valoraciones:", error);
    }
    
    console.log("Las valoraciones se gestionan directamente en la base de datos a través de GraphQL");
  };

  // Verificar si el producto está en favoritos
  const checkFavoriteStatus = async () => {
    if (!product?.documentId) return;
    
    try {
      // Usando un ID de usuario simulado/hardcodeado por ahora
      // En un sistema real, este debería ser el ID del usuario autenticado
      const userId = "1"; // ID de usuario simulado
      
      // Verificar si el producto está en favoritos
      const existingFavoriteId = await checkProductInFavorites(userId, product.documentId);
      
      if (existingFavoriteId) {
        setIsFavorite(true);
        setFavoriteId(existingFavoriteId);
        console.log(`Producto ya en favoritos con ID: ${existingFavoriteId}`);
      } else {
        setIsFavorite(false);
        setFavoriteId(null);
      }
    } catch (error) {
      console.error('Error al verificar estado de favorito:', error);
    }
  };
  
  // Función para añadir o quitar de favoritos
  const handleToggleFavorite = async () => {
    if (!product?.documentId || processingFavorite) return;
    
    setProcessingFavorite(true);
    
    try {
      // Usando un ID de usuario simulado/hardcodeado por ahora
      const userId = "1"; // ID de usuario simulado
      
      if (isFavorite && favoriteId) {
        // Quitar de favoritos
        const success = await removeFromFavorites(favoriteId);
        
        if (success) {
          setIsFavorite(false);
          setFavoriteId(null);
          console.log('Producto eliminado de favoritos');
        }
      } else {
        // Añadir a favoritos
        const success = await addToFavorites(userId, product.documentId);
        
        if (success) {
          // Verificar nuevamente para obtener el ID del favorito
          const newFavoriteId = await checkProductInFavorites(userId, product.documentId);
          
          setIsFavorite(true);
          setFavoriteId(newFavoriteId);
          console.log('Producto añadido a favoritos');
        }
      }
    } catch (error) {
      console.error('Error al gestionar favorito:', error);
    } finally {
      setProcessingFavorite(false);
    }
  };

  // Actualizar el contador de visitas
  const updateProductViews = async (productId: string) => {
    try {
      // Debemos usar el documentId en lugar del slug o ID numérico para Strapi v5
      // Si no tenemos el documentId, usamos el slug o ID como último recurso
      const productIdentifier = product?.documentId || product?.slug || productId;
      console.log("Intentando actualizar vistas para el producto con identificador:", productIdentifier);
      console.log("Tipo de identificador:", product?.documentId ? "documentId" : (product?.slug ? "slug" : "ID"));
      
      // Solo incrementamos si no se ha actualizado ya en esta sesión del componente
      // Eliminamos esta restricción para que siempre incremente las vistas
      // Comentamos para referencia: if (viewsUpdated) { return; }
      
      // Si está activado GraphQL, utilizamos esa API en lugar de REST
      if (graphQLSettings.enabled) {
        console.log("Usando GraphQL para actualizar vistas");
        try {
          // Primero obtenemos las vistas actuales
          let currentViews = productViews;
          console.log("Vistas actuales antes de incrementar:", currentViews);
          
          // Incrementamos las vistas en 1
          const newViews = await updateProductViewsGraphQL(productIdentifier);
          console.log("GraphQL: Vistas actualizadas correctamente:", newViews);
          
          // Actualizamos el estado para mostrar el nuevo valor
          setProductViews(newViews);
          setViewsUpdated(true);
          return;
        } catch (graphqlError) {
          console.error("Error usando GraphQL, intentando API REST:", graphqlError);
          // Si falla GraphQL, continuamos con la API REST como respaldo
        }
      }
      
      // API REST original
      try {
        console.log(`Llamando a API REST con identificador: ${productIdentifier}`);
        
        // Verificar si estamos usando un ID o slug
        const isNumericId = !isNaN(Number(productIdentifier));
        console.log(`¿Es ID numérico?: ${isNumericId}. Si no, podría ser un slug.`);
        
        const response = await fetch(
          `/api/products-views/${productIdentifier}/increment`,
          {
            method: "POST",
            // Añadimos un identificador único para evitar duplicidad en el servidor
            headers: {
              'X-Request-ID': `${Date.now()}-${Math.random()}`,
            }
          }
        );

        const data = await response.json();
        console.log("Respuesta del incremento de vistas:", data);
        
        // Actualizar el contador en la interfaz
        if (data && typeof data.views === 'number') {
          console.log("API devolvió contador:", data.views);
          setProductViews(data.views);
        }

        // Marcamos como actualizado para evitar múltiples llamadas
        setViewsUpdated(true);
      } catch (error) {
        console.error("Error en la petición:", error);
      }
    } catch (error) {
      console.error("Error al actualizar las visitas:", error);
    }
  };

  // Manejar el cambio de valoración del usuario
  // En tu componente ProductDetailPage

  // Submit rating
  const submitRating = async (rating: number) => {
    if (!product) return;

    try {
      setSubmittingRating(true);
      
      // Si está activado GraphQL, utilizamos esa API
      if (graphQLSettings.enabled) {
        try {
          console.log("Usando GraphQL para enviar valoración");
          // Usamos el documentId si está disponible, de lo contrario el id
          const productId = product.documentId || product.id;
          console.log("ID del producto para valoración:", productId);
          const result = await submitRatingGraphQL(productId.toString(), rating);
          console.log("GraphQL: Valoración enviada correctamente:", result);
          
          // Actualizar UI
          setAverageRating(result.averageRating);
          setTotalRatings(result.totalRatings);
          setHasRated(true);
          setRatingSubmitted(true);
          
          // No necesitamos guardar en sessionStorage
          // La valoración se guarda directamente en la base de datos mediante GraphQL
          console.log(`Valoración ${rating} guardada en base de datos para producto ${productId}`);
          
          // En la próxima carga de página, obtendremos esta valoración directamente de la base de datos
          
          setTimeout(() => {
            setRatingSubmitted(false);
          }, 3000);
          return;
        } catch (graphqlError) {
          console.error("Error usando GraphQL, intentando API REST:", graphqlError);
          // Si falla GraphQL, continuamos con la API REST como respaldo
        }
      }
      
      // API REST original
      const response = await fetch(`/api/product-ratings/${product.id}/rate`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ rating }),
      });

      const data = await response.json();

      // Actualizar UI
      setAverageRating(data.averageRating);
      setTotalRatings(data.totalRatings);
      setHasRated(true);
      setRatingSubmitted(true);

      // Con GraphQL no necesitamos localStorage, las valoraciones se guardan
      // directamente en la base de datos mediante la API

      setTimeout(() => {
        setRatingSubmitted(false);
      }, 3000);
    } catch (error) {
      console.error("Error al enviar valoración:", error);
      // Comentado para no mostrar alerta, pero puedes habilitarlo si deseas
      // alert("No se pudo enviar tu valoración. Inténtalo de nuevo más tarde.");
    } finally {
      setSubmittingRating(false);
    }
  };

  const handleRatingChange = async (newRating: number) => {
    if (!product || hasRated || submittingRating) return;
    
    // Depuración: mostrar detalles del producto
    console.log('Producto a valorar:', {
      id: product.id,
      documentId: product.documentId,
      nombre: product.productName,
      slug: product.slug
    });
    
    // Establecer la valoración del usuario en la interfaz
    setUserRating(newRating);
    
    // Llamar a la función submitRating para utilizar el método correcto (GraphQL o API REST)
    try {
      await submitRating(newRating);
      // El resto de los estados (averageRating, totalRatings, etc.) se actualizarán dentro de submitRating
    } catch (error) {
      console.error('Error al enviar valoración:', error);
    }
  };

  // Función para determinar el tipo de producto para debugging
  const determineProductType = (currentProduct: ProductType) => {
    if (isFilamentPrinter(currentProduct)) {
      setProductType("impresora-filamento");
    } else if (isResinPrinter(currentProduct)) {
      setProductType("impresora-resina");
    } else if (isFilament(currentProduct)) {
      setProductType("filamento");
    } else if (isResin(currentProduct)) {
      setProductType("resina");
    } else if (isElectronica(currentProduct)) {
      setProductType("electronica");
    } else if (isPerfileria(currentProduct)) {
      setProductType("perfileria");
    } else {
      setProductType("otro");
    }
  };

  // FUNCIÓN para cargar productos relacionados
  const loadRelatedProducts = async (
    currentProduct: ProductType,
    pageNumber: number
  ) => {
    if (!currentProduct?.categories?.[0]) {
      setRelatedProducts([]);
      setLoadingRelated(false);
      return;
    }

    try {
      setLoadingRelated(true);
      const categorySlug = currentProduct.categories[0].slug;

      console.log(
        `[LOG] Cargando productos relacionados, página ${pageNumber}, categoría ${categorySlug}`
      );

      // Solicitar TODOS los productos para poder calcular correctamente las páginas totales
      const response = await fetch(
        `/api/products?category=${categorySlug}&exclude=${currentProduct.id}&limit=100`
      );

      if (!response.ok) {
        throw new Error(
          `Error al obtener productos relacionados: ${response.status}`
        );
      }

      const data = await response.json();

      // Verificar que tenemos datos válidos
      if (data && Array.isArray(data.data)) {
        console.log(
          `[LOG] Productos relacionados recibidos: ${data.data.length}`
        );

        // Si no hay productos, no hacer nada
        if (data.data.length === 0) {
          setRelatedProducts([]);
          setTotalRelatedPages(1);
          setRelatedPage(1);
          setLoadingRelated(false);
          return;
        }

        // Actualizar estado con TODOS los productos
        setRelatedProducts(data.data);

        // Calcular cuántas páginas REALES hay (basado en productos disponibles)
        const realPageCount = Math.ceil(data.data.length / PRODUCTS_PER_PAGE);
        console.log(`[LOG] Páginas reales relacionados: ${realPageCount}`);

        // Si la página solicitada es mayor que las páginas reales, ajustar a la última página
        if (pageNumber > realPageCount) {
          setRelatedPage(realPageCount);
        } else {
          setRelatedPage(pageNumber);
        }

        setTotalRelatedPages(realPageCount);
      } else {
        console.warn(
          "[WARN] No se recibieron datos válidos para productos relacionados"
        );
        setRelatedProducts([]);
        setTotalRelatedPages(1);
        setRelatedPage(1);
      }
    } catch (error) {
      console.error("[ERROR] Error al cargar productos relacionados:", error);
      setRelatedProducts([]);
      setTotalRelatedPages(1);
      setRelatedPage(1);
    } finally {
      setLoadingRelated(false);
    }
  };

  // FUNCIÓN para cargar productos esenciales
  const loadEssentialProducts = async (
    currentProduct: ProductType,
    pageNumber: number
  ) => {
    try {
      setLoadingEssentials(true);

      // Determinar qué categoría buscar
      let categoryToFetch = "";

      if (isFilamentPrinter(currentProduct)) {
        categoryToFetch = "filamento";
      } else if (isResinPrinter(currentProduct)) {
        categoryToFetch = "resina";
      } else if (isFilament(currentProduct)) {
        categoryToFetch = "impresora-filamento";
      } else if (isResin(currentProduct)) {
        categoryToFetch = "impresora-resina";
      } else if (isElectronica(currentProduct)) {
        categoryToFetch = "perfileria";
      } else if (isPerfileria(currentProduct)) {
        categoryToFetch = "electronica";
      }

      // Si no se determinó una categoría específica, usar productos destacados
      if (!categoryToFetch) {
        await loadFeaturedProducts(currentProduct, pageNumber);
        return;
      }

      console.log(
        `[LOG] Cargando productos esenciales, página ${pageNumber}, categoría ${categoryToFetch}`
      );

      // Solicitar TODOS los productos para poder calcular correctamente las páginas totales
      const response = await fetch(
        `/api/products?category=${categoryToFetch}&exclude=${currentProduct.id}&limit=100`
      );

      if (!response.ok) {
        throw new Error(
          `Error al obtener productos esenciales: ${response.status}`
        );
      }

      const data = await response.json();

      // Verificar que tenemos datos válidos
      if (data && Array.isArray(data.data)) {
        console.log(
          `[LOG] Productos esenciales recibidos: ${data.data.length}`
        );

        // Si no hay productos, no hacer nada
        if (data.data.length === 0) {
          setEssentialProducts([]);
          setTotalEssentialsPages(1);
          setEssentialsPage(1);
          setLoadingEssentials(false);
          return;
        }

        // Actualizar estado con TODOS los productos
        setEssentialProducts(data.data);

        // Calcular cuántas páginas REALES hay (basado en productos disponibles)
        const realPageCount = Math.ceil(data.data.length / PRODUCTS_PER_PAGE);
        console.log(`[LOG] Páginas reales esenciales: ${realPageCount}`);

        // Si la página solicitada es mayor que las páginas reales, ajustar a la última página
        if (pageNumber > realPageCount) {
          setEssentialsPage(realPageCount);
        } else {
          setEssentialsPage(pageNumber);
        }

        setTotalEssentialsPages(realPageCount);
      } else {
        console.warn(
          "[WARN] No se recibieron datos válidos para productos esenciales"
        );
        setEssentialProducts([]);
        setTotalEssentialsPages(1);
        setEssentialsPage(1);
      }
    } catch (error) {
      console.error("[ERROR] Error al cargar productos esenciales:", error);
      setEssentialProducts([]);
      setTotalEssentialsPages(1);
      setEssentialsPage(1);
    } finally {
      setLoadingEssentials(false);
    }
  };

  // Función para cargar productos destacados
  const loadFeaturedProducts = async (
    currentProduct: ProductType,
    pageNumber: number
  ) => {
    try {
      console.log(`[LOG] Cargando productos destacados, página ${pageNumber}`);

      // Solicitar TODOS los productos destacados
      const response = await fetch(
        `/api/products?isFeatured=true&exclude=${currentProduct.id}&limit=100`
      );

      if (!response.ok) {
        throw new Error(
          `Error al obtener productos destacados: ${response.status}`
        );
      }

      const data = await response.json();

      if (data && Array.isArray(data.data)) {
        console.log(
          `[LOG] Productos destacados recibidos: ${data.data.length}`
        );

        // Si no hay productos, no hacer nada
        if (data.data.length === 0) {
          setEssentialProducts([]);
          setTotalEssentialsPages(1);
          setEssentialsPage(1);
          setLoadingEssentials(false);
          return;
        }

        // Actualizar estado con TODOS los productos
        setEssentialProducts(data.data);

        // Calcular cuántas páginas REALES hay (basado en productos disponibles)
        const realPageCount = Math.ceil(data.data.length / PRODUCTS_PER_PAGE);
        console.log(`[LOG] Páginas reales destacados: ${realPageCount}`);

        // Si la página solicitada es mayor que las páginas reales, ajustar a la última página
        if (pageNumber > realPageCount) {
          setEssentialsPage(realPageCount);
        } else {
          setEssentialsPage(pageNumber);
        }

        setTotalEssentialsPages(realPageCount);
      } else {
        console.warn(
          "[WARN] No se recibieron datos válidos para productos destacados"
        );
        setEssentialProducts([]);
        setTotalEssentialsPages(1);
        setEssentialsPage(1);
      }
    } catch (error) {
      console.error("[ERROR] Error al cargar productos destacados:", error);
      setEssentialProducts([]);
      setTotalEssentialsPages(1);
      setEssentialsPage(1);
    } finally {
      setLoadingEssentials(false);
    }
  };

  // Funciones simplificadas para cambiar página
  const handleEssentialsPageChange = (newPage: number) => {
    if (newPage < 1 || newPage > totalEssentialsPages || loadingEssentials)
      return;
    setEssentialsPage(newPage);
  };

  const handleRelatedPageChange = (newPage: number) => {
    if (newPage < 1 || newPage > totalRelatedPages || loadingRelated) return;
    setRelatedPage(newPage);
  };

  // Funciones auxiliares para determinar el tipo de producto
  const isFilamentPrinter = (product: ProductType): boolean => {
    return (
      hasCategory(product, "impresora-filamento") ||
      hasCategory(product, "fdm") ||
      hasKeywords(product, [
        "impresora fdm",
        "impresora filamento",
        "impresora fff",
      ])
    );
  };

  const isResinPrinter = (product: ProductType): boolean => {
    return (
      hasCategory(product, "impresora-resina") ||
      hasCategory(product, "sla") ||
      hasCategory(product, "dlp") ||
      hasKeywords(product, [
        "impresora resina",
        "impresora sla",
        "impresora dlp",
        "impresora lcd",
      ])
    );
  };

  const isFilament = (product: ProductType): boolean => {
    return (
      hasCategory(product, "filamento") ||
      hasKeywords(product, ["filamento", "pla", "abs", "petg", "tpu", "nylon"])
    );
  };

  const isResin = (product: ProductType): boolean => {
    return (
      hasCategory(product, "resina") ||
      hasKeywords(product, ["resina", "resin", "fotopolímero"])
    );
  };

  const isElectronica = (product: ProductType): boolean => {
    return (
      hasCategory(product, "electronica") ||
      hasKeywords(product, ["electrónica", "placa", "arduino", "raspberry"])
    );
  };

  const isPerfileria = (product: ProductType): boolean => {
    return (
      hasCategory(product, "perfileria") ||
      hasKeywords(product, ["perfil", "perfilería", "aluminio"])
    );
  };

  const hasCategory = (product: ProductType, categorySlug: string): boolean => {
    if (!product.categories) return false;

    return product.categories.some(
      (cat) =>
        cat.slug != null &&
        (cat.slug === categorySlug ||
          cat.slug.includes(categorySlug) ||
          (cat.categoryName &&
            cat.categoryName
              .toLowerCase()
              .includes(categorySlug.toLowerCase())))
    );
  };

  const hasKeywords = (product: ProductType, keywords: string[]): boolean => {
    if (!product.productName) return false;

    const name = product.productName.toLowerCase();
    const description = product.description?.toLowerCase() || "";
    return keywords.some(
      (keyword) => name.includes(keyword) || description.includes(keyword)
    );
  };

  // Función para obtener un subconjunto de productos para la página actual
  const getPageProducts = (
    products: ProductType[],
    page: number
  ): ProductType[] => {
    // Si no hay productos o el array es inválido, devolver array vacío
    if (!products || !Array.isArray(products) || products.length === 0) {
      return [];
    }

    // Calcular índices de inicio y fin para la página actual
    const startIndex = (page - 1) * PRODUCTS_PER_PAGE;
    const endIndex = startIndex + PRODUCTS_PER_PAGE;

    // Si el índice de inicio es mayor que la longitud del array, devolver los primeros 6
    if (startIndex >= products.length) {
      return products.slice(0, Math.min(PRODUCTS_PER_PAGE, products.length));
    }

    // Devolver los productos de la página actual
    return products.slice(startIndex, endIndex);
  };

  // Obtener los productos para la página actual
  const currentEssentialProducts = getPageProducts(
    essentialProducts,
    essentialsPage
  );
  const currentRelatedProducts = getPageProducts(relatedProducts, relatedPage);

  // Determinar qué tipo de título mostrar para la sección de imprescindibles
  const getEssentialsTitle = () => {
    // Verificar si product es null antes de usar las funciones de validación
    if (!product) {
      return "Productos relacionados";
    }

    if (isFilamentPrinter(product)) {
      return "Filamentos imprescindibles";
    } else if (isResinPrinter(product)) {
      return "Resinas imprescindibles";
    } else if (isFilament(product)) {
      return "Impresoras de filamento compatibles";
    } else if (isResin(product)) {
      return "Impresoras de resina compatibles";
    } else if (isElectronica(product)) {
      return "Perfilería relacionada";
    } else if (isPerfileria(product)) {
      return "Electrónica relacionada";
    } else {
      return "Productos imprescindibles";
    }
  };

  // Loading state
  if (loading) {
    return (
      <div className="container mx-auto px-4 py-12">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded mb-4 w-1/3"></div>
          <div className="h-4 bg-gray-200 rounded w-1/4 mb-8"></div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div className="h-96 bg-gray-200 rounded-lg"></div>
            <div>
              <div className="h-10 bg-gray-200 rounded mb-4"></div>
              <div className="h-6 bg-gray-200 rounded mb-4 w-1/4"></div>
              <div className="h-16 bg-gray-200 rounded mb-6"></div>
              <div className="h-32 bg-gray-200 rounded mb-6"></div>
              <div className="h-12 bg-gray-200 rounded mb-4"></div>
              <div className="h-12 bg-gray-200 rounded"></div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Error state - producto no encontrado
  if (!product) {
    return (
      <div className="container mx-auto px-4 py-16">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Producto no encontrado</h1>
          <p className="mb-8">
            El producto que estás buscando no existe o ha sido eliminado.
          </p>
          <Link
            href="/shop"
            className="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg transition-colors inline-block"
          >
            Volver a la tienda
          </Link>
        </div>
      </div>
    );
  }

  return (
    <main className="bg-gray-50 py-8">
      <div className="container mx-auto px-4">
        {/* Breadcrumbs */}
        <nav className="flex mb-6">
          <ol className="flex items-center space-x-2 text-sm">
            <li>
              <Link href="/" className="text-gray-500 hover:text-blue-600">
                Inicio
              </Link>
            </li>
            <li className="flex items-center space-x-2">
              <span className="text-gray-400">/</span>
              <Link href="/shop" className="text-gray-500 hover:text-blue-600">
                Tienda
              </Link>
            </li>
            {product.categories?.[0] && (
              <li className="flex items-center space-x-2">
                <span className="text-gray-400">/</span>
                <Link
                  href={`/shop?category=${product.categories[0].slug}`}
                  className="text-gray-500 hover:text-blue-600"
                >
                  {product.categories[0].categoryName}
                </Link>
              </li>
            )}
            <li className="flex items-center space-x-2">
              <span className="text-gray-400">/</span>
              <span className="text-gray-700 font-medium truncate max-w-[200px]">
                {product.productName}
              </span>
            </li>
          </ol>
        </nav>

        {/* Contenido del producto */}
        <div className="bg-white rounded-lg shadow-md p-6 mb-8">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {/* Galería de imágenes */}
            <div>
              {product.images && product.images.length > 0 ? (
                <>
                  <div className="relative h-80 md:h-96 mb-4 bg-white rounded-lg overflow-hidden border">
                    <img
                      src={getImageUrl(product.images[selectedImage].url)}
                      alt={product.productName}
                      className="absolute inset-0 w-full h-full object-contain"
                      onError={(e) => {
                        console.error(
                          `Error loading image: ${product.images[selectedImage].url}`
                        );
                        e.currentTarget.src = "/placeholder.svg";
                      }}
                    />
                  </div>
                  {product.images.length > 1 && (
                    <div className="grid grid-cols-5 gap-2">
                      {product.images.map((image, index) => (
                        <button
                          key={image.id}
                          onClick={() => setSelectedImage(index)}
                          className={`relative h-16 bg-white rounded-md overflow-hidden border-2 ${
                            selectedImage === index
                              ? "border-blue-600"
                              : "border-gray-200"
                          }`}
                        >
                          <img
                            src={getImageUrl(
                              image.formats?.thumbnail?.url || image.url
                            )}
                            alt={`${product.productName} - Imagen ${index + 1}`}
                            className="absolute inset-0 w-full h-full object-cover"
                            onError={(e) => {
                              e.currentTarget.src = "/placeholder.svg";
                            }}
                          />
                        </button>
                      ))}
                    </div>
                  )}
                </>
              ) : (
                <div className="h-80 bg-gray-200 rounded-lg flex items-center justify-center">
                  <span className="text-gray-400">
                    Sin imágenes disponibles
                  </span>
                </div>
              )}
            </div>

            {/* Información del producto */}
            <div>
              <h1 className="text-3xl font-bold mb-2">{product.productName}</h1>

              <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 mb-4">
                <div className="flex items-center">
                  {product.brands?.[0] && (
                    <span className="text-gray-600 mr-4">
                      Marca:{" "}
                      <span className="font-semibold">
                        {product.brands[0].brandName}
                      </span>
                    </span>
                  )}
                  <span className="text-gray-600">
                    Estado:{" "}
                    <span className="font-semibold">
                      {product.state || "Usado"}
                    </span>
                  </span>
                </div>

                {/* Contador de visitas */}
                <ViewCounter views={productViews} />
              </div>

              {/* Sistema de valoración directo */}
              <div className="mb-4">
                <div className="flex flex-col sm:flex-row items-start sm:items-center gap-2">
                  {totalRatings > 0 && (
                    <RatingDisplay
                      averageRating={averageRating}
                      totalRatings={totalRatings}
                    />
                  )}

                  <div className="flex flex-col">
                    <div className="flex items-center">
                      {hasRated ? (
                        <div className="flex items-center">
                          <StarRating
                            rating={userRating}
                            setRating={() => {}}
                            disabled={true}
                          />
                          <span className="ml-2 text-sm text-green-600">
                            ¡Gracias por tu valoración!
                          </span>
                        </div>
                      ) : (
                        <div className="flex flex-col">
                          <div className="flex items-center">
                            <StarRating
                              rating={userRating}
                              setRating={handleRatingChange}
                              disabled={submittingRating}
                            />
                            {submittingRating && (
                              <span className="ml-2 text-sm text-gray-600">
                                Enviando...
                              </span>
                            )}
                          </div>
                          {!submittingRating && !ratingSubmitted && (
                            <span className="text-sm text-gray-600 mt-1">
                              {totalRatings > 0
                                ? "Haz clic para valorar"
                                : "Sé el primero en valorar este producto"}
                            </span>
                          )}
                          {ratingSubmitted && (
                            <span className="text-sm text-green-600 mt-1">
                              ¡Gracias por tu valoración!
                            </span>
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              </div>

              <div className="text-3xl font-bold text-blue-600 mb-6">
                {product.price}€
              </div>

              <div className="bg-gray-50 rounded-lg p-4 mb-6">
                <h3 className="font-semibold mb-2">Ubicación</h3>
                <p className="flex items-center text-gray-700">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    className="mr-2 text-gray-500"
                  >
                    <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                  </svg>
                  {product.cityName}, {product.provinceName},{" "}
                  {product.countryName}
                </p>
              </div>

              <div className="mb-6">
                <h3 className="font-semibold mb-2">Descripción</h3>
                <div className="text-gray-700 prose max-w-none">
                  {product.description}
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4 mb-6">
                <div className="bg-gray-50 rounded-lg p-4">
                  <h4 className="text-sm font-medium text-gray-500 mb-1">
                    Peso
                  </h4>
                  <p className="text-gray-900">
                    {product.weight
                      ? `${product.weight} kg`
                      : "No especificado"}
                  </p>
                </div>
                <div className="bg-gray-50 rounded-lg p-4">
                  <h4 className="text-sm font-medium text-gray-500 mb-1">
                    Dimensiones
                  </h4>
                  <p className="text-gray-900">
                    {product.dimensions || "No especificado"}
                  </p>
                </div>
                <div className="bg-gray-50 rounded-lg p-4">
                  <h4 className="text-sm font-medium text-gray-500 mb-1">
                    Fecha de fabricación
                  </h4>
                  <p className="text-gray-900">
                    {product.dateManufactured
                      ? new Date(product.dateManufactured).toLocaleDateString()
                      : "No especificado"}
                  </p>
                </div>
                <div className="bg-gray-50 rounded-lg p-4">
                  <h4 className="text-sm font-medium text-gray-500 mb-1">
                    Garantía restante
                  </h4>
                  <p className="text-gray-900">
                    {product.remainingWarranty || "No especificado"}
                  </p>
                </div>
              </div>

              <div className="space-y-4">
                <button 
                  onClick={() => {
                    // Añadir al carrito utilizando la tienda de Zustand
                    const { addItem } = useCartStore.getState();
                    addItem({
                      documentId: String(product.documentId || product.id),
                      productName: product.productName,
                      price: Number(product.price) || 0,
                      quantity: 1,
                      slug: product.slug,
                      imageUrl: product.images?.[0]?.url ? `${process.env.NEXT_PUBLIC_BACKEND_URL}${product.images[0].url}` : undefined
                    });
                    toast.success('¡Producto añadido al carrito!');
                  }}
                  className="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-6 rounded-lg transition-colors flex items-center justify-center gap-2"
                >
                  <ShoppingCart className="h-5 w-5" />
                  Añadir al carrito
                </button>
                <button 
                  onClick={handleToggleFavorite}
                  disabled={processingFavorite}
                  className={`w-full ${isFavorite ? 'bg-pink-100 hover:bg-pink-200 text-pink-800' : 'bg-gray-100 hover:bg-gray-200 text-gray-800'} font-medium py-3 px-6 rounded-lg transition-colors flex items-center justify-center ${processingFavorite ? 'opacity-70 cursor-not-allowed' : ''}`}
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill={isFavorite ? "currentColor" : "none"}
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    className="mr-2"
                  >
                    <path d="M20.42 4.58a5.4 5.4 0 0 0-7.65 0l-.77.78-.77-.78a5.4 5.4 0 0 0-7.65 0C1.46 6.7 1.33 10.28 4 13l8 8 8-8c2.67-2.72 2.54-6.3.42-8.42z"></path>
                  </svg>
                  {isFavorite ? 'Quitar de favoritos' : 'Añadir a favoritos'}
                </button>
                
                {/* Sistema de Likes y Dislikes */}
                <div className="mt-4 border-t pt-4">
                  <h3 className="text-lg font-semibold mb-2">¿Te gusta este producto?</h3>
                  <ReactionButtons productId={product.id} productDocumentId={product.documentId} />
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Mapa del producto */}
        <div className="bg-white rounded-lg shadow-md p-6 mb-8">
          <h2 className="text-xl font-bold mb-4">Ubicación del producto</h2>
          <div className="w-full h-96 rounded-lg overflow-hidden">
            {product.latitud && product.longitud ? (
              <ProductMap
                products={[product]}
                height="400px"
                singleProduct={true}
                zoom={14}
              />
            ) : (
              <div className="w-full h-96 bg-gray-100 flex items-center justify-center">
                <div className="text-center p-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    className="mx-auto mb-4 text-gray-400"
                  >
                    <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                  </svg>
                  <p>
                    No hay información de ubicación disponible para este
                    producto.
                  </p>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Información adicional - Pestañas */}
        <div className="bg-white rounded-lg shadow-md p-6 mb-8">
          <div className="border-b border-gray-200 mb-6">
            <button className="pb-4 border-b-2 border-blue-600 font-medium mr-8">
              Especificaciones
            </button>
            <button className="pb-4 text-gray-500 hover:text-gray-800 font-medium">
              Envío
            </button>
          </div>

          <div>
            <table className="w-full text-left">
              <tbody>
                {product.brands?.[0] && (
                  <tr className="border-b border-gray-100">
                    <th className="py-3 text-gray-500 pr-4 w-1/3">Marca</th>
                    <td className="py-3">{product.brands[0].brandName}</td>
                  </tr>
                )}
                {product.state && (
                  <tr className="border-b border-gray-100">
                    <th className="py-3 text-gray-500 pr-4 w-1/3">Estado</th>
                    <td className="py-3">{product.state}</td>
                  </tr>
                )}
                {product.dimensions && (
                  <tr className="border-b border-gray-100">
                    <th className="py-3 text-gray-500 pr-4 w-1/3">
                      Dimensiones
                    </th>
                    <td className="py-3">{product.dimensions}</td>
                  </tr>
                )}
                {product.weight && (
                  <tr className="border-b border-gray-100">
                    <th className="py-3 text-gray-500 pr-4 w-1/3">Peso</th>
                    <td className="py-3">{product.weight} kg</td>
                  </tr>
                )}
                {product.dateManufactured && (
                  <tr className="border-b border-gray-100">
                    <th className="py-3 text-gray-500 pr-4 w-1/3">
                      Fecha de fabricación
                    </th>
                    <td className="py-3">
                      {new Date(product.dateManufactured).toLocaleDateString()}
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>

        {/* Productos imprescindibles */}
        <div className="mt-12 mb-12">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-bold">{getEssentialsTitle()}</h2>

            {/* Solo mostrar paginación si hay más de una página */}
            {totalEssentialsPages > 1 && (
              <div className="flex items-center space-x-2">
                <button
                  onClick={() => handleEssentialsPageChange(essentialsPage - 1)}
                  disabled={essentialsPage <= 1 || loadingEssentials}
                  className={`px-3 py-1 rounded ${
                    essentialsPage <= 1 || loadingEssentials
                      ? "bg-gray-200 text-gray-500 cursor-not-allowed"
                      : "bg-gray-200 text-gray-700 hover:bg-gray-300"
                  }`}
                >
                  Anterior
                </button>

                <span className="text-sm">
                  Página {essentialsPage} de {totalEssentialsPages}
                </span>

                <button
                  onClick={() => handleEssentialsPageChange(essentialsPage + 1)}
                  disabled={
                    essentialsPage >= totalEssentialsPages || loadingEssentials
                  }
                  className={`px-3 py-1 rounded ${
                    essentialsPage >= totalEssentialsPages || loadingEssentials
                      ? "bg-gray-200 text-gray-500 cursor-not-allowed"
                      : "bg-gray-200 text-gray-700 hover:bg-gray-300"
                  }`}
                >
                  Siguiente
                </button>
              </div>
            )}
          </div>

          <ProductGrid
            products={currentEssentialProducts}
            loading={loadingEssentials}
            emptyMessage={
              loadingEssentials
                ? "Cargando productos imprescindibles..."
                : "No se encontraron productos imprescindibles relacionados."
            }
          />
        </div>

        {/* Productos relacionados */}
        <div className="mt-12">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-bold">Productos relacionados</h2>

            {/* Solo mostrar paginación si hay más de una página */}
            {totalRelatedPages > 1 && (
              <div className="flex items-center space-x-2">
                <button
                  onClick={() => handleRelatedPageChange(relatedPage - 1)}
                  disabled={relatedPage <= 1 || loadingRelated}
                  className={`px-3 py-1 rounded ${
                    relatedPage <= 1 || loadingRelated
                      ? "bg-gray-200 text-gray-500 cursor-not-allowed"
                      : "bg-gray-200 text-gray-700 hover:bg-gray-300"
                  }`}
                >
                  Anterior
                </button>

                <span className="text-sm">
                  Página {relatedPage} de {totalRelatedPages}
                </span>

                <button
                  onClick={() => handleRelatedPageChange(relatedPage + 1)}
                  disabled={relatedPage >= totalRelatedPages || loadingRelated}
                  className={`px-3 py-1 rounded ${
                    relatedPage >= totalRelatedPages || loadingRelated
                      ? "bg-gray-200 text-gray-500 cursor-not-allowed"
                      : "bg-gray-200 text-gray-700 hover:bg-gray-300"
                  }`}
                >
                  Siguiente
                </button>
              </div>
            )}
          </div>

          <ProductGrid
            products={currentRelatedProducts}
            loading={loadingRelated}
            emptyMessage={
              loadingRelated
                ? "Cargando productos relacionados..."
                : "No se encontraron productos relacionados."
            }
          />
        </div>
      </div>
    </main>
  );
}
