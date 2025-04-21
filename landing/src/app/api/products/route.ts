// src/app/api/products/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { fetchProducts } from '@/lib/api/fetchProducts';
import { queryStringToFilters } from '@/lib/utils/filterUtils';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);

    const filters = queryStringToFilters(searchParams.toString());

    const productsResponse = await fetchProducts(filters);

    return NextResponse.json(productsResponse);
  } catch (error) {
    console.error('Error in products API route:', error);
    return NextResponse.json(
      { error: 'Failed to fetch products', data: [] },
      { status: 500 }
    );
  }
}
