//src/components/ui/filter/FilterBar.tsx

"use client";

import React, { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { FilterType, CategoryType } from "@/types";
import {
  getPriceRangeOptions,
  getSortOptions,
  filtersToQueryString,
} from "@/lib/utils/filterUtils";

interface FilterBarProps {
  categories: CategoryType[];
  cities: string[];
  brands?: { id: number; brandName: string; slug: string }[];
  initialFilters: FilterType;
  className?: string;
}

const FilterBar: React.FC<FilterBarProps> = ({
  categories,
  cities,
  brands = [],
  initialFilters,
  className = "",
}) => {
  const router = useRouter();
  const [filters, setFilters] = useState<FilterType>(initialFilters);

  // Estado para mantener múltiples selecciones
  const [selectedCategories, setSelectedCategories] = useState<string[]>(
    initialFilters.category ? initialFilters.category.split(",") : []
  );
  const [selectedBrands, setSelectedBrands] = useState<string[]>(
    initialFilters.brand ? initialFilters.brand.split(",") : []
  );
  const [selectedCities, setSelectedCities] = useState<string[]>(
    initialFilters.city ? initialFilters.city.split(",") : []
  );

  // Estado para el slider de precio (un solo valor para el máximo)
  const [priceValue, setPriceValue] = useState<number>(5000);
  const [selectedShipping, setSelectedShipping] = useState<string>(
    initialFilters.shipping || ""
  );

  // Opciones
  const priceOptions = getPriceRangeOptions(); // Not currently used in render but maybe needed for logic
  const sortOptions = getSortOptions();
  const shippingOptions = [
    { label: "Todos los tipos", value: "" },
    { label: "Envío gratuito", value: "free" },
    { label: "Envío express", value: "express" },
    { label: "Recogida en tienda", value: "pickup" },
  ];

  // --- Lógica de los handlers (sin cambios) ---
  useEffect(() => {
    if (initialFilters.price) {
      const priceFilter = initialFilters.price;
      if (priceFilter.endsWith("+")) {
        const min = parseInt(priceFilter.slice(0, -1));
        setPriceValue(min);
      } else if (priceFilter.includes("-")) {
        const [min, max] = priceFilter.split("-").map((p) => parseInt(p));
        if (!isNaN(max)) {
          setPriceValue(max);
        }
      }
    }
  }, [initialFilters.price]);

  const handleCategoryChange = (slug: string) => {
    let newCategories;
    if (selectedCategories.includes(slug)) {
      newCategories = selectedCategories.filter((c) => c !== slug);
    } else {
      newCategories = [...selectedCategories, slug];
    }
    setSelectedCategories(newCategories);
    const newFilters = { ...filters };
    if (newCategories.length > 0) newFilters.category = newCategories.join(",");
    else delete newFilters.category;
    setFilters(newFilters);
  };

  const handleBrandChange = (slug: string) => {
    let newBrands;
    if (selectedBrands.includes(slug)) {
      newBrands = selectedBrands.filter((b) => b !== slug);
    } else {
      newBrands = [...selectedBrands, slug];
    }
    setSelectedBrands(newBrands);
    const newFilters = { ...filters };
    if (newBrands.length > 0) newFilters.brand = newBrands.join(",");
    else delete newFilters.brand;
    setFilters(newFilters);
  };

  const handleCityChange = (city: string) => {
    let newCities;
    if (selectedCities.includes(city)) {
      newCities = selectedCities.filter((c) => c !== city);
    } else {
      newCities = [...selectedCities, city];
    }
    setSelectedCities(newCities);
    const newFilters = { ...filters };
    if (newCities.length > 0) newFilters.city = newCities.join(",");
    else delete newFilters.city;
    setFilters(newFilters);
  };

  const handlePriceChange = (value: number) => {
    setPriceValue(value);
    const newFilters = { ...filters };
    if (value === 5000) delete newFilters.price;
    else newFilters.price = `0-${value}`;
    setFilters(newFilters);
  };

  const handleShippingChange = (value: string) => {
    setSelectedShipping(value);
    const newFilters = { ...filters };
    if (value) newFilters.shipping = value;
    else delete newFilters.shipping;
    setFilters(newFilters);
  };

  const handleFilterChange = (
    key: keyof FilterType,
    value: string | number
  ) => {
    const newFilters = { ...filters, [key]: value, page: 1 };
    setFilters(newFilters);
  };

  const applyFilters = () => {
    const queryString = filtersToQueryString(filters);
    router.push(`/shop?${queryString}`);
  };

  const clearAllFilters = () => {
    setFilters({});
    setSelectedCategories([]);
    setSelectedBrands([]);
    setSelectedCities([]);
    setPriceValue(5000);
    setSelectedShipping("");
    router.push("/shop");
  };
  // --- Fin de la lógica de los handlers ---

  return (
    <div className={`bg-white rounded-lg shadow p-6 ${className}`}>
      {/* --- Título y Botón Limpiar --- */}
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-lg font-medium">Filtros</h3>
        {Object.keys(filters).length > 0 && (
          <button
            onClick={clearAllFilters}
            className="text-sm text-blue-600 hover:text-blue-800"
          >
            Limpiar filtros
          </button>
        )}
      </div>
      {/* --- Contenedor Principal de Filtros --- */}
      <div className="space-y-6">
        {" "}
        {/* Espacio vertical entre filas */}
        {/* --- Fila 1: Categorías | Marcas | Tipo de envío --- */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {/* Categorías */}
          <div>
            <h4 className="font-medium mb-3">Categorías</h4>
            <div className="space-y-2 max-h-48 overflow-y-auto pr-2">
              {categories.map((category) => (
                <div key={category.id} className="flex items-center">
                  <input
                    type="checkbox"
                    id={`category-${category.id}`}
                    checked={selectedCategories.includes(category.slug)}
                    onChange={() => handleCategoryChange(category.slug)}
                    className="mr-2 h-4 w-4 text-blue-600 rounded"
                  />
                  <label
                    htmlFor={`category-${category.id}`}
                    className="text-gray-700 cursor-pointer select-none"
                  >
                    {category.categoryName}
                  </label>
                </div>
              ))}
            </div>
          </div>

          {/* Marcas */}
          <div>
            {" "}
            {/* Ocupa espacio incluso si está vacío para mantener el layout */}
            <h4 className="font-medium mb-3">Marcas</h4>
            {brands.length > 0 ? (
              <div className="space-y-2 max-h-48 overflow-y-auto pr-2">
                {brands.map((brand) => (
                  <div key={brand.id} className="flex items-center">
                    <input
                      type="checkbox"
                      id={`brand-${brand.id}`}
                      checked={selectedBrands.includes(brand.slug)}
                      onChange={() => handleBrandChange(brand.slug)}
                      className="mr-2 h-4 w-4 text-blue-600 rounded"
                    />
                    <label
                      htmlFor={`brand-${brand.id}`}
                      className="text-gray-700 cursor-pointer select-none"
                    >
                      {brand.brandName}
                    </label>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-sm text-gray-500">
                No hay marcas disponibles.
              </p>
            )}
          </div>

          {/* Tipo de envío */}
          <div>
            <h4 className="font-medium mb-3">Tipo de envío</h4>
            <div className="space-y-2">
              {shippingOptions.map((option) => (
                <div key={option.value} className="flex items-center">
                  <input
                    type="radio"
                    id={`shipping-${option.value || "all"}`}
                    name="shipping"
                    checked={selectedShipping === option.value}
                    onChange={() => handleShippingChange(option.value)}
                    className="mr-2 h-4 w-4 text-blue-600"
                  />
                  <label
                    htmlFor={`shipping-${option.value || "all"}`}
                    className="text-gray-700 cursor-pointer select-none"
                  >
                    {option.label}
                  </label>
                </div>
              ))}
            </div>
          </div>
        </div>{" "}
        {/* Fin Fila 1 */}
        {/* --- Fila 2: Slider Precio | Ordenar por --- */}
        {/* Usamos grid-cols-3 para dar más espacio al slider (col-span-2) */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {/* Precio máximo (Slider) - Ocupa 2 de 3 columnas en MD */}
          <div className="md:col-span-2">
            <h4 className="font-medium mb-3">Precio máximo</h4>
            <div className="px-1">
              {" "}
              {/* Ajustado padding si es necesario */}
              <div className="flex justify-between text-sm mb-1">
                <span>0€</span>
                <span className="font-medium">
                  {priceValue === 5000 ? "Sin límite" : `${priceValue}€`}
                </span>
              </div>
              <input
                type="range"
                min="0"
                max="5000"
                step="100"
                value={priceValue}
                onChange={(e) => handlePriceChange(parseInt(e.target.value))}
                className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
              />
              <div className="flex justify-between text-xs text-gray-500 mt-1">
                <span>Min</span>
                <span>Max</span>
              </div>
            </div>
          </div>

          {/* Ordenación - Ocupa 1 de 3 columnas en MD */}
          <div>
            <h4 className="font-medium mb-3">Ordenar por</h4>
            <select
              value={filters.sort || "newest"}
              onChange={(e) => handleFilterChange("sort", e.target.value)}
              className="w-full p-2 border border-gray-300 rounded bg-white"
            >
              {sortOptions.map((option) => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </select>
          </div>
        </div>{" "}
        {/* Fin Fila 2 */}
        {/* --- Ciudades (Sección separada debajo) --- */}
        {cities.length > 0 && (
          <div>
            <h4 className="font-medium mb-3">Ciudad</h4>
            <div className="space-y-2 max-h-48 overflow-y-auto pr-2">
              {cities.map((city) => (
                <div key={city} className="flex items-center">
                  <input
                    type="checkbox"
                    id={`city-${city}`}
                    checked={selectedCities.includes(city)}
                    onChange={() => handleCityChange(city)}
                    className="mr-2 h-4 w-4 text-blue-600 rounded"
                  />
                  <label
                    htmlFor={`city-${city}`}
                    className="text-gray-700 cursor-pointer select-none"
                  >
                    {city}
                  </label>
                </div>
              ))}
            </div>
          </div>
        )}{" "}
        {/* Fin Ciudades */}
      </div>{" "}
      {/* Fin Contenedor Principal de Filtros */}
      {/* --- Botón Aplicar Filtros --- */}
      <button
        onClick={applyFilters}
        className="w-full mt-6 bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition-colors"
      >
        Aplicar filtros
      </button>
    </div>
  );
};

export default FilterBar;