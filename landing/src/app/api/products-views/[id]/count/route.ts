// src/app/api/products-views/[id]/count/route.ts

import { NextRequest, NextResponse } from "next/server";
import { findProductBySlugOrId } from "@/lib/graphql/utils";

export async function GET(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Acceder a los parámetros de forma asíncrona
    const params = await Promise.resolve(context.params);

    if (!params || !params.id) {
      return NextResponse.json(
        { error: "Se requiere un identificador de producto válido" },
        { status: 400 }
      );
    }

    const productId = params.id;

    // Usar la función compartida para buscar el producto
    const productData = await findProductBySlugOrId(productId);

    if (!productData) {
      return NextResponse.json(
        { error: "Producto no encontrado" },
        { status: 404 }
      );
    }

    // Si encontramos el producto, devolvemos las vistas
    const views = productData.views || 0;

    return NextResponse.json({
      success: true,
      views: views,
    });
  } catch (error) {
    console.error("Error al obtener vistas:", error);

    return NextResponse.json(
      { error: "Error al obtener vistas", views: 0 },
      { status: 500 }
    );
  }
}
