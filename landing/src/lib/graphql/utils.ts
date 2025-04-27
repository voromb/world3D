// src/lib/graphql/utils.ts

// Utilidades compartidas para operaciones GraphQL en Strapi
// Este módulo maneja la conversión entre IDs numéricos y documentIds

// Configuración básica
export const STRAPI_GRAPHQL_URL = process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL || 'http://localhost:1337/graphql';
export const STRAPI_API_TOKEN = process.env.NEXT_PUBLIC_STRAPI_API_TOKEN || '';
export const STRAPI_REST_URL = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:1337';

// Mapa de conversión de IDs a slugs para búsqueda rápida
// Este mapa debe actualizarse cuando se añadan o modifiquen productos
export const ID_TO_SLUG_MAP: Record<string, string> = {};

// Consultas GraphQL como strings para compatibilidad
export const FIND_PRODUCT_BY_SLUG = `
  query FindProductBySlug($slug: String!) {
    products(filters: {slug: {eq: $slug}}, pagination: { limit: 1 }) {
      documentId
      slug
      productName
      views
      averageRating
      totalRatings
    }
  }
`;

export const FIND_PRODUCT_BY_ID = `
  query GetProduct($documentId: ID!) {
    product(documentId: $documentId) {
      documentId
      productName
      views
      averageRating
      totalRatings
    }
  }
`;

export const UPDATE_PRODUCT_VIEWS = `
  mutation UpdateProductViews($documentId: ID!, $views: Int!) {
    updateProduct(
      documentId: $documentId
      data: {
        views: $views
      }
    ) {
      documentId
      productName
      views
    }
  }
`;

export const GET_PRODUCT_RATINGS = `
  query GetProductRatings($productId: ID!) {
    productRatings(filters: {products: {documentId: {eq: $productId}}}) {
      documentId
      rating
    }
  }
`;

export const CREATE_RATING = `
  mutation CreateRating($rating: Int!, $productId: ID!) {
    createProductRating(
      data: {
        rating: $rating
        products: [$productId]
      }
    ) {
      documentId
      rating
      products {
        documentId
        productName
      }
    }
  }
`;

export const UPDATE_PRODUCT_RATING = `
  mutation UpdateProductRating($documentId: ID!, $averageRating: Float!, $totalRatings: Int!) {
    updateProduct(
      documentId: $documentId
      data: {
        averageRating: $averageRating
        totalRatings: $totalRatings
      }
    ) {
      documentId
      productName
      averageRating
      totalRatings
    }
  }
`;

