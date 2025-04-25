import { HeroImageType } from '@/types';

/**
 * Obtiene las imágenes para el carrusel principal
 */
export async function fetchHeroImages(): Promise<HeroImageType[]> {
  try {
    // Obtener datos de la API
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/image-generals`);
    
    if (!response.ok) {
      throw new Error(`Error fetching hero images: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Transformar los datos al formato esperado
    return data.data.map((item: any) => ({
      id: item.id,
      document_id: item.document_id || item.documentId,
      image_general_name: item.image_general_name || item.imageGeneralName,
      slug: item.slug,
      text_general: item.text_general || {
        title: item.title || '',
        subtitle: item.subtitle || ''
      },
      links: item.links || [],
      // Construye la URL de la imagen según la estructura de tu API
      url: item.url || 
           (item.image?.url ? 
             `${process.env.NEXT_PUBLIC_API_URL}${item.image.url}` : 
             `/api/image-generals/${item.id}/image`)
    }));
  } catch (error) {
    console.error('Error fetching hero images:', error);
    return [];
  }
}