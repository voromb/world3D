"use client";

import React, { useEffect, useState } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { ProductType } from "@/types";
import ProductGrid from "@/components/ui/product/ProductGrid";

// Función auxiliar para generar URLs de imágenes completas
const getImageUrl = (imagePath: string): string => {
  if (!imagePath) return "/placeholder.jpg";
  if (imagePath.startsWith("http")) return imagePath;
  return `${process.env.NEXT_PUBLIC_BACKEND_URL}${imagePath}`;
};

export default function ProductDetailPage() {
  const params = useParams();
  const slug = params?.slug as string;

  const [loading, setLoading] = useState(true);
  const [product, setProduct] = useState<ProductType | null>(null);
  const [relatedProducts, setRelatedProducts] = useState<ProductType[]>([]);
  const [selectedImage, setSelectedImage] = useState(0);

  useEffect(() => {
    const fetchProductData = async () => {
      if (!slug) return;

      setLoading(true);

      try {
        // Obtener producto
        const productResponse = await fetch(`/api/products/${slug}`);

        if (!productResponse.ok) {
          throw new Error("Product not found");
        }

        const productData = await productResponse.json();
        setProduct(productData);

        // Obtener productos relacionados si hay categoría
        if (productData?.categories?.[0]) {
          const categorySlug = productData.categories[0].slug;
          const relatedResponse = await fetch(
            `/api/products?category=${categorySlug}&exclude=${productData.id}&limit=4`
          );
          const relatedData = await relatedResponse.json();
          setRelatedProducts(relatedData.data || []);
        }

        setLoading(false);
      } catch (error) {
        console.error("Error fetching product:", error);
        setProduct(null);
        setLoading(false);
      }
    };

    fetchProductData();
  }, [slug]);

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
                        e.currentTarget.src = "/placeholder.jpg";
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
                              e.currentTarget.src = "/placeholder.jpg";
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

              <div className="flex items-center mb-4">
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
                <button className="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-6 rounded-lg transition-colors">
                  Contactar con el vendedor
                </button>
                <button className="w-full bg-gray-100 hover:bg-gray-200 text-gray-800 font-medium py-3 px-6 rounded-lg transition-colors flex items-center justify-center">
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
                    className="mr-2"
                  >
                    <path d="M20.42 4.58a5.4 5.4 0 0 0-7.65 0l-.77.78-.77-.78a5.4 5.4 0 0 0-7.65 0C1.46 6.7 1.33 10.28 4 13l8 8 8-8c2.67-2.72 2.54-6.3.42-8.42z"></path>
                  </svg>
                  Añadir a favoritos
                </button>
              </div>
            </div>
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

        {/* Productos relacionados */}
        {relatedProducts.length > 0 && (
          <div className="mt-12">
            <h2 className="text-2xl font-bold mb-6">Productos relacionados</h2>
            <ProductGrid products={relatedProducts} />
          </div>
        )}
      </div>
    </main>
  );
}
