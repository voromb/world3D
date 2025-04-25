'use client';

import React from 'react';

interface CityFilterProps {
  cities: string[];
  selectedCity: string;
  onChange: (city: string) => void;
}

const CityFilter: React.FC<CityFilterProps> = ({
  cities,
  selectedCity,
  onChange
}) => {
  return (
    <div className="space-y-2">
      <h3 className="font-medium text-gray-900">Ciudades</h3>
      
      <select
        value={selectedCity}
        onChange={(e) => onChange(e.target.value)}
        className="w-full p-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
      >
        <option value="">Todas las ciudades</option>
        {cities.map((city, index) => (
          <option key={index} value={city}>
            {city}
          </option>
        ))}
      </select>
    </div>
  );
};

export default CityFilter;