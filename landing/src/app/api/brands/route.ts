// src/app/api/brands/route.ts

import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const slug = searchParams.get("slug");

    // URL base
    let apiUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/brands?populate=mainimage`;

    // Si hay un slug específico, filtrar por él
    if (slug) {
      apiUrl += `&filters[slug][$eq]=${encodeURIComponent(slug)}`;
    }

    const response = await fetch(apiUrl);

    if (!response.ok) {
      throw new Error(`Error fetching brands: ${response.status}`);
    }

    const data = await response.json();

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch brands", data: [] },
      { status: 500 }
    );
  }
}
