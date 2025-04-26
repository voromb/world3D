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
      productKey = productIdOrObject.toString();
    }
    
    // Sistema antirebote usando Map y timestamp
    const now = Date.now();
    const lastUpdate = incrementLimiter.get(productKey);
    
    if (lastUpdate && now - lastUpdate < 60000) {
      console.log(`Omitiendo incremento para ${productKey}, última actualización hace ${(now - lastUpdate) / 1000} segundos`);
      return {
        incremented: false,
        message: 'Hace poco que se incrementaron las vistas para este producto',
        views: null
      };
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
      // Buscar el producto primero
      console.log(`Buscando producto para incrementar vistas: ${productIdOrObject}`);
      const productData = await findProductBySlugOrId(productIdOrObject);
      
      console.log('Resultado de la búsqueda:', productData ? 'Encontrado' : 'No encontrado');
      
      if (!productData) {
        console.log('Producto no encontrado. Utilizando vistas simuladas.');
        // En lugar de lanzar un error, devolvemos un valor simulado
        return {
          incremented: true,
          views: 1,
          message: 'Vistas simuladas (producto no encontrado en servidor)'
        };
      }
      
      // Obtener documentId y vistas del producto encontrado
      documentId = productData.documentId;
      currentViews = productData.views || 0;
      console.log(`Producto encontrado. DocumentId: ${documentId}, Vistas actuales: ${currentViews}`);
    }
    
    // Calcular las nuevas vistas
    const newViews = currentViews + 1;
    
    // Registrar este momento como la última actualización para este producto
    incrementLimiter.set(productKey, now);
    
    // Actualizar con GraphQL
    await graphqlRequest(UPDATE_PRODUCT_VIEWS, {
      documentId: documentId,
      views: newViews
    });
    
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