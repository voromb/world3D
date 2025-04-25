'use client';

import React from 'react';
import { getPriceRangeOptions } from '@/lib/utils/filterUtils';

interface PriceFilterProps {
  selectedPrice: string;
  onChange: (price: string) => void;
}

const PriceFilter: React.FC<PriceFilterProps> = ({
  selectedPrice,
  onChange
}) => {
  const priceRangeOptions = getPriceRangeOptions();

  return (
    <div className="space-y-2">
      <h3 className="font-medium text-gray-900">Precio</h3>
      
      <div className="flex flex-col space-y-1">
        {priceRangeOptions.map((option, index) => (
          <label key={index} className="flex items-center cursor-pointer">
            <input
              type="radio"
              name="price"
              value={option.value}
              checked={selectedPrice === option.value}
              onChange={() => onChange(option.value)}
              className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
            />
            <span className="ml-2 text-gray-700">{option.label}</span>
          </label>
        ))}
      </div>
    </div>
  );
};

export default PriceFilter;