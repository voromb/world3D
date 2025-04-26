// src/app/api/product-ratings/[id]/rate/route.ts

import { NextRequest, NextResponse } from "next/server";
import { updateProductViewsGraphQL, submitRatingGraphQL, ID_TO_SLUG_MAP } from "@/lib/graphql";

export async function POST(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Extraemos la valoración de la solicitud
    const { rating } = await request.json();

    // Esperamos los parámetros dinámicos (requerido en Next.js 14+)
    const params = await Promise.resolve(context.params);
    const idFromUrl = params.id;

    if (!idFromUrl) {
      return NextResponse.json(
        { error: "Se requiere un identificador de producto válido" },
        { status: 400 }
      );
    }

    // Si el ID es numérico y está en nuestro mapeo, usar el slug correspondiente
    let productIdOrSlug = idFromUrl;
    if (ID_TO_SLUG_MAP[idFromUrl]) {
      console.log(
        `ID numérico ${idFromUrl} mapeado a slug: ${ID_TO_SLUG_MAP[idFromUrl]}`
      );
      productIdOrSlug = ID_TO_SLUG_MAP[idFromUrl];
    }

    // Guardamos la valoración para tenerla disponible en todo el ámbito
    const ratingValue = Number(rating);

    try {
      // Utilizamos la función importada submitRatingGraphQL para procesar la valoración
      const result = await submitRatingGraphQL(productIdOrSlug, ratingValue);

      return NextResponse.json({
        success: true,
        message: "Valoración guardada correctamente",
        averageRating: result.averageRating,
        totalRatings: result.totalRatings,
      });
    } catch (error: any) {
      if (error.message === "Producto no encontrado") {
        return NextResponse.json(
          {
            error: "Producto no encontrado",
            status: 404,
          },
          { status: 404 }
        );
      }

      if (error.message === "La valoración debe ser un número entre 1 y 5") {
        return NextResponse.json(
          {
            error: "La valoración debe ser un número entre 1 y 5",
            status: 400,
          },
          { status: 400 }
        );
      }

      console.error("Error al procesar valoración:", error);
      return NextResponse.json(
        {
          error: "Error al procesar la valoración",
          status: 500,
        },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error("Error general al procesar la petición:", error);
    return NextResponse.json(
      {
        error: "Error al procesar la valoración",
        status: 500,
      },
      { status: 500 }
    );
  }
}
