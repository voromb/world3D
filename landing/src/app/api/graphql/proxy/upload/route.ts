// src/app/api/graphql/proxy/upload/route.ts
import { NextRequest, NextResponse } from 'next/server';

/**
 * Endpoint de proxy para redirigir peticiones de carga de archivos desde el cliente al servidor de Strapi.
 * Evita problemas de CORS y permisos cuando se hacen peticiones directas desde el navegador.
 */
export async function POST(request: NextRequest) {
  try {
    // URL completa del servidor de carga de archivos de Strapi
    const strapiUploadUrl = process.env.NEXT_PUBLIC_BACKEND_URL 
      ? `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/upload`
      : 'http://localhost:1337/api/upload';
    
    console.log(`Proxy Upload: reenviando petición a ${strapiUploadUrl}`);
    
    // Obtener el token de autorización de la cabecera
    const authHeader = request.headers.get('Authorization');
    
    // Verificar si tenemos encabezado de autorización
    if (!authHeader) {
      console.error('Proxy Upload: No se encontró cabecera de autorización');
      return NextResponse.json(
        { error: 'Se requiere autenticación para cargar archivos' },
        { status: 401 }
      );
    }
    
    // Clonar la petición para preservar el formData
    const formData = await request.formData();
    console.log('Proxy Upload: FormData recibido con campos:', Array.from(formData.keys()));
    
    // Añadir token explícito si es necesario
    // Podríamos añadir aquí un token específico del servidor si es necesario
    const headers = new Headers();
    headers.append('Authorization', authHeader);
    
    // Depuración: mostrar cada archivo que se está cargando
    if (formData.getAll('files')) {
      const files = formData.getAll('files');
      files.forEach((file: any) => {
        if (file instanceof File) {
          console.log(`Archivo a subir: ${file.name}, Tipo: ${file.type}, Tamaño: ${file.size} bytes`);
        }
      });
    }
    
    // Enviar la petición a Strapi
    const strapiResponse = await fetch(strapiUploadUrl, {
      method: 'POST',
      headers: headers,
      body: formData,
    });
    
    // Verificar si la respuesta es satisfactoria
    if (!strapiResponse.ok) {
      const errorText = await strapiResponse.text();
      console.error(`Proxy Upload: Error en la carga (${strapiResponse.status}): ${errorText}`);
      return NextResponse.json(
        { error: `Error en el servidor de Strapi: ${strapiResponse.statusText}`, details: errorText },
        { status: strapiResponse.status }
      );
    }
    
    // Obtener y devolver la respuesta
    const data = await strapiResponse.json();
    console.log('Proxy Upload: Imágenes subidas correctamente:', data);
    
    return NextResponse.json(data, {
      status: 200,
      statusText: 'OK'
    });
  } catch (error) {
    console.error('Error en el proxy de carga:', error);
    return NextResponse.json(
      { 
        error: 'Error en el servidor proxy de carga',
        details: error instanceof Error ? error.message : 'Error desconocido'
      },
      { status: 500 }
    );
  }
}
