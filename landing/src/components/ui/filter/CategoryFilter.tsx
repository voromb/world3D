'use client';

import React from 'react';
import { CategoryType } from '@/types';

interface CategoryFilterProps {
  categories: CategoryType[];
  selectedCategory: string;
  onChange: (category: string) => void;
}

const CategoryFilter: React.FC<CategoryFilterProps> = ({
  categories,
  selectedCategory,
  onChange
}) => {
  return (
    <div className="space-y-2">
      <h3 className="font-medium text-gray-900">Categorías</h3>
      
      <div className="flex flex-col space-y-1">
        <label className="flex items-center cursor-pointer">
          <input
            type="radio"
            name="category"
            value=""
            checked={selectedCategory === ''}
            onChange={() => onChange('')}
            className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
          />
          <span className="ml-2 text-gray-700">Todas las categorías</span>
        </label>
        
        {categories.map((category) => (
          <label key={category.id} className="flex items-center cursor-pointer">
            <input
              type="radio"
              name="category"
              value={category.slug}
              checked={selectedCategory === category.slug}
              onChange={() => onChange(category.slug)}
              className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
            />
            <span className="ml-2 text-gray-700">{category.categoryName}</span>
          </label>
        ))}
      </div>
    </div>
  );
};

export default CategoryFilter;