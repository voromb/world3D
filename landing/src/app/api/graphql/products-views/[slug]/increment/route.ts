import { NextRequest, NextResponse } from "next/server";
import { gql } from "graphql-request";
import { findProductBySlugOrId, graphqlRequest } from "../../../client";

// Contador de vistas simulado como respaldo si falla el acceso a Strapi
const simulatedViewsCounter = new Map<string, number>();

// Mutación para actualizar las vistas de un producto
const UPDATE_PRODUCT_VIEWS = gql`
  mutation UpdateProductViews($id: ID!, $views: Int!) {
    updateProduct(
      id: $id
      data: { views: $views }
    ) {
      data {
        id
        attributes {
          views
        }
      }
    }
  }
`;

// Ruta para incrementar el contador de vistas
export async function POST(request: NextRequest, context: { params: { slug: string } }) {
  try {
    // En Next.js 14+, debemos esperar a que los parámetros estén disponibles
    const params = await context.params;
    const slug = params?.slug;
    if (!slug) {
      return NextResponse.json(
        { error: "Se requiere un identificador de producto válido" },
        { status: 400 }
      );
    }

    console.log(`GraphQL: Incrementando vistas para el producto ${slug}`);
    
    // Buscar el producto por slug o ID usando GraphQL
    const product = await findProductBySlugOrId(slug);
    
    if (product) {
      // Producto encontrado en Strapi, actualizamos las vistas con GraphQL
      console.log("GraphQL: Producto encontrado en Strapi con ID real:", product.id);
      
      const currentViews = typeof product.views === 'number' ? product.views : 0;
      const newViews = currentViews + 1;
      
      try {
        // Intentar actualizar las vistas en Strapi con GraphQL
        const updateResult = await graphqlRequest(UPDATE_PRODUCT_VIEWS, {
          id: product.id,
          views: newViews
        }) as { updateProduct?: { data?: { attributes?: { views?: number } } } };
        
        if (updateResult?.updateProduct?.data?.attributes?.views !== undefined) {
          console.log("GraphQL: Vistas actualizadas correctamente en Strapi:", 
            updateResult.updateProduct.data.attributes.views);
          
          return NextResponse.json({
            success: true,
            views: updateResult.updateProduct.data.attributes.views,
            source: "strapi_graphql"
          });
        } else {
          throw new Error("No se pudo actualizar las vistas en Strapi");
        }
      } catch (updateError) {
        console.error("GraphQL: Error al actualizar vistas en Strapi:", updateError);
        // Si falla la actualización, usamos el contador simulado como respaldo
        const counterKey = slug;
        const currentCount = simulatedViewsCounter.get(counterKey) || 0;
        simulatedViewsCounter.set(counterKey, currentCount + 1);
        
        return NextResponse.json({
          success: true,
          views: currentCount + 1,
          source: "simulated_after_error",
          error: "No se pudo actualizar en Strapi, usando contador simulado"
        });
      }
    } else {
      // Producto no encontrado en Strapi, usamos contador simulado
      console.log(`GraphQL: Producto ${slug} no encontrado en Strapi, usando contador simulado`);
      
      const counterKey = slug;
      const currentCount = simulatedViewsCounter.get(counterKey) || 0;
      const newCount = currentCount + 1;
      simulatedViewsCounter.set(counterKey, newCount);
      
      return NextResponse.json({
        success: true,
        views: newCount,
        source: "simulated",
        message: "Producto no encontrado en Strapi, usando contador simulado"
      });
    }
  } catch (error) {
    console.error("GraphQL: Error al incrementar vistas:", error);
    return NextResponse.json(
      { error: "Error interno del servidor al procesar la solicitud" },
      { status: 500 }
    );
  }
}
