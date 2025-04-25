// src/components/ui/EmptyState.tsx
"use client";

import React from "react";
import Link from "next/link";
import Image from "next/image";

interface EmptyStateProps {
  message: string;
  showButton?: boolean;
  buttonText?: string;
  buttonLink?: string;
}

const EmptyState: React.FC<EmptyStateProps> = ({
  message,
  showButton = true,
  buttonText = "Ver todos los productos",
  buttonLink = "/shop",
}) => {
  return (
    <div className="flex flex-col items-center justify-center py-12 px-4 text-center">
      <div className="mb-6 relative w-64 h-64">
        <Image
          src="/images/empty-box.svg"
          alt="No hay productos"
          width={256}
          height={256}
          className="opacity-80"
        />
      </div>

      <h3 className="text-xl font-semibold text-gray-800 mb-2">
        No se encontraron productos
      </h3>

      <p className="text-gray-600 mb-6 max-w-md">{message}</p>

      {showButton && (
        <Link
          href={buttonLink}
          className="px-6 py-2.5 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors"
        >
          {buttonText}
        </Link>
      )}
    </div>
  );
};

export default EmptyState;
