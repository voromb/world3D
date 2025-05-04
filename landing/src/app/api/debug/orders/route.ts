import { NextRequest, NextResponse } from 'next/server';

// URL base para la API
const API_URL = process.env.NEXT_PUBLIC_STRAPI_API_URL || 'http://localhost:1337';

export async function GET(request: NextRequest) {
  try {
    console.log('API Debug - Consultando todos los pedidos para diagnóstico');
    
    // Opciones para la petición a Strapi
    const requestOptions: RequestInit = {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
      next: { revalidate: 0 } // No almacenar en caché
    };
    
    // 1. Obtener todos los pedidos sin filtros para diagnóstico
    const url = `${API_URL}/api/orders?populate[items][populate]=*&populate=*&pagination[pageSize]=50`;
    console.log('API Debug - URL:', url);
    
    const response = await fetch(url, requestOptions);
    const allOrders = await response.json();
    
    // 2. Obtener información detallada sobre cada pedido
    const diagnosticInfo: {
      totalOrdersCount: number;
      detailedOrders: any[];
      graphqlOrders?: any[];
      graphqlOrdersCount?: number;
      graphqlError?: string;
    } = {
      totalOrdersCount: allOrders?.data?.length || 0,
      detailedOrders: []
    };
    
    if (allOrders?.data?.length > 0) {
      console.log(`API Debug - Encontrados ${allOrders.data.length} pedidos en total`);
      
      // Mostrar la estructura completa del contenido de los pedidos
      diagnosticInfo.detailedOrders = allOrders.data.map((order: any) => ({
        id: order.id,
        orderNumber: order.attributes?.orderNumber,
        createdAt: order.attributes?.createdAt,
        total: order.attributes?.total,
        userRelations: {
          // Detalles sobre la relación con el usuario
          userFieldExists: !!order.attributes?.user,
          userField: order.attributes?.user,
          userPermissionsFieldExists: !!order.attributes?.users_permissions_user,
          userPermissionsField: order.attributes?.users_permissions_user,
          userIdExists: !!order.attributes?.userId,
          userId: order.attributes?.userId
        },
        itemsCount: order.attributes?.items?.data?.length || 0,
        items: (order.attributes?.items?.data || []).map((item: any) => ({
          id: item.id,
          productName: item.attributes?.productName,
          price: item.attributes?.price,
          quantity: item.attributes?.quantity
        }))
      }));
    } else {
      console.log('API Debug - No se encontraron pedidos en Strapi');
    }

    // 3. Verificar también los pedidos mediante el endpoint de graphql
    try {
      const graphqlResponse = await fetch(`${API_URL}/graphql`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          query: `
            query {
              orders {
                data {
                  id
                  attributes {
                    orderNumber
                    createdAt
                    status
                    total
                  }
                }
              }
            }
          `
        })
      });
      
      const graphqlData = await graphqlResponse.json();
      diagnosticInfo.graphqlOrders = graphqlData?.data?.orders?.data || [];
      diagnosticInfo.graphqlOrdersCount = graphqlData?.data?.orders?.data?.length || 0;
      console.log(`API Debug - GraphQL encontró ${diagnosticInfo.graphqlOrdersCount} pedidos`);
    } catch (error) {
      console.error('API Debug - Error al consultar GraphQL:', error);
      diagnosticInfo.graphqlError = 'Error al consultar GraphQL';
    }
    
    return NextResponse.json(diagnosticInfo);

  } catch (error) {
    console.error('Error en la API de diagnóstico de pedidos:', error);
    return NextResponse.json(
      { error: 'Error al procesar la petición de diagnóstico' },
      { status: 500 }
    );
  }
}
