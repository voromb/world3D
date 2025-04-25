// src/app/api/products/route.ts

import { NextRequest, NextResponse } from "next/server";
import { queryStringToFilters } from "@/lib/utils/filterUtils";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const filters = queryStringToFilters(searchParams.toString());

    // URL base siempre con populate
    let apiUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?populate=*`;

    // Paginación
    const page = searchParams.get("page") || "1";
    apiUrl += `&pagination[page]=${page}&pagination[pageSize]=12`;

    // Búsqueda simple - solo busca en el nombre del producto
    if (filters.search) {
      apiUrl += `&filters[productName][$containsi]=${encodeURIComponent(
        filters.search
      )}`;
      console.log(`Búsqueda simple por: "${filters.search}"`);
    }

    // Filtro de categoría
    if (filters.category) {
      apiUrl += `&filters[categories][slug][$eq]=${encodeURIComponent(
        filters.category
      )}`;
    }

    // Filtro de marca
    if (filters.brand) {
      apiUrl += `&filters[brands][slug][$eq]=${encodeURIComponent(
        filters.brand
      )}`;
    }

    // Filtro de ciudad
    if (filters.city) {
      apiUrl += `&filters[cityName][$eq]=${encodeURIComponent(filters.city)}`;
    }

    // Filtro de precio
    if (filters.price) {
      if (filters.price.endsWith("+")) {
        const min = filters.price.slice(0, -1);
        apiUrl += `&filters[price][$gte]=${min}`;
      } else {
        const [min, max] = filters.price.split("-");
        if (min) apiUrl += `&filters[price][$gte]=${min}`;
        if (max) apiUrl += `&filters[price][$lte]=${max}`;
      }
    }

    // Ordenación
    const sort = searchParams.get("sort") || "createdAt:desc";
    apiUrl += `&sort=${sort}`;

    console.log("URL final:", apiUrl);

    const response = await fetch(apiUrl);

    if (!response.ok) {
      throw new Error(`Error fetching products: ${response.status}`);
    }

    const data = await response.json();
    return NextResponse.json(data);
  } catch (error) {
    console.error("Error en productos:", error);
    return NextResponse.json(
      {
        error:
          error instanceof Error ? error.message : "Failed to fetch products",
        data: [],
      },
      { status: 500 }
    );
  }
}
