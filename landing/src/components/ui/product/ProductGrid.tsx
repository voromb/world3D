'use client';

import React from 'react';
import Link from 'next/link';
import { ProductType } from '@/types';
import ProductCard from './ProductCard';

interface ProductGridProps {
  products: ProductType[] | any;  // Aceptar cualquier tipo para manejar diferentes formatos
  loading?: boolean;
  emptyMessage?: string;
}

const ProductGrid: React.FC<ProductGridProps> = ({
  products,
  loading = false,
  emptyMessage = 'No se encontraron productos'
}) => {
  // Mostrar skeleton mientras carga
  if (loading) {
    return (
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        {Array(8).fill(0).map((_, index) => (
          <div key={index} className="bg-white rounded-lg shadow-md overflow-hidden">
            <div className="h-48 bg-gray-200 animate-pulse"></div>
            <div className="p-4">
              <div className="h-6 bg-gray-200 animate-pulse rounded mb-2"></div>
              <div className="h-4 bg-gray-200 animate-pulse rounded w-1/2 mb-2"></div>
              <div className="h-4 bg-gray-200 animate-pulse rounded w-1/4"></div>
            </div>
          </div>
        ))}
      </div>
    );
  }

  // Validar que products sea un array
  const productArray = Array.isArray(products) ? products : [];
  
  // Si el formato de la API es diferente, intenta extraer los datos
  // const productArray = Array.isArray(products) 
  //   ? products 
  //   : products?.data && Array.isArray(products.data) 
  //     ? products.data 
  //     : [];
  
  // Mostrar mensaje si no hay productos
  if (productArray.length === 0) {
    return (
      <div className="text-center py-12">
        <h2 className="text-xl font-medium text-gray-700 mb-4">
          {emptyMessage}
        </h2>
        <p className="text-gray-500">
          Intenta con otros filtros o{' '}
          <Link href="/shop" className="text-blue-600 hover:underline">
            ver todos los productos
          </Link>
        </p>
      </div>
    );
  }

  // Mostrar productos
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
      {productArray.map((product) => (
        <ProductCard key={product.id} product={product} />
      ))}
    </div>
  );
};

export default ProductGrid;