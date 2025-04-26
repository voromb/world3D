
//src/app/lib/graphqlClient.ts
// Actualiza las vistas de un producto utilizando GraphQL
export async function updateProductViewsGraphQL(productIdentifier: string): Promise<number> {
  try {
    console.log("GraphQL: Intentando actualizar vistas para:", productIdentifier);
    
    const response = await fetch(
      `/api/graphql/products-views/${productIdentifier}/increment`,
      {
        method: "POST",
        headers: {
          'X-Request-ID': `${Date.now()}-${Math.random()}`,
        }
      }
    );
    
    if (response.ok) {
      const data = await response.json();
      console.log("GraphQL: Respuesta del incremento de vistas:", data);
      return data.views;
    } else {
      console.error("GraphQL: Error en el incremento de vistas:", response.status);
      throw new Error(`Error en la respuesta: ${response.status}`);
    }
  } catch (error) {
    console.error("GraphQL: Error al actualizar vistas:", error);
    throw error;
  }
}

// Envía una valoración para un producto utilizando GraphQL
export async function submitRatingGraphQL(
  productIdentifier: string, 
  rating: number
): Promise<{ averageRating: number; totalRatings: number }> {
  try {
    console.log(`GraphQL: Enviando valoración ${rating} para:`, productIdentifier);
    
    const response = await fetch(`/api/graphql/product-ratings/${productIdentifier}/rate`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ rating }),
    });
    
    if (response.ok) {
      const data = await response.json();
      console.log("GraphQL: Respuesta de la valoración:", data);
      return {
        averageRating: data.averageRating,
        totalRatings: data.totalRatings
      };
    } else {
      console.error("GraphQL: Error en la valoración:", response.status);
      throw new Error(`Error en la respuesta: ${response.status}`);
    }
  } catch (error) {
    console.error("GraphQL: Error al enviar valoración:", error);
    throw error;
  }
}
