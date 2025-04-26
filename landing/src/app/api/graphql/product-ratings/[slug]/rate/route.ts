import { NextRequest, NextResponse } from "next/server";
import { gql } from "graphql-request";
import { findProductBySlugOrId, graphqlRequest } from "../../../client";

// Simulación de valoraciones como respaldo
const simulatedRatings = new Map<string, { count: number; sum: number }>();

// Mutación para crear una valoración
const CREATE_RATING = gql`
  mutation CreateRating($productId: ID!, $rating: Int!) {
    createRating(
      data: { 
        rating: $rating, 
        product: { connect: { id: $productId } } 
      }
    ) {
      data {
        id
        attributes {
          rating
        }
      }
    }
  }
`;

// Mutación para actualizar el producto con la valoración media
const UPDATE_PRODUCT_RATING = gql`
  mutation UpdateProductRating($id: ID!, $averageRating: Float!, $totalRatings: Int!) {
    updateProduct(
      id: $id, 
      data: { 
        averageRating: $averageRating, 
        totalRatings: $totalRatings 
      }
    ) {
      data {
        id
        attributes {
          averageRating
          totalRatings
        }
      }
    }
  }
`;

// Consulta para obtener todas las valoraciones de un producto
const GET_PRODUCT_RATINGS = gql`
  query GetProductRatings($productId: ID!) {
    ratings(filters: { product: { id: { eq: $productId } } }) {
      data {
        id
        attributes {
          rating
        }
      }
    }
  }
`;

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

    // Extraer la valoración del cuerpo de la solicitud
    const body = await request.json();
    const rating = body.rating;

    if (typeof rating !== "number" || rating < 1 || rating > 5) {
      return NextResponse.json(
        { error: "La valoración debe ser un número entre 1 y 5" },
        { status: 400 }
      );
    }

    console.log(`GraphQL: Enviando valoración de ${rating} para el producto ${slug}`);

    // Buscar el producto por slug o ID usando GraphQL
    const product = await findProductBySlugOrId(slug);

    if (product) {
      console.log("GraphQL: Producto encontrado en Strapi con ID real:", product.id);
      
      try {
        // 1. Crear una nueva valoración
        const createRatingResult = await graphqlRequest(CREATE_RATING, {
          productId: product.id,
          rating: rating
        }) as { createRating?: { data?: { id?: string } } };

        if (!createRatingResult?.createRating?.data?.id) {
          throw new Error("No se pudo crear la valoración");
        }

        // 2. Obtener todas las valoraciones para calcular el promedio
        const ratingsResult = await graphqlRequest(GET_PRODUCT_RATINGS, {
          productId: product.id
        }) as { ratings?: { data?: Array<{attributes?: {rating: number}}> } };

        const ratings = ratingsResult?.ratings?.data || [];
        const totalRatings = ratings.length;
        let ratingSum = 0;

        // Calcular la suma de valoraciones
        ratings.forEach((ratingItem: any) => {
          ratingSum += ratingItem.attributes.rating;
        });

        // Calcular la valoración media
        const averageRating = totalRatings > 0 ? ratingSum / totalRatings : 0;

        // 3. Actualizar el producto con la nueva valoración media
        const updateResult = await graphqlRequest(UPDATE_PRODUCT_RATING, {
          id: product.id,
          averageRating: parseFloat(averageRating.toFixed(1)),
          totalRatings: totalRatings
        }) as { updateProduct?: { data?: { attributes?: { averageRating?: number, totalRatings?: number } } } };

        if (updateResult?.updateProduct?.data?.attributes) {
          console.log("GraphQL: Valoración guardada y promedio actualizado correctamente");
          return NextResponse.json({
            success: true,
            averageRating: updateResult.updateProduct.data.attributes.averageRating,
            totalRatings: updateResult.updateProduct.data.attributes.totalRatings,
            source: "strapi_graphql"
          });
        } else {
          throw new Error("No se pudo actualizar la valoración media");
        }
      } catch (updateError) {
        console.error("GraphQL: Error al guardar valoración en Strapi:", updateError);
        
        // Si falla, usamos valoración simulada como respaldo
        const ratingKey = slug;
        const currentRating = simulatedRatings.get(ratingKey) || { count: 0, sum: 0 };
        
        currentRating.count += 1;
        currentRating.sum += rating;
        
        simulatedRatings.set(ratingKey, currentRating);
        
        const averageRating = currentRating.sum / currentRating.count;
        
        return NextResponse.json({
          success: true,
          averageRating: parseFloat(averageRating.toFixed(1)),
          totalRatings: currentRating.count,
          source: "simulated_after_error",
          error: "No se pudo guardar en Strapi, usando valoración simulada"
        });
      }
    } else {
      // Producto no encontrado, usamos valoración simulada
      console.log(`GraphQL: Producto ${slug} no encontrado en Strapi, usando valoración simulada`);
      
      const ratingKey = slug;
      const currentRating = simulatedRatings.get(ratingKey) || { count: 0, sum: 0 };
      
      currentRating.count += 1;
      currentRating.sum += rating;
      
      simulatedRatings.set(ratingKey, currentRating);
      
      const averageRating = currentRating.sum / currentRating.count;
      
      return NextResponse.json({
        success: true,
        averageRating: parseFloat(averageRating.toFixed(1)),
        totalRatings: currentRating.count,
        source: "simulated",
        message: "Producto no encontrado en Strapi, usando valoración simulada"
      });
    }
  } catch (error) {
    console.error("GraphQL: Error al procesar la valoración:", error);
    return NextResponse.json(
      { error: "Error interno del servidor al procesar la solicitud" },
      { status: 500 }
    );
  }
}
