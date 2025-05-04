import { NextRequest, NextResponse } from 'next/server';

// URL base para la API
const API_URL = process.env.NEXT_PUBLIC_STRAPI_API_URL || 'http://localhost:1337';

export async function GET(request: NextRequest) {
  try {
    // Usar el token de API para obtener acceso completo
    const API_TOKEN = process.env.NEXT_PUBLIC_STRAPI_API_TOKEN;
    console.log('DEBUG - Usando token de API para autenticación con Strapi');
    
    const requestOptions: RequestInit = {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${API_TOKEN}`
      },
      cache: 'no-store'
    };

    // Primera consulta: ver todos los carritos
    console.log('DEBUG - Consultando todos los carritos');
    const allCartsResponse = await fetch(`${API_URL}/api/carts`, requestOptions);
    const allCartsData = await allCartsResponse.json();
    console.log(`DEBUG - Status de la respuesta: ${allCartsResponse.status}`);
    console.log(`DEBUG - Encontrados ${allCartsData?.data?.length || 0} carritos en total`);

    // Segunda consulta: ver carritos marcados como pedidos
    console.log('DEBUG - Consultando carritos con createAt="Pedido completado"');
    const completedCartsResponse = await fetch(
      `${API_URL}/api/carts?filters[createAt][$eq]=Pedido completado`, 
      requestOptions
    );
    const completedCartsData = await completedCartsResponse.json();
    console.log(`DEBUG - Status de la respuesta: ${completedCartsResponse.status}`);
    console.log(`DEBUG - Encontrados ${completedCartsData?.data?.length || 0} carritos completados`);

    // Crear un objeto con toda la información para depuración
    const debugInfo = {
      token: API_TOKEN ? API_TOKEN.substring(0, 10) + '...' : 'No disponible',
      allCarts: {
        status: allCartsResponse.status,
        count: allCartsData?.data?.length || 0,
        data: allCartsData
      },
      completedCarts: {
        status: completedCartsResponse.status,
        count: completedCartsData?.data?.length || 0,
        data: completedCartsData
      }
    };

    return NextResponse.json(debugInfo);
  } catch (error) {
    console.error('Error en la API de depuración:', error);
    return NextResponse.json(
      { error: 'Error al obtener información de depuración', details: (error as Error).message },
      { status: 500 }
    );
  }
}
