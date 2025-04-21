"use client";

import React, { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { ProductType } from "@/types";

interface ProductCardProps {
  product: ProductType;
}

const ProductCard: React.FC<ProductCardProps> = ({ product }) => {
  const images = product.images || [];
  const [currentIndex, setCurrentIndex] = useState(0);

  const handlePrev = () => {
    setCurrentIndex((prev) => (prev === 0 ? images.length - 1 : prev - 1));
  };

  const handleNext = () => {
    setCurrentIndex((prev) => (prev === images.length - 1 ? 0 : prev + 1));
  };

  return (
    <Link
      href={`/shop/${product.slug}`}
      className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow"
    >
      <div className="relative h-60 w-full">
        {images.length > 0 ? (
          <>
            <Image
              src={`${process.env.NEXT_PUBLIC_BACKEND_URL}${images[currentIndex].url}`}
              alt={images[currentIndex].alternativeText || product.productName}
              fill
              className="object-cover"
              sizes="(max-width: 768px) 100vw, 33vw"
            />

            {/* Botones de navegación */}
            {images.length > 1 && (
              <>
                <button
                  onClick={(e) => {
                    e.preventDefault();
                    handlePrev();
                  }}
                  className="absolute top-1/2 left-2 -translate-y-1/2 bg-black bg-opacity-40 text-white p-1 rounded-full hover:bg-opacity-70"
                >
                  ‹
                </button>
                <button
                  onClick={(e) => {
                    e.preventDefault();
                    handleNext();
                  }}
                  className="absolute top-1/2 right-2 -translate-y-1/2 bg-black bg-opacity-40 text-white p-1 rounded-full hover:bg-opacity-70"
                >
                  ›
                </button>
              </>
            )}
          </>
        ) : (
          <div className="absolute inset-0 bg-gray-200 flex items-center justify-center">
            <span className="text-gray-400">Sin imagen</span>
          </div>
        )}

        {product.isFeatured && (
          <div className="absolute top-2 left-2 bg-yellow-500 text-white text-xs font-medium px-2 py-1 rounded">
            Destacado
          </div>
        )}
      </div>

      <div className="p-4">
        <h3
          className="font-semibold text-lg mb-2 line-clamp-2"
          title={product.productName}
        >
          {product.productName}
        </h3>

        <div className="flex justify-between items-center mb-2">
          <span className="text-blue-600 font-bold">{product.price}€</span>
          <span className="text-sm text-gray-500">{product.cityName}</span>
        </div>

        <div className="flex flex-wrap gap-1">
          {product.categories?.map((category) => (
            <span
              key={category.id}
              className="inline-block bg-gray-100 text-gray-800 text-xs px-2 py-1 rounded"
            >
              {category.categoryName}
            </span>
          ))}

          {product.brands?.[0] && (
            <span className="inline-block bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded">
              {product.brands[0].brandName}
            </span>
          )}
        </div>
      </div>
    </Link>
  );
};

export default ProductCard;
