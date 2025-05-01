"use client";

import React, { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';
import { ThumbsUp, ThumbsDown } from 'lucide-react';
import { toggleReaction, type ReactionStats, getProductReactionStats } from '@/lib/graphql';
import { getProductReactionStatsREST, toggleReactionREST } from '@/lib/reactions';
import { useToast } from "@/components/ui/use-toast-hook";

interface ReactionButtonsProps {
  productId: string | number;
  productDocumentId?: string; // ID alfanumérico del producto en Strapi (ej: "hb0jw6xs8tzgcykmjiq491o6")
}

const ReactionButtons: React.FC<ReactionButtonsProps> = ({ productId, productDocumentId }) => {
  const { data: session, status } = useSession();
  const { toast } = useToast();
  const [stats, setStats] = useState<ReactionStats>({
    likes: 0,
    dislikes: 0,
    userReaction: null,
  });
  const [loading, setLoading] = useState<boolean>(false);
  
  const isAuthenticated = status === 'authenticated';
  
  // Debug
  console.log('Estado de sesión:', status);
  console.log('Datos de sesión:', session);

  useEffect(() => {
    // Obtener las estadísticas de reacciones al cargar el componente
    fetchStats();
  }, [session]);

  // Función para obtener estadísticas de reacciones
  const fetchStats = async () => {
    if (!productId) {
      console.log('No hay productId, no se pueden obtener estadísticas');
      return;
    }

    console.log(`Obteniendo estadísticas para: ${productId}`);
    console.log(`DocumentId disponible: ${productDocumentId ? productDocumentId : 'No disponible'}`);
    console.log(`Tipo de productId: ${typeof productId}, Valor: ${productId}`);
    if (productDocumentId) {
      console.log(`Tipo de productDocumentId: ${typeof productDocumentId}, Valor: ${productDocumentId}`);
    }
    
    // Verificar si tenemos acceso al token JWT
    const jwt = session?.jwt;
    console.log(`Token JWT disponible: ${jwt ? 'Sí' : 'No'}`);
    console.log(`Datos de sesión completos:`, session);

    try {
      // Siempre debemos usar el documentId para la consulta de reacciones
      // si está disponible, ya que es lo que se utiliza para relacionar entidades en Strapi
      let queryId;
      if (productDocumentId) {
        queryId = productDocumentId;
        console.log(`Usando documentId para consulta: ${queryId}`);
      } else {
        queryId = String(productId);
        console.log(`DocumentId no disponible, usando ID numérico: ${queryId}`);
      }
      
      // Intentar GraphQL primero
      console.log('Intentando obtener estadísticas vía GraphQL...');
      const graphqlStats = await getProductReactionStats(
        queryId,
        session?.user?.id as string,
        jwt
      );
      
      console.log('Estadísticas obtenidas vía GraphQL:', graphqlStats);
      setStats(graphqlStats);
    } catch (error) {
      console.error('Error al obtener estadísticas por GraphQL:', error);
      
      // Fallback a REST API
      console.log('Fallback a REST API para estadísticas');
      try {
        const restStats = await getProductReactionStatsREST(String(productId));
        console.log('Estadísticas obtenidas vía REST:', restStats);
        setStats(restStats);
      } catch (restError) {
        console.error('Error al obtener estadísticas por REST:', restError);
        toast({
          title: 'Error',
          description: 'No se pudieron cargar las estadísticas de reacciones.',
          variant: 'destructive'
        });
      }
    }
  };

  const handleReaction = async (type: 'like' | 'dislike') => {
    if (!isAuthenticated) {
      alert("Necesitas iniciar sesión para poder dar like o dislike.");
      return;
    }
  
    setLoading(true);
    try {      
      console.log(`==== INICIO PROCESO DE REACCIÓN (${type}) ====`);
      console.log(`Enviando reacción ${type} para producto ${productId}`);
      console.log(`DocumentId disponible: ${productDocumentId ? productDocumentId : 'No disponible'}`);
      
      const userId = session?.user?.id || '';
      const token = session?.user?.jwt;
      
      console.log(`Datos del usuario:`);
      console.log(`- ID del usuario: ${userId}`);
      console.log(`- Tipo de ID: ${typeof userId}`);
      console.log(`- Objeto de sesión:`, session);
      
      if (!userId) {
        alert("No se pudo identificar al usuario. Por favor, inicia sesión de nuevo.");
        return;
      }
      
      console.log('Token JWT disponible:', token ? 'Sí' : 'No');
      
      let success = false;
      
      // Asegurarnos que usamos el ID correcto del producto
      // El ID del producto debe ser el documentId (alfanumérico) y no el id numérico
      // Los IDs correctos en Strapi se ven como "fafwisrkf8g6o51kup5n7kgd"

      // Comprobar si tenemos el documentId del producto disponible como prop
      let productIdToUse = String(productId);
      console.log(`Verificando tipo de ID: ${productIdToUse}`);
      console.log(`- Longitud del ID: ${productIdToUse.length}`);
      console.log(`- Caracteres del ID: ${productIdToUse.split('').join(', ')}`);
      
      const isNumericId = /^\d+$/.test(productIdToUse);
      console.log(`- ¿Es ID numérico? ${isNumericId ? 'Sí' : 'No'}`);
      console.log(`- ¿Tenemos documentId? ${productDocumentId ? 'Sí' : 'No'}`);
      
      if (isNumericId && productDocumentId) {
        // Si es un ID numérico pero tenemos documentId disponible, usar el documentId
        productIdToUse = productDocumentId;
        console.log(`Usando documentId ${productDocumentId} en lugar de ID numérico ${productId}`);
        console.log(`- Longitud del documentId: ${productDocumentId.length}`);
        console.log(`- ¿El documentId parece válido? ${/^[a-zA-Z0-9]+$/.test(productDocumentId) ? 'Sí' : 'No'}`);
      } else {
        console.log(`Usando ID original: ${productIdToUse}`);
        console.log(`ADVERTENCIA: ${isNumericId ? 'Se está usando un ID numérico sin documentId disponible' : 'El ID no es numérico, podría ser ya un documentId'}`);
      }
      
      console.log(`ID final que se usará para la reacción: ${productIdToUse}`);
      
      // Intentar con GraphQL primero
      try {
        console.log(`Llamando a toggleReaction con: productId=${productIdToUse}, userId=${userId}, type=${type}`);
        success = await toggleReaction(productIdToUse, userId, type, token);
        console.log(`Resultado de toggleReaction: ${success ? 'Éxito' : 'Fallo'}`);
      } catch (graphqlError) {
        console.error('Error con GraphQL, intentando con REST:', graphqlError);
        console.log(`Intentando fallback a REST API con: productId=${productIdToUse}, userId=${userId}, type=${type}`);
        // Si falla GraphQL, intentar con REST
        success = await toggleReactionREST(productIdToUse, userId, type);
        console.log(`Resultado de toggleReactionREST: ${success ? 'Éxito' : 'Fallo'}`);
      }
  
      if (success) {
        // Actualizar estadísticas después de la reacción
        fetchStats();
      } else {
        alert("Ha ocurrido un error al procesar tu reacción");
      }
    } catch (error) {
      console.error('Error al enviar reacción:', error);
      alert("No se pudo procesar tu reacción. Inténtalo de nuevo más tarde.");
    } finally {
      setLoading(false);
    }
  };

  const isLikeActive = stats.userReaction?.type === 'like' && stats.userReaction?.active;
  const isDislikeActive = stats.userReaction?.type === 'dislike' && stats.userReaction?.active;

  return (
    <div className="flex items-center space-x-4 mt-4">
      <button
        onClick={() => handleReaction('like')}
        disabled={loading}
        className={`flex items-center gap-2 px-3 py-1 rounded-md transition-colors ${
          isLikeActive 
            ? 'bg-green-600 text-white hover:bg-green-700' 
            : 'bg-white border border-gray-300 hover:bg-gray-100'
        }`}
      >
        <ThumbsUp className="h-4 w-4" />
        <span>{stats.likes}</span>
      </button>
      
      <button
        onClick={() => handleReaction('dislike')}
        disabled={loading}
        className={`flex items-center gap-2 px-3 py-1 rounded-md transition-colors ${
          isDislikeActive 
            ? 'bg-red-600 text-white hover:bg-red-700' 
            : 'bg-white border border-gray-300 hover:bg-gray-100'
        }`}
      >
        <ThumbsDown className="h-4 w-4" />
        <span>{stats.dislikes}</span>
      </button>
    </div>
  );
};

export default ReactionButtons;
