'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { request } from 'graphql-request';
import { FULL_STRAPI_GRAPHQL_URL } from '@/lib/graphql/client';
import ImageUpload from '@/components/ui/ImageUpload';
import Image from 'next/image';
import {
  GET_PRODUCTS_FOR_DASHBOARD,
  CREATE_PRODUCT,
  UPDATE_PRODUCT,
  DELETE_PRODUCT,
  generateSlug,
  Product,
  ProductInput
} from '@/lib/graphql/product-crud';

// Importación de componentes de UI
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";

// Componente principal del dashboard de productos
export default function ProductDashboard() {
  // Estado para los productos
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Estado para el formulario de creación/edición
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [dialogMode, setDialogMode] = useState<'create' | 'edit'>('create');
  const [currentProduct, setCurrentProduct] = useState<Product>({
    productName: '',
    slug: '',
    description: '',
    price: 0,
    hasImages: false,
    images: []
  });
  const [selectedFiles, setSelectedFiles] = useState<File[]>([]);
  const [operationLoading, setOperationLoading] = useState(false);
  const [operationError, setOperationError] = useState<string | null>(null);
  const [operationSuccess, setOperationSuccess] = useState<string | null>(null);

  // Obtener la información de sesión
  const { data: session, status } = useSession();

  // Clave para localStorage
  const USER_PRODUCTS_KEY = 'world3d_user_products';
  
  // Cargar productos al iniciar el componente
  useEffect(() => {
    if (status === 'authenticated') {
      fetchProducts();
    }
  }, [status]);
  
  // Función para guardar la ID de un producto en localStorage
  const saveProductToLocalStorage = (productId: string) => {
    try {
      const userId = (session?.user as any)?.id;
      if (!userId) return;
      
      // Obtener productos guardados o inicializar un array vacío
      const savedProducts = JSON.parse(localStorage.getItem(USER_PRODUCTS_KEY) || '{}');
      
      // Inicializar la lista de productos para este usuario si no existe
      if (!savedProducts[userId]) {
        savedProducts[userId] = [];
      }
      
      // Añadir el ID del producto si no existe ya
      if (!savedProducts[userId].includes(productId)) {
        savedProducts[userId].push(productId);
        localStorage.setItem(USER_PRODUCTS_KEY, JSON.stringify(savedProducts));
      }
    } catch (error) {
      console.error('Error al guardar producto en localStorage:', error);
    }
  };
  
  // Función para verificar si un producto pertenece al usuario actual
  const isUserProduct = (productId: string): boolean => {
    try {
      const userId = (session?.user as any)?.id;
      if (!userId) return false;
      
      const savedProducts = JSON.parse(localStorage.getItem(USER_PRODUCTS_KEY) || '{}');
      return savedProducts[userId]?.includes(productId) || false;
    } catch (error) {
      console.error('Error al verificar producto en localStorage:', error);
      return false;
    }
  };

  // Función para obtener los productos
  const fetchProducts = async () => {
    setIsLoading(true);
    setError(null);
    
    try {
      const jwt = (session?.user as any)?.jwt;
      const userId = (session?.user as any)?.id;
      const username = (session?.user as any)?.username || (session?.user as any)?.email || '';
      
      if (!jwt || !userId) {
        setError('No se encontró token de autenticación o ID de usuario.');
        setIsLoading(false);
        return;
      }
      
      console.log(`Obteniendo productos para el usuario ID: ${userId}, Usuario: ${username}`);
      
      // Hacer la petición a GraphQL
      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        GET_PRODUCTS_FOR_DASHBOARD,
        {},
        { Authorization: `Bearer ${jwt}` }
      );

      console.log('Respuesta completa de la API:', result);
      
      console.log('Estructura de respuesta completa:', JSON.stringify(result, null, 2));
      
      // Verificar si hay una estructura de productos en el formato actual de Strapi
      if (result && result.products && Array.isArray(result.products)) {
        // Mapear los productos a nuestro formato y extraer la información necesaria
        let allProducts = result.products
          .filter((product: any) => product) // Filtrar valores nulos
          .map((product: any) => {
            // Asignamos todos los productos al usuario actual para permitir su edición
            // Ya que no podemos consultar la relación users_permissions_users por permisos
            const productUserId = session?.user?.id || '';
            
            // Crear objeto de producto con la estructura esperada por nuestra aplicación
            const productObject = {
              documentId: product.documentId || '',
              id: product.documentId || '',
              productName: product.productName || '',
              slug: product.slug || '',
              description: product.description || '',
              price: typeof product.price === 'number' ? product.price : 0,
              active: product.active || false,
              createdAt: product.createdAt || '',
              createBy: product.createBy || '',
              // Ya no utilizamos users_permissions_users
              userId: productUserId,
              hasImages: Boolean(product.images && product.images.length > 0),
              images: product.images || [],
              isFeatured: product.isFeatured || false,
              weight: product.weight || 0,
              dimensions: product.dimensions || '',
              dateManufactured: product.dateManufactured || '',
              remaininWarranty: product.remaininWarranty || '',
              State: product.State || '',
              cityName: product.cityName || '',
              provinceName: product.provinceName || '',
              countryName: product.countryName || '',
              directionName: product.directionName || '',
              latitud: product.latitud || 0,
              longitud: product.longitud || 0
            } as Product;
            
            return productObject;
          });
        
        console.log(`Total de productos recuperados: ${allProducts.length}`);
        console.log(`ID del usuario actual: ${userId}`);
        
        // Imprimir información detallada para depuración
        allProducts.forEach((product: Product) => {
          console.log(`Producto: ${product.productName} (ID: ${product.documentId})`);
          console.log(`  - Creado por usuario: ${product.userId || 'No especificado'}`);
          console.log(`  - Tiene imágenes: ${product.hasImages ? 'Sí' : 'No'}`);
          if (product.images && product.images.length > 0) {
            console.log(`  - URLs de imágenes:`);
            product.images.forEach((img: any, index: number) => {
              console.log(`    ${index+1}. ${img.url || 'URL no disponible'}`);
            });
          }
        });
        
        // Filtramos los productos usando localStorage y el campo owner_id
        let userProducts = allProducts.filter((product: Product) => {
          // Si el producto tiene owner_id y coincide con el usuario actual
          if (product.owner_id && product.owner_id === userId.toString()) {
            // Guardar en localStorage por si acaso (redundancia)
            saveProductToLocalStorage(product.documentId || '');
            return true;
          }
          
          // Si el producto está en localStorage como propiedad del usuario
          if (product.documentId && isUserProduct(product.documentId)) {
            return true;
          }
          
          // Para productos sin owner_id y que no están en localStorage,
          // los mostramos si son antiguos productos del sistema
          return !product.owner_id;
        });
        
        console.log(`Mostrando productos filtrados para el usuario: ${session?.user?.email}`);
        console.log(`Total de productos filtrados: ${userProducts.length}`);
        
        // Añadimos el ID del usuario actual a cada producto para permitir su edición
        if (session?.user?.id) {
          userProducts = userProducts.map((product: Product) => ({
            ...product,
            userId: session.user?.id || ''  // Asignamos el ID del usuario actual con verificación de nulo
          }));
        }
        
        console.log(`Productos filtrados para el usuario actual: ${userProducts.length}`);
        setProducts(userProducts);
      } else if (result) {
        // Intentar manejar otras estructuras posibles de respuesta
        console.log('Estructura alternativa detectada, intentando adaptar.');
        try {
          // Verificar otras posibles estructuras en la respuesta
          const productsData = result.products || 
                             (result.data && result.data.products) || 
                             [];
          
          if (Array.isArray(productsData) && productsData.length > 0) {
            console.log(`Datos recuperados en formato alternativo: ${productsData.length} productos`);
            
            // Mapear productos al formato que espera nuestra aplicación
            const mappedProducts = productsData.map((item: any) => {
              return {
                documentId: item.documentId || item.id || '',
                id: item.documentId || item.id || '',
                productName: item.productName || item.name || '',
                slug: item.slug || '',
                description: item.description || '',
                price: typeof item.price === 'number' ? item.price : 0,
                active: item.active || false,
                createdAt: item.createdAt || '',
                userId: session?.user?.id || '',  // Asignamos el ID del usuario actual
                hasImages: Boolean(item.images && item.images.length > 0),
                images: item.images || [],
              } as Product;
            });
            
            setProducts(mappedProducts);
          } else {
            setError('No se encontraron productos en la respuesta.');
          }
        } catch (extractError) {
          console.error('Error al procesar estructura alternativa:', extractError);
          setError('Formato de respuesta no reconocido.');
        }
      } else {
        setError('No se encontraron productos o formato de respuesta inesperado.');
      }
    } catch (err) {
      console.error('Error al cargar productos:', err);
      setError(err instanceof Error ? err.message : 'Error al cargar productos');
    } finally {
      setIsLoading(false);
    }
  };

  // Función para subir imágenes
  const uploadImages = async (files: File[], productId: string) => {
    if (!files.length) return [];

    console.log(`Subiendo ${files.length} imágenes para el producto ${productId}`);
    
    const formData = new FormData();
    
    // Añadir cada archivo al formData
    files.forEach(file => {
      formData.append('files', file);
    });
    
    // Añadir el campo ref para relacionarlo con el producto
    formData.append('ref', 'api::product.product');
    formData.append('refId', productId);
    formData.append('field', 'images');

    try {
      const jwt = (session?.user as any)?.jwt;
      
      if (!jwt) {
        throw new Error('No se encontró token de autenticación.');
      }

      // Hacer la petición al endpoint de carga de imágenes
      const response = await fetch(`/api/graphql/proxy/upload`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${jwt}`,
        },
        body: formData,
      });

      if (!response.ok) {
        console.error(`Error HTTP: ${response.status} ${response.statusText}`);
        const errorBody = await response.text();
        console.error('Cuerpo del error:', errorBody);
        console.warn('Continuando sin imágenes debido al error');
        return [];
      }

      const data = await response.json();
      console.log('Respuesta exitosa de subida de imágenes:', data);

      if (Array.isArray(data)) {
        return data.map((img: any) => img.id || img._id || '');
      } else if (data.data && Array.isArray(data.data)) {
        return data.data.map((img: any) => img.id || img._id || '');
      }
      return [];
    } catch (error) {
      console.error('Error en la petición de subida de imágenes:', error);
      return [];
    }
  };

  // Función para crear un nuevo producto
  const createProduct = async (productData: Product) => {
    setOperationLoading(true);
    setOperationError(null);
    setOperationSuccess(null);

    try {
      const jwt = (session?.user as any)?.jwt;
      const userId = (session?.user as any)?.id;

      if (!jwt || !userId) {
        setOperationError('No se encontró token de autenticación o ID de usuario.');
        return;
      }

      if (!productData.slug && productData.productName) {
        productData.slug = generateSlug(productData.productName);
      }

      // Incluir solo campos que sabemos que funcionan con Strapi v5
      const inputData: ProductInput = {
        productName: productData.productName,
        slug: productData.slug || generateSlug(productData.productName),
        description: productData.description,
        price: productData.price,
        active: productData.active,
        isFeatured: productData.isFeatured,
        weight: productData.weight,
        dimensions: productData.dimensions,
        // Campo simple para identificar al propietario del producto
        owner_id: userId.toString(),
        // La forma correcta de asociar un producto con un usuario en Strapi v5
        // es mediante una lista de IDs en el campo users_permissions_users
        users_permissions_users: [userId.toString()]
        // Omitimos los campos problemáticos como dateManufactured y State que requieren formatos específicos
      };

      console.log(`Crear producto con datos:`, inputData);

      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        CREATE_PRODUCT,
        { data: inputData },
        { Authorization: `Bearer ${jwt}` }
      );

      console.log('Respuesta crear producto:', result);

      if (result && result.createProduct) {
        const createdProduct = result.createProduct;

        const documentId =
          createdProduct.documentId ||
          (createdProduct.data?.documentId) ||
          createdProduct.id ||
          `temp-${Date.now()}`;

        console.log(`Producto creado con ID ${documentId}`);
        
        // Guardar el ID del producto en localStorage para persistencia
        saveProductToLocalStorage(documentId);

        const productObj: Product = {
          documentId,
          productName: productData.productName,
          slug: productData.slug,
          description: productData.description,
          price: productData.price,
          active: productData.active,
          isFeatured: productData.isFeatured,
          weight: productData.weight,
          dimensions: productData.dimensions,
          dateManufactured: productData.dateManufactured,
          remaininWarranty: productData.remaininWarranty,
          State: productData.State,
          cityName: productData.cityName,
          provinceName: productData.provinceName,
          countryName: productData.countryName,
          directionName: productData.directionName,
          latitud: productData.latitud,
          longitud: productData.longitud,
          userId,
          hasImages: false,
          images: [],
        };

        if (selectedFiles.length > 0) {
          try {
            const imageIds = await uploadImages(selectedFiles, documentId);
            productObj.hasImages = imageIds.length > 0;
            console.log('Imágenes subidas con éxito:', imageIds);
          } catch (imageError) {
            console.error('Error al subir imágenes:', imageError);
            setOperationError('Producto creado, pero hubo un error al subir las imágenes.');
          }
        }

        setProducts([...products, productObj]);
        setOperationSuccess('Producto creado correctamente.');
        setIsDialogOpen(false);
        setSelectedFiles([]);
      } else {
        setOperationError('No se pudo crear el producto o formato de respuesta inesperado.');
        console.error('Formato de respuesta inesperado:', result);
      }
    } catch (err: any) {
      console.error('Error al crear producto:', err);
      setOperationError(err.message || 'Error al crear el producto');
    } finally {
      setOperationLoading(false);
    }
  };

  // Función para actualizar un producto existente
  const updateProduct = async (documentId: string, productData: Product) => {
    setOperationLoading(true);
    setOperationError(null);
    setOperationSuccess(null);

    try {
      const jwt = (session?.user as any)?.jwt;
      const userId = (session?.user as any)?.id;

      if (!jwt || !userId) {
        setOperationError('No se encontró token de autenticación o ID de usuario.');
        return;
      }

      if (productData.userId && productData.userId !== userId) {
        setOperationError('No tienes permiso para modificar este producto.');
        return;
      }

      // Incluir solo campos que sabemos que funcionan con Strapi v5
      const inputData: ProductInput = {
        productName: productData.productName,
        slug: productData.slug,
        description: productData.description,
        price: productData.price,
        active: productData.active,
        isFeatured: productData.isFeatured,
        weight: productData.weight,
        dimensions: productData.dimensions,
        // Campo simple para identificar al propietario del producto
        owner_id: userId.toString(),
        // La forma correcta de asociar un producto con un usuario en Strapi v5
        // es mediante una lista de IDs en el campo users_permissions_users
        users_permissions_users: [userId.toString()]
        // Omitimos los campos problemáticos como dateManufactured y State que requieren formatos específicos
      };

      console.log(`Actualizando producto ID ${documentId} con datos:`, inputData);

      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        UPDATE_PRODUCT,
        {
          documentId: documentId,
          data: inputData,
        },
        { Authorization: `Bearer ${jwt}` }
      );

      console.log('Respuesta actualizar producto:', result);

      if (result && result.updateProduct) {
        const updatedData = result.updateProduct;

        const productObj: Product = {
          documentId,
          productName: updatedData?.productName || productData.productName,
          slug: updatedData?.slug || productData.slug,
          description: updatedData?.description || productData.description,
          price: updatedData?.price || productData.price,
          active: updatedData?.active || productData.active,
          isFeatured: updatedData?.isFeatured || productData.isFeatured,
          weight: updatedData?.weight || productData.weight,
          dimensions: updatedData?.dimensions || productData.dimensions,
          dateManufactured: updatedData?.dateManufactured || productData.dateManufactured,
          remaininWarranty: updatedData?.remaininWarranty || productData.remaininWarranty,
          State: updatedData?.State || productData.State,
          cityName: updatedData?.cityName || productData.cityName,
          provinceName: updatedData?.provinceName || productData.provinceName,
          countryName: updatedData?.countryName || productData.countryName,
          directionName: updatedData?.directionName || productData.directionName,
          latitud: updatedData?.latitud || productData.latitud,
          longitud: updatedData?.longitud || productData.longitud,
          userId,
          hasImages: productData.hasImages || false,
          images: productData.images || [],
        };

        if (selectedFiles.length > 0) {
          try {
            await uploadImages(selectedFiles, documentId);
            productObj.hasImages = true;
          } catch (error) {
            setOperationError(`Producto actualizado pero hubo un error al subir las imágenes: ${error instanceof Error ? error.message : 'Error desconocido'}`);
          }
        }

        setProducts(products.map((p) => (p.documentId === documentId ? productObj : p)));
        setOperationSuccess('Producto actualizado correctamente.');
        setIsDialogOpen(false);
        setSelectedFiles([]);
      } else {
        setOperationError('No se pudo actualizar el producto o formato de respuesta inesperado.');
        console.error('Formato de respuesta inesperado:', result);
      }
    } catch (err: any) {
      console.error('Error al actualizar producto:', err);
      setOperationError(err.message || 'Error al actualizar el producto');
    } finally {
      setOperationLoading(false);
    }
  };

  // Función para eliminar un producto
  const deleteProduct = async (documentId: string) => {
    if (!confirm('¿Estás seguro de que quieres eliminar este producto? Esta acción no se puede deshacer.')) {
      return;
    }

    setOperationLoading(true);
    setOperationError(null);
    setOperationSuccess(null);

    try {
      const jwt = (session?.user as any)?.jwt;
      const userId = (session?.user as any)?.id;

      if (!jwt || !userId) {
        setOperationError('No se encontró token de autenticación o ID de usuario.');
        return;
      }

      const productToDelete = products.find((p) => p.documentId === documentId);

      if (productToDelete?.userId && productToDelete.userId !== userId) {
        setOperationError('No tienes permiso para eliminar este producto.');
        return;
      }

      console.log(`Eliminando producto ID ${documentId}`);

      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        DELETE_PRODUCT,
        {
          documentId: documentId,
        },
        { Authorization: `Bearer ${jwt}` }
      );

      console.log('Respuesta eliminar producto:', result);

      if (result || result?.deleteProduct) {
        setProducts(products.filter((p) => p.documentId !== documentId));
        setOperationSuccess('Producto eliminado correctamente.');

        if (isDialogOpen) {
          setIsDialogOpen(false);
        }
      } else {
        setOperationError('No se pudo eliminar el producto o formato de respuesta inesperado.');
        console.error('Formato de respuesta inesperado:', result);
      }
    } catch (err: any) {
      console.error('Error al eliminar producto:', err);
      setOperationError(err.message || 'Error al eliminar el producto');
    } finally {
      setOperationLoading(false);
    }
  };

  // Manejador para el cambio de campos en el formulario
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;

    if (name === 'productName' && dialogMode === 'create') {
      setCurrentProduct({
        ...currentProduct,
        productName: value,
        slug: generateSlug(value),
      });
    } else {
      setCurrentProduct({
        ...currentProduct,
        [name]: name === 'price' ? parseFloat(value) || 0 : value,
      });
    }
  };

  // Manejador para el cambio de imágenes
  const handleImagesChange = (files: File[]) => {
    setSelectedFiles(files);
  };

  // Manejador para eliminar imágenes existentes
  const handleExistingImageRemove = async (index: number) => {
    if (!currentProduct.documentId || !currentProduct.images || !currentProduct.images[index]) {
      return;
    }

    const jwt = (session?.user as any)?.jwt;
    if (!jwt) {
      setOperationError('No se encontró token de autenticación.');
      return;
    }

    try {
      const imageToDelete = currentProduct.images[index];

      const imageId = (imageToDelete as any).id || imageToDelete.url.split('/').pop();

      const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/upload/files/${imageId}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${jwt}`,
        },
      });

      if (!response.ok) {
        throw new Error('No se pudo eliminar la imagen');
      }

      const updatedImages = [...(currentProduct.images || [])];
      updatedImages.splice(index, 1);

      setCurrentProduct({
        ...currentProduct,
        images: updatedImages,
        hasImages: updatedImages.length > 0,
      });

      setProducts(
        products.map((p) =>
          p.documentId === currentProduct.documentId ? { ...p, images: updatedImages } : p
        )
      );
    } catch (error) {
      console.error('Error al eliminar imagen:', error);
      setOperationError(`Error al eliminar la imagen: ${error instanceof Error ? error.message : 'Error desconocido'}`);
    }
  };

  // Manejador para enviar el formulario
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (session?.user) {
      const userId = (session.user as any).id;
      currentProduct.userId = userId;
    }

    console.log('Enviando producto con datos:', currentProduct);

    if (dialogMode === 'create') {
      createProduct(currentProduct);
    } else if (dialogMode === 'edit' && currentProduct.documentId) {
      updateProduct(currentProduct.documentId, currentProduct);
    }
  };

  // Iniciar edición de un producto
  const startEdit = (product: Product) => {
    setCurrentProduct({
      documentId: product.documentId,
      productName: product.productName,
      slug: product.slug,
      description: product.description,
      price: product.price,
      active: product.active,
      isFeatured: product.isFeatured,
      weight: product.weight,
      dimensions: product.dimensions,
      dateManufactured: product.dateManufactured,
      remaininWarranty: product.remaininWarranty,
      State: product.State,
      cityName: product.cityName,
      provinceName: product.provinceName,
      countryName: product.countryName,
      directionName: product.directionName,
      latitud: product.latitud,
      longitud: product.longitud,
      createBy: product.createBy || '',
      // users_permissions_users eliminado para evitar errores
    });
    setDialogMode('edit');
    setIsDialogOpen(true);
  };

  // Iniciar creación de un producto
  const startCreate = () => {
    setCurrentProduct({
      productName: '',
      slug: '',
      description: '',
      price: 0,
      active: true,
      isFeatured: false,
      weight: 0,
      dimensions: '',
      dateManufactured: '',
      remaininWarranty: '',
      State: '',
      cityName: '',
      provinceName: '',
      countryName: '',
      directionName: '',
      latitud: 0,
      longitud: 0,
      createBy: '',
      // users_permissions_users eliminado para evitar errores
    });
    setDialogMode('create');
    setIsDialogOpen(true);
    setSelectedFiles([]); // Limpiar las imágenes seleccionadas al iniciar la creación
  };

  // Renderizado del componente
  return (
    <div>
      <Card className="mb-6">
        <CardHeader>
          <CardTitle>Gestión de Productos</CardTitle>
          <div className="text-sm text-gray-500">
            Gestiona tus productos desde este panel
          </div>
        </CardHeader>
        <CardContent>
          <Button onClick={startCreate} className="mb-4">
            Añadir Nuevo Producto
          </Button>

          {operationSuccess && (
            <Alert className="mb-4 bg-green-50 text-green-800 border-green-200">
              <AlertDescription>{operationSuccess}</AlertDescription>
            </Alert>
          )}

          {operationError && (
            <Alert className="mb-4 bg-red-50 text-red-800 border-red-200">
              <AlertDescription>{operationError}</AlertDescription>
            </Alert>
          )}

          {isLoading ? (
            <div className="py-10 text-center">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900 mx-auto"></div>
              <p className="mt-2">Cargando productos...</p>
            </div>
          ) : error ? (
            <Alert className="mb-4 bg-red-50 text-red-800 border-red-200">
              <AlertDescription>{error}</AlertDescription>
            </Alert>
          ) : products.length === 0 ? (
            <div className="text-center py-10">
              <Alert className="my-4">
                <AlertDescription>No tienes productos creados aún.</AlertDescription>
              </Alert>

              <Alert className="my-4">
                <AlertDescription>Crea un producto utilizando el botón superior.</AlertDescription>
              </Alert>

              <Alert className="my-4">                
                <AlertDescription>Los productos se mostrarán en esta tabla.</AlertDescription>
              </Alert>
            </div>
          ) : (
            <div className="rounded-md border">
              <Table>
                <TableCaption>Tus productos creados</TableCaption>
                <TableHeader>
                  <TableRow>
                    <TableHead className="w-[150px]">Nombre</TableHead>
                    <TableHead>Descripción</TableHead>
                    <TableHead>Precio</TableHead>
                    <TableHead className="text-right">Acciones</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {products.map((product) => (
                    <TableRow key={product.documentId}>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          {product.hasImages && (
                            <div className="relative w-8 h-8 overflow-hidden rounded-sm bg-gray-100 flex items-center justify-center">
                              <div className="text-gray-400 text-xs">IMG</div>
                            </div>
                          )}
                          <span className="font-medium">{product.productName}</span>
                        </div>
                      </TableCell>
                      <TableCell className="max-w-[300px] truncate">{product.description}</TableCell>
                      <TableCell className="text-right">{product.price?.toFixed(2)}€</TableCell>
                      <TableCell className="text-center">
                        <div className="flex justify-center gap-2">
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => startEdit(product)}
                          >
                            Editar
                          </Button>
                          <Button
                            variant="destructive"
                            size="sm"
                            onClick={() => deleteProduct(product.documentId!)}
                            disabled={operationLoading}
                          >
                            Eliminar
                          </Button>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          )}
        </CardContent>
      </Card>

      <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
        <DialogContent className="sm:max-w-[525px] bg-white border shadow-lg">
          <DialogHeader className="bg-gray-50 rounded-t-lg p-4">
            <DialogTitle>{dialogMode === 'create' ? 'Crear nuevo producto' : 'Editar producto'}</DialogTitle>
            <DialogDescription>Completa los detalles del producto para {dialogMode === 'create' ? 'crearlo' : 'actualizarlo'}</DialogDescription>
          </DialogHeader>
          
          <form onSubmit={handleSubmit} className="p-4 space-y-4">
            <div className="grid gap-4">
              <div className="space-y-2">
                <Label htmlFor="productName">Nombre del producto</Label>
                <Input
                  id="productName"
                  name="productName"
                  placeholder="Nombre descriptivo del producto"
                  value={currentProduct.productName}
                  onChange={(e) => {
                    const newName = e.target.value;
                    setCurrentProduct({
                      ...currentProduct,
                      productName: newName,
                      slug: generateSlug(newName),
                    });
                  }}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="slug">URL amigable</Label>
                <Input
                  id="slug"
                  name="slug"
                  placeholder="Autogenerado desde el nombre"
                  value={currentProduct.slug}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, slug: e.target.value })}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="description">Descripción</Label>
                <Textarea
                  id="description"
                  name="description"
                  placeholder="Describe el producto detalladamente..."
                  value={currentProduct.description}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, description: e.target.value })}
                  required
                  rows={4}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="price">Precio (€)</Label>
                <Input
                  id="price"
                  name="price"
                  type="number"
                  min="0"
                  step="0.01"
                  placeholder="Ej: 29.99"
                  value={currentProduct.price.toString()}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, price: parseFloat(e.target.value) })}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="active">Estado del producto</Label>
                <Select
                  value={currentProduct.active ? 'true' : 'false'}
                  onValueChange={(value) =>
                    setCurrentProduct({
                      ...currentProduct,
                      active: value === 'true',
                    })
                  }
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Seleccionar estado" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="true">Activo</SelectItem>
                    <SelectItem value="false">Inactivo</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="isFeatured">Producto destacado</Label>
                <Select
                  value={currentProduct.isFeatured ? 'true' : 'false'}
                  onValueChange={(value) =>
                    setCurrentProduct({
                      ...currentProduct,
                      isFeatured: value === 'true',
                    })
                  }
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Seleccionar si es destacado" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="true">Destacado</SelectItem>
                    <SelectItem value="false">No destacado</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="weight">Peso</Label>
                <Input
                  id="weight"
                  name="weight"
                  type="number"
                  min="0"
                  step="0.01"
                  placeholder="Peso en kg"
                  value={currentProduct.weight?.toString() || ''}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, weight: parseFloat(e.target.value) })}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="dimensions">Dimensiones</Label>
                <Input
                  id="dimensions"
                  name="dimensions"
                  placeholder="Ej: 20 x 30 x 15 cm"
                  value={currentProduct.dimensions || ''}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, dimensions: e.target.value })}
                />
              </div>
            </div>
            
            <div className="grid gap-2 mt-4">
              <Label>Imágenes del producto</Label>
              <ImageUpload 
                selectedFiles={selectedFiles}
                setSelectedFiles={setSelectedFiles}
                existingImages={currentProduct.images || []}
                onRemoveExistingImage={handleExistingImageRemove}
              />
            </div>
            
            <div className="flex justify-end mt-4 space-x-2">
              <Button
                variant="outline"
                onClick={() => setIsDialogOpen(false)}
              >
                Cancelar
              </Button>
              <Button 
                type="submit"
                disabled={operationLoading}
              >
                {operationLoading ? (
                  <>
                    <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Procesando...
                  </>
                ) : dialogMode === 'create' ? 'Crear producto' : 'Actualizar producto'}
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