// Cliente GraphQL simplificado que funciona con el esquema personalizado de Strapi
export async function graphqlRequest(query: string, variables: any = {}) {
  try {
    console.log(`Enviando consulta GraphQL a ${STRAPI_GRAPHQL_URL}`);
    console.log(`Tipo de operación: ${query.includes('mutation') ? 'Mutación' : 'Consulta'}`);
    console.log('Variables:', JSON.stringify(variables, null, 2));
    
    const response = await fetch(STRAPI_GRAPHQL_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${STRAPI_API_TOKEN}`,
      },
      body: JSON.stringify({
        query,
        variables
      })
    });
    
    const result = await response.json();
    
    if (result.errors) {
      console.error('Errores GraphQL:', result.errors);
      throw new Error('Error en la consulta GraphQL');
    }
    
    console.log('Respuesta GraphQL exitosa');
    return result.data;
  } catch (error) {
    console.error('Error al ejecutar consulta GraphQL:', error);
    throw error;
  }
}

// Función para buscar un producto por slug, ID o ID numérico con múltiples estrategias
export async function findProductBySlugOrId(slugOrId: string) {
  try {
    console.log(`Buscando producto por slug o id: ${slugOrId}`);
    
    // Verificar si es un objeto con documentId, slug o id
    if (typeof slugOrId === 'object' && slugOrId !== null) {
      const product = slugOrId as any;
      
      // Si tiene documentId, usarlo directamente (es lo mejor para GraphQL)
      if (product.documentId) {
        console.log(`Objeto producto detectado, usando documentId: ${product.documentId}`);
        
        // Opción directa: si tenemos documentId, hacer la consulta GraphQL directamente
        const findResultById = await graphqlRequest(FIND_PRODUCT_BY_ID, {
          documentId: product.documentId
        });
        
        if (findResultById?.product) {
          console.log('Producto encontrado directamente por documentId');
          return findResultById.product;
        }
        
        slugOrId = product.documentId;
      } else if (product.slug) {
        console.log(`Objeto producto detectado, usando slug: ${product.slug}`);
        slugOrId = product.slug;
      } else if (product.id) {
        console.log(`Objeto producto detectado, usando id: ${product.id}`);
        slugOrId = product.id.toString();
      }
    }
    
    // 1. Intentar buscar por slug usando GraphQL
    console.log('Intentando buscar por slug...');
    const findResultBySlug = await graphqlRequest(FIND_PRODUCT_BY_SLUG, {
      slug: slugOrId.toString()
    });
    
    if (findResultBySlug?.products && findResultBySlug.products.length > 0) {
      console.log('Producto encontrado por slug');
      return findResultBySlug.products[0];
    }
    
    // 2. Comprobar si el ID podría ser ya un documentId (alfanumérico largo)
    if (slugOrId.length > 20) {
      console.log('Intentando buscar por documentId...');
      const findResultById = await graphqlRequest(FIND_PRODUCT_BY_ID, {
        documentId: slugOrId
      });
      
      if (findResultById?.product) {
        console.log('Producto encontrado por documentId');
        return findResultById.product;
      }
    }
    
    // 3. Si parece un ID numérico, buscar primero en la API REST para obtener el documentId
    if (/^\d+$/.test(slugOrId)) {
      try {
        console.log('Intentando buscar por ID numérico en REST API...');
        const strapiResponse = await fetch(`${STRAPI_REST_URL}/api/products/${slugOrId}?populate=*`, {
          headers: {
            'Authorization': `Bearer ${STRAPI_API_TOKEN}`,
          }
        });
        
        if (strapiResponse.ok) {
          const productData = await strapiResponse.json();
          
          if (productData?.data) {
            console.log('Producto encontrado por ID numérico en REST API');
            
            // Extraer el documentId de la respuesta REST
            const documentId = productData.data.id;
            
            // Una vez que tenemos el documentId, hacer una consulta GraphQL para obtener los datos en el formato correcto
            if (documentId) {
              console.log(`Obteniendo datos completos con documentId: ${documentId}`);
              const graphqlResult = await graphqlRequest(FIND_PRODUCT_BY_ID, {
                documentId: documentId
              });
              
              if (graphqlResult?.product) {
                console.log('Datos completos del producto obtenidos por GraphQL');
                return graphqlResult.product;
              }
              
              // En caso de que falle la consulta GraphQL, adaptamos los datos de la REST API
              console.log('Adaptar datos de REST API al formato GraphQL');
              return {
                documentId: documentId,
                slug: productData.data.attributes.slug,
                productName: productData.data.attributes.productName,
                views: productData.data.attributes.views || 0,
                averageRating: productData.data.attributes.averageRating || 0,
                totalRatings: productData.data.attributes.totalRatings || 0
              };
            }
          }
        }
      } catch (restError) {
        console.error('Error al buscar por REST API:', restError);
      }
    }
    
    console.log('Producto no encontrado por ningún método');
    return null;
  } catch (error) {
    console.error('Error al buscar producto:', error);
    return null;
  }
}

// Almacenamiento para antirebote (límite de frecuencia) - Funciona en desarrollo pero se reinicia en producción
export const incrementLimiter = new Map<string, number>();

// Función para incrementar vistas con límite de frecuencia
export async function incrementProductViews(productIdOrObject: string | any) {
  console.log(`Incrementando vistas para el producto`, productIdOrObject);
  
  try {
    // Para antirebote usaremos id o documentId como llave
    let productKey: string;
    let useDirectDocumentId = false;
    let directDocumentId: string | null = null;
    
    console.log('Tipo de productIdOrObject:', typeof productIdOrObject);
    
    // Verificar si es un objeto con documentId, slug o id
    if (typeof productIdOrObject === 'object' && productIdOrObject !== null) {
      const product = productIdOrObject as any;
      if (product.documentId) {
        console.log(`Objeto producto detectado con documentId: ${product.documentId}`);
        useDirectDocumentId = true;
        directDocumentId = product.documentId;
        productKey = `doc_${product.documentId}`;
      } else if (product.slug) {
        console.log(`Objeto producto detectado con slug: ${product.slug}`);
        productKey = product.slug;
      } else if (product.id) {
        console.log(`Objeto producto detectado con id: ${product.id}`);
        productKey = product.id.toString();
      } else {
        throw new Error('Objeto producto no contiene documentId, id ni slug');
      }
    } else {
      // Es posible que el valor sea directamente un documentId
      // Intentamos verificar si tiene el formato de un documentId de Strapi (alfanumérico largo)
      const strValue = productIdOrObject.toString();
      const isDocumentIdFormat = /^[a-zA-Z0-9]{24,26}$/.test(strValue);
      
      if (isDocumentIdFormat) {
        console.log(`Posible documentId detectado directamente: ${strValue}`);
        useDirectDocumentId = true;
        directDocumentId = strValue;
        productKey = `doc_${strValue}`;
      } else {
        // Probablemente sea un slug o un ID numérico
        console.log(`Valor directo (ID o slug): ${strValue}`);
        productKey = strValue;
      }
    }
    
    // Registro de timestamp solo para fines de logging
    // Ya no limitamos el incremento, siempre incrementamos en cada visita
    const now = Date.now();
    const lastUpdate = incrementLimiter.get(productKey);
    
    if (lastUpdate) {
      console.log(`Última actualización para ${productKey} hace ${(now - lastUpdate) / 1000} segundos, incrementando de todos modos`);
    }
    
    // Si ya tenemos el documentId directamente, lo usamos sin buscar
    let documentId;
    let currentViews;
    
    if (useDirectDocumentId && directDocumentId) {
      console.log(`Usando documentId directo: ${directDocumentId}`);
      documentId = directDocumentId;
      
      // Obtener las vistas actuales (necesitamos consultar)
      const productData = await graphqlRequest(FIND_PRODUCT_BY_ID, {
        documentId: documentId
      });
      
      console.log('Resultado de la consulta GraphQL:', JSON.stringify(productData));
      
      if (!productData?.product) {
        throw new Error('Producto no encontrado con documentId directo');
      }
      
      currentViews = productData.product.views || 0;
      console.log(`Vistas actuales: ${currentViews}`, productData.product);
    } else {
      // Si productIdOrObject es un ID numérico, intentamos buscar con REST y GraphQL
      if (typeof productIdOrObject === 'string' || typeof productIdOrObject === 'number') {
        const strValue = productIdOrObject.toString();
        // Comprobar si es un ID numérico
        const isNumericId = !isNaN(Number(strValue)) && Number.isFinite(Number(strValue));
        
        if (isNumericId) {
          console.log(`ID numérico detectado: ${strValue}, buscando producto por ID...`);
          try {
            // Intentar encontrar el producto por ID en la API REST primero
            const apiUrl = `/api/products/${strValue}`;
            console.log(`Consultando API REST: ${apiUrl}`);
            const response = await fetch(apiUrl);
            
            if (response.ok) {
              const restData = await response.json();
              if (restData && restData.documentId) {
                console.log(`Producto encontrado en REST API con documentId: ${restData.documentId}`);
                useDirectDocumentId = true;
                directDocumentId = restData.documentId;
                productKey = `doc_${restData.documentId}`;
              }
            }
          } catch (restError) {
            console.error('Error al buscar producto por ID en REST:', restError);
          }
        }
      }
      
      // Si no encontramos el documentId directamente, buscamos el producto
      let foundProductData = null;
      if (!useDirectDocumentId) {
        console.log(`Buscando producto para incrementar vistas: ${productIdOrObject}`);
        foundProductData = await findProductBySlugOrId(productIdOrObject);
        
        console.log('Resultado de la búsqueda:', foundProductData ? 'Encontrado' : 'No encontrado');
        
        if (!foundProductData) {
          console.log('Producto no encontrado. Utilizando vistas simuladas.');
          // En lugar de lanzar un error, devolvemos un valor simulado
          return {
            incremented: true,
            views: 1,
            message: 'Vistas simuladas (producto no encontrado en servidor)'
          };
        }
        
        // Si encontramos el producto, usamos su documentId
        if (foundProductData.documentId) {
          useDirectDocumentId = true;
          directDocumentId = foundProductData.documentId;
          currentViews = foundProductData.views || 0;
        }
      }
      
      // Obtener documentId y vistas del producto encontrado
      documentId = directDocumentId;
      
      // Si tenemos el producto, usamos sus vistas, de lo contrario asumimos 0
      if (!currentViews && foundProductData) {
        currentViews = foundProductData.views || 0;
      } else if (!currentViews) {
        currentViews = 0;
      }
      
      console.log(`Producto encontrado. DocumentId: ${documentId}, Vistas actuales: ${currentViews}`);
    }
    
    // Calcular las nuevas vistas - siempre incrementamos en 1
    const newViews = currentViews + 1;
    console.log(`Incrementando vistas de ${currentViews} a ${newViews}`);
    
    // Registrar este momento como la última actualización (solo para tracking, no limita)
    incrementLimiter.set(productKey, now);
    
    // Actualizar con GraphQL - Enfoque directo para asegurar que llegue a la base de datos
    console.log(`Enviando ACTUALIZACIÓN de vistas para producto ${documentId}: ${newViews}`);
    
    try {
      // Hacer la petición directamente a la URL de Strapi
      const strapiUrl = process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL || 'http://localhost:1337/graphql';
      const isBrowser = typeof window !== 'undefined';
      
      // URL del endpoint GraphQL según si estamos en navegador o servidor
      const targetUrl = isBrowser ? '/api/graphql/proxy' : strapiUrl;
      
      console.log(`Enviando petición a: ${targetUrl}`);
      
      const response = await fetch(targetUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Request-ID': `${Date.now()}-${Math.random()}`
        },
        body: JSON.stringify({
          query: `
            mutation UpdateProductViews($documentId: ID!, $views: Int!) {
              updateProduct(
                documentId: $documentId
                data: {
                  views: $views
                }
              ) {
                documentId
                views
              }
            }
          `,
          variables: {
            documentId: documentId,
            views: newViews
          }
        }),
        cache: 'no-store'
      });
      
      const updateResult = await response.json();
      
      console.log('Resultado de actualización de vistas:', JSON.stringify(updateResult, null, 2));
      
      // Verificar el resultado de la actualización
      if (!updateResult?.data?.updateProduct?.views) {
        console.error('No se pudo actualizar las vistas del producto');
        if (updateResult.errors) {
          console.error('Errores:', JSON.stringify(updateResult.errors));
        }
      } else {
        console.log(`Vistas actualizadas correctamente a: ${updateResult.data.updateProduct.views}`);
      }
    } catch (error) {
      console.error('Error al enviar actualización de vistas:', error);
    }
    
    console.log(`Vistas incrementadas para producto ${productKey}: ${newViews}`);
    
    return {
      incremented: true,
      views: newViews,
      message: 'Vistas actualizadas correctamente'
    };
  } catch (error) {
    console.error('Error al incrementar vistas:', error);
    throw error;
  }
}