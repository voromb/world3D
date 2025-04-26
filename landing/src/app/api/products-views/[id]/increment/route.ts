// src/app/api/products-views/[id]/increment/route.ts

import { NextRequest, NextResponse } from "next/server";
import {
  incrementProductViews,
  findProductBySlugOrId,
} from "@/lib/graphql/utils";

export async function POST(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Esperamos los parámetros dinámicos (requerido en Next.js 14+)
    const params = await Promise.resolve(context.params);
    const idFromUrl = params.id;

    // Mapeo de IDs numéricos a slugs - extraido del frontend
    const ID_TO_SLUG_MAP: Record<string, string> = {
      "205": "creality-halot-one-plus",
      "206": "anycubic-photon-mono-x-6k",
      "207": "elegoo-mars-3",
      "211": "ultimaker-s5-pro",
      "213": "voxelab-proxima-6-0",
    };

    // Si el ID es numérico y está en nuestro mapeo, usar el slug correspondiente
    let productIdOrSlug = idFromUrl;
    if (ID_TO_SLUG_MAP[idFromUrl]) {
      console.log(
        `ID numérico ${idFromUrl} mapeado a slug: ${ID_TO_SLUG_MAP[idFromUrl]}`
      );
      productIdOrSlug = ID_TO_SLUG_MAP[idFromUrl];
    }

    // Intentar obtener datos adicionales del cuerpo de la solicitud
    let productData = null;
    try {
      const body = await request.json();
      if (body && body.product) {
        productData = body.product;
        console.log("Datos del producto recibidos del cliente:", productData);
      }
    } catch (e) {
      // Si no hay cuerpo JSON o está mal formateado, continuamos con el ID de la URL
      console.log("No se recibieron datos adicionales del producto");
    }

    try {
      // Utilizar la función compartida para incrementar vistas usando el objeto completo si está disponible
      const result = await incrementProductViews(
        productData || productIdOrSlug
      );

      if (result.incremented) {
        return NextResponse.json({
          success: true,
          message: result.message,
          views: result.views,
          lastUpdated: new Date().toISOString(),
        });
      } else {
        // Si no hubo incremento, obtener datos actuales del producto
        const fetchedProductData = await findProductBySlugOrId(
          productData || productIdOrSlug
        );

        if (!fetchedProductData) {
          return NextResponse.json(
            {
              error: "Producto no encontrado",
              status: 404,
            },
            { status: 404 }
          );
        }

        return NextResponse.json({
          success: true,
          message: result.message,
          views: productData.views || 0,
          lastUpdated: new Date().toISOString(),
        });
      }
    } catch (error: any) {
      // Si el error es que no se encontró el producto
      if (error.message === "Producto no encontrado") {
        return NextResponse.json(
          {
            error: "Producto no encontrado",
            status: 404,
          },
          { status: 404 }
        );
      }

      // Otros errores durante la actualización
      console.error("Error al incrementar vistas:", error);
      return NextResponse.json(
        {
          error: "Error al actualizar vistas en Strapi",
          status: 500,
        },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error("Error general al procesar la petición:", error);
    return NextResponse.json(
      {
        error: "Error general al incrementar vistas",
        status: 500,
      },
      { status: 500 }
    );
  }
}
