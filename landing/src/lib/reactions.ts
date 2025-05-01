// src/lib/reactions.ts
import { getSession } from 'next-auth/react';

// Interfaz para estadísticas de reacciones
export interface ReactionStats {
  likes: number;
  dislikes: number;
  userReaction: { id: string; type: 'like' | 'dislike'; active: boolean } | null;
}

// Función para obtener las estadísticas de reacciones de un producto usando REST API
export async function getProductReactionStatsREST(
  productId: string,
  userId?: string
): Promise<ReactionStats> {
  try {
    console.log(`REST: Obteniendo estadísticas de reacciones para producto ${productId}`);
    
    // Construir URL del endpoint
    const url = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/reaction/stats/${productId}`;
    
    // Obtener la sesión para el token de autenticación (si está disponible)
    const session = await getSession();
    
    // Preparar opciones de la petición
    const options: RequestInit = {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    };
    
    // Añadir token de autenticación si está disponible
    if (session?.user?.jwt) {
      options.headers = {
        ...options.headers,
        Authorization: `Bearer ${session.user.jwt}`,
      };
    }
    
    // Realizar la petición
    const response = await fetch(url, options);
    
    if (!response.ok) {
      throw new Error(`Error en la respuesta: ${response.statusText}`);
    }
    
    const data = await response.json();
    
    // Valores por defecto
    const stats: ReactionStats = {
      likes: data.likes || 0,
      dislikes: data.dislikes || 0,
      userReaction: null,
    };
    
    // Si hay una reacción del usuario y userId coincide, establecer userReaction
    if (data.userReaction && userId) {
      stats.userReaction = {
        id: data.userReaction.id,
        type: data.userReaction.type,
        active: data.userReaction.active,
      };
    }
    
    console.log('Estadísticas de reacciones:', stats);
    return stats;
    
  } catch (error) {
    console.error('Error al obtener estadísticas de reacciones:', error);
    return {
      likes: 0,
      dislikes: 0,
      userReaction: null,
    };
  }
}

// Función para alternar una reacción (like/dislike) usando REST API
export async function toggleReactionREST(
  productId: string,
  userId: string,
  type: 'like' | 'dislike'
): Promise<boolean> {
  try {
    console.log(`REST: Alternando reacción ${type} para usuario ${userId} en producto ${productId}`);
    
    // Construir URL del endpoint
    const url = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/reaction/toggle`;
    
    // Obtener la sesión para el token de autenticación
    const session = await getSession();
    
    if (!session?.user?.jwt) {
      console.error('No hay token JWT disponible');
      return false;
    }
    
    // Preparar datos para la petición
    const requestData = {
      productId,
      type,
    };
    
    // Preparar opciones de la petición
    const options: RequestInit = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${session.user.jwt}`,
      },
      body: JSON.stringify(requestData),
    };
    
    // Realizar la petición
    const response = await fetch(url, options);
    
    if (!response.ok) {
      throw new Error(`Error en la respuesta: ${response.statusText}`);
    }
    
    const data = await response.json();
    return data.success === true;
    
  } catch (error) {
    console.error('Error al alternar reacción:', error);
    return false;
  }
}
