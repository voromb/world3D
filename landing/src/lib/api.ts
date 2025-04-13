/**
 * Cliente API para conectar con Strapi
 */

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:1337';

/**
 * Obtiene un URL completo de la API de Strapi
 * @param {string} path - Ruta relativa a la API
 * @returns {string} URL completo
 */
export function getStrapiURL(path = '') {
  return `${API_URL}${path}`;
}

/**
 * Función helper para realizar peticiones a la API de Strapi
 * @param {string} path - Ruta del endpoint
 * @param {object} options - Opciones de fetch
 * @returns {Promise} Respuesta de la API
 */
export async function fetchAPI(path: string, options = {}) {
  const defaultOptions = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  
  const mergedOptions = {
    ...defaultOptions,
    ...options,
  };
  
  const requestUrl = getStrapiURL(`/api${path}`);
  const response = await fetch(requestUrl, mergedOptions);
  
  if (!response.ok) {
    throw new Error(`Error en la petición API: ${response.statusText}`);
  }
  
  const data = await response.json();
  return data;
}

/**
 * Verifica la conexión con Strapi
 * @returns {Promise<{ connected: boolean, message: string }>}
 */
export async function checkStrapiConnection() {
  try {
    const response = await fetch(getStrapiURL('/'));
    if (response.ok) {
      return { connected: true, message: 'Conexión establecida con Strapi' };
    } else {
      return { connected: false, message: `Error de conexión: ${response.statusText}` };
    }
  } catch (error) {
    return { 
      connected: false, 
      message: `No se pudo conectar con Strapi: ${error instanceof Error ? error.message : 'Error desconocido'}`
    };
  }
}