//src/app/api/products/[slug]/route.ts

import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  // Extraer el slug directamente de la URL
  const slug = request.nextUrl.pathname.split('/').pop()?.replace(/\/route$/, '');

  try {
    const res = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?filters[slug][$eq]=${slug}&populate=*`,
      {
        headers: {
          Authorization: `Bearer ${process.env.NEXT_PUBLIC_STRAPI_API_TOKEN}`,
        },
      }
    );

    if (!res.ok) {
      throw new Error(`Error fetching product: ${res.status}`);
    }

    const data = await res.json();

    const product = data.data?.[0];
    if (!product) {
      return NextResponse.json({ error: "Product not found" }, { status: 404 });
    }

    return NextResponse.json(product);
  } catch (error) {
    console.error("Error in product detail API:", error);
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}
