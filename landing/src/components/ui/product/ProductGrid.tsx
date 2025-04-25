'use client';

import React from 'react';
import ProductCard from '@/components/ui/product/ProductCard';
import EmptyState from '@/components/ui/EmptyState';
import { ProductType } from '@/types';

interface ProductGridProps {
  products: ProductType[];
  loading?: boolean;
  emptyMessage?: string;
  columns?: number;
}

const ProductGrid: React.FC<ProductGridProps> = ({
  products,
  loading = false,
  emptyMessage = "No se encontraron productos que coincidan con tus filtros. Intenta con otros filtros o ver todos los productos.",
  columns = 3
}) => {
  // Determinar la clase de columnas según el parámetro
  const columnClass = {
    2: 'grid-cols-1 sm:grid-cols-2',
    3: 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3',
    4: 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4'
  }[columns] || 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3';

  // Si está cargando, mostrar placeholders
  if (loading) {
    return (
      <div className={`grid ${columnClass} gap-6`}>
        {Array(6).fill(0).map((_, index) => (
          <div key={index} className="bg-white rounded-lg shadow p-4 animate-pulse">
            <div className="w-full h-48 bg-gray-200 rounded-lg mb-4"></div>
            <div className="h-4 bg-gray-200 rounded mb-2 w-3/4"></div>
            <div className="h-4 bg-gray-200 rounded mb-4 w-1/2"></div>
            <div className="h-8 bg-gray-200 rounded w-1/3"></div>
          </div>
        ))}
      </div>
    );
  }

  // Si no hay productos, mostrar mensaje vacío
  if (products.length === 0) {
    return <EmptyState message={emptyMessage} />;
  }

  // Mostrar la grid de productos
  return (
    <div className={`grid ${columnClass} gap-6`}>
      {products.map((product) => (
        <ProductCard key={product.id} product={product} />
      ))}
    </div>
  );
};

export default ProductGrid;