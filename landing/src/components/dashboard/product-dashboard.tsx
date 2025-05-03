'use client';

import { useState, useEffect, useRef } from 'react';
import { useSession } from 'next-auth/react';
import { request } from 'graphql-request';
import { FULL_STRAPI_GRAPHQL_URL } from '@/lib/graphql/client';
import {
  GET_PRODUCTS_FOR_DASHBOARD,
  SIMPLIFIED_CREATE_PRODUCT,
  UPDATE_PRODUCT,
  DELETE_PRODUCT,
  generateSlug,
  Product
} from '@/lib/graphql/product-crud';

// Iconos
import { Trash2, Edit, PlusCircle } from 'lucide-react';
import dynamic from 'next/dynamic';

// Importación dinámica para evitar problemas de hidratación con los iconos
const DynamicTrash2Icon = dynamic(() => Promise.resolve(Trash2), { ssr: false });
const DynamicEditIcon = dynamic(() => Promise.resolve(Edit), { ssr: false });
const DynamicPlusCircleIcon = dynamic(() => Promise.resolve(PlusCircle), { ssr: false });

// Importación de componentes de UI
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

export default function ProductDashboard() {
  // Estado para los productos
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Estado para operaciones
  const [operationLoading, setOperationLoading] = useState(false);
  const [operationError, setOperationError] = useState<string | null>(null);
  const [operationSuccess, setOperationSuccess] = useState<string | null>(null);

  // Estado para el formulario de creación/edición
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [currentProduct, setCurrentProduct] = useState<Product>({
    productName: '',
    slug: '',
    description: '',
    price: 0,
    active: true,
    isFeatured: false,
    weight: 0,
    dimensions: '',
    State: 'Nuevo', // Inicializar con un valor válido en lugar de string vacío
    cityName: '',
    provinceName: '',
    countryName: 'España',
    directionName: ''
  });

  // Abrir diálogo para crear un nuevo producto
  const openCreateDialog = () => {
    // Reiniciar el producto actual a valores predeterminados
    setCurrentProduct({
      productName: '',
      slug: '',
      description: '',
      price: 0,
      active: true,
      isFeatured: false,
      weight: 0,
      dimensions: '',
      State: 'Nuevo', // Inicializar con un valor válido en lugar de string vacío
      cityName: '',
      provinceName: '',
      countryName: 'España',
      directionName: ''
    });
    setIsDialogOpen(true);
  };
  
  // Abrir diálogo para editar un producto existente
  const openEditDialog = (product: Product) => {
    // Clonar el producto para no afectar la referencia original
    const productToEdit = {
      ...product,
      // Asegurar que todos los campos tengan valores válidos
      productName: product.productName || '',
      slug: product.slug || '',
      description: product.description || '',
      price: typeof product.price === 'number' ? product.price : 0,
      active: product.active !== undefined ? product.active : true,
      isFeatured: product.isFeatured !== undefined ? product.isFeatured : false,
      weight: typeof product.weight === 'number' ? product.weight : 0,
      dimensions: product.dimensions || '',
      State: product.State || 'Nuevo',
      cityName: product.cityName || '',
      provinceName: product.provinceName || '',
      countryName: product.countryName || 'España',
      directionName: product.directionName || ''
    };
    
    setCurrentProduct(productToEdit);
    setIsDialogOpen(true);
  };

  // Estado de la sesión
  const { data: session } = useSession();
  
  // Función para obtener los productos - declarada primero para evitar errores
  const fetchProducts = async () => {
    setIsLoading(true);
    setError(null);
    
    try {
      const jwt = (session?.user as any)?.jwt;
      const userId = (session?.user as any)?.id;
      
      if (!jwt || !userId) {
        setError('No se encontró token de autenticación o ID de usuario.');
        setIsLoading(false);
        return;
      }
      
      console.log(`Obteniendo productos para el usuario ID: ${userId}`);
      
      // Consulta directa de productos filtrados por owner_id
      try {
        // Primero intentamos usar el filtro directo por owner_id
        const filteredResult: any = await request(
          FULL_STRAPI_GRAPHQL_URL,
          `query GetUserProducts($userId: String!) {
            products(filters: { owner_id: { eq: $userId } }) {
              documentId
              productName
              description
              price
              active
              owner_id
              slug
              isFeatured
              weight
              dimensions
              State
              cityName
              provinceName
              countryName
              directionName
              createdAt
              updatedAt
            }
          }`,
          { userId: userId.toString() },
          { Authorization: `Bearer ${jwt}` }
        );
        
        console.log('Resultado filtrado:', JSON.stringify(filteredResult, null, 2));
        
        if (filteredResult && filteredResult.products && Array.isArray(filteredResult.products)) {
          console.log(`Encontrados ${filteredResult.products.length} productos filtrados directamente por owner_id`);
          
          // Mapear los productos a nuestro formato
          const userProducts = filteredResult.products.map((product: any) => {
            return {
              id: product.documentId || '', // Usamos documentId como id
              documentId: product.documentId || '',
              productName: product.productName || '',
              slug: product.slug || '',
              description: product.description || '',
              price: typeof product.price === 'number' ? product.price : 0,
              active: product.active || false,
              owner_id: product.owner_id || '',
              isFeatured: product.isFeatured || false,
              weight: product.weight || 0,
              dimensions: product.dimensions || '',
              State: product.State || 'Nuevo',
              cityName: product.cityName || '',
              provinceName: product.provinceName || '',
              countryName: product.countryName || 'España',
              directionName: product.directionName || ''
            };
          });
          
          setProducts(userProducts);
          setIsLoading(false);
          return;
        }
      } catch (filterError) {
        console.log('Error al filtrar por owner_id:', filterError);
        // Si falla el filtrado, continuamos con el enfoque alternativo
      }
      
      // Plan B: Obtener todos los productos y filtrar en el cliente
      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        GET_PRODUCTS_FOR_DASHBOARD,
        {},
        { Authorization: `Bearer ${jwt}` }
      );
      
      console.log('Resultado de obtener todos los productos:', result);
      
      if (result && result.products && Array.isArray(result.products)) {
        // Mapear los productos y filtrar por usuario
        const allProducts = result.products
          .filter((product: any) => product)
          .map((product: any) => ({
            id: product.id || '',
            documentId: product.documentId || '',
            productName: product.productName || '',
            slug: product.slug || '',
            description: product.description || '',
            price: typeof product.price === 'number' ? product.price : 0,
            active: product.active || false,
            owner_id: product.owner_id || '',
            isFeatured: product.isFeatured || false,
            weight: product.weight || 0,
            dimensions: product.dimensions || '',
            State: product.State || 'Nuevo',
            cityName: product.cityName || '',
            provinceName: product.provinceName || '',
            countryName: product.countryName || 'España',
            directionName: product.directionName || ''
          }));
        
        // Depuración: imprimir todos los productos y sus owner_id
        console.log('Todos los productos recuperados:', allProducts.map((p: Product) => ({ id: p.id, documentId: p.documentId, name: p.productName, owner_id: p.owner_id })));
        
        // Filtrar productos por usuario (en el cliente)
        const userProducts = allProducts.filter((product: Product) => {
          // Verificar si el owner_id coincide con el userId actual
          const ownerMatch = product.owner_id && product.owner_id.toString() === userId.toString();
          if (ownerMatch) {
            console.log(`Producto encontrado por owner_id: ${product.productName} (${product.documentId})`);
            return true;
          }
          return false;
        });
        
        console.log(`Encontrados ${userProducts.length} productos para el usuario ${userId}`);
        setProducts(userProducts);
      } else {
        setError('No se pudo obtener la lista de productos.');
      }
    } catch (err) {
      console.error('Error al cargar productos:', err);
      setError(err instanceof Error ? err.message : 'Error al cargar productos');
    } finally {
      setIsLoading(false);
    }
  };

  // Efecto para cargar productos cuando el componente se monta
  useEffect(() => {
    console.log('Montando componente ProductDashboard');
    if (session?.user) {
      console.log('Cargando productos inicialmente...');
      // Cargar productos cuando se monta el componente y hay una sesión
      fetchProducts();
    }
  }, [session]);
  
  // Función para crear un nuevo producto
  const createProduct = async (e: React.FormEvent) => {
    e.preventDefault();
    setOperationLoading(true);
    setOperationError(null);
    setOperationSuccess(null);

    try {
      const jwt = (session?.user as any)?.jwt;
      const userId = (session?.user as any)?.id;

      if (!jwt || !userId) {
        setOperationError('No se encontró token de autenticación o ID de usuario.');
        setOperationLoading(false);
        return;
      }

      // Generar slug automáticamente si está vacío
      const generatedSlug = currentProduct.slug || generateSlug(currentProduct.productName || 'nuevo-producto');
      
      // Preparar datos para la creación con todos los campos
      const productData = {
        productName: currentProduct.productName || 'Nuevo Producto',
        slug: generatedSlug,
        description: currentProduct.description || '',
        price: typeof currentProduct.price === 'number' ? currentProduct.price : 0,
        active: true,
        owner_id: userId.toString(),
        isFeatured: currentProduct.isFeatured || false,
        weight: currentProduct.weight || 0,
        dimensions: currentProduct.dimensions || '',
        State: currentProduct.State || '',
        cityName: currentProduct.cityName || '',
        provinceName: currentProduct.provinceName || '',
        countryName: currentProduct.countryName || 'España',
        directionName: currentProduct.directionName || ''
      };

      // Determinar si estamos creando o actualizando un producto
      let result: any;
      
      if (currentProduct.documentId) {
        console.log('Actualizando producto existente con ID:', currentProduct.documentId);
        
        // Actualizar un producto existente
        result = await request(
          FULL_STRAPI_GRAPHQL_URL,
          UPDATE_PRODUCT,
          { 
            documentId: currentProduct.documentId,
            data: productData 
          },
          { Authorization: `Bearer ${jwt}` }
        );
        
        console.log('Resultado de actualización:', result);
        
        if (result && result.updateProduct) {
          // Actualizar el producto en la lista local
          setProducts(products.map(p => 
            p.documentId === currentProduct.documentId ? result.updateProduct : p
          ));
          setOperationSuccess('Producto actualizado con éxito.');
          setIsDialogOpen(false);
          
          // Recargar la lista de productos
          fetchProducts();
        } else {
          setOperationError('No se pudo actualizar el producto.');
        }
      } else {
        console.log('Creando nuevo producto');
        
        // Crear un nuevo producto
        result = await request(
          FULL_STRAPI_GRAPHQL_URL,
          SIMPLIFIED_CREATE_PRODUCT,
          { data: productData },
          { Authorization: `Bearer ${jwt}` }
        );
        
        if (result && result.createProduct) {
          // Añadir el nuevo producto a la lista
          const newProduct = {
            ...result.createProduct,
            owner_id: userId.toString()
          };
          
          setProducts([...products, newProduct]);
          setOperationSuccess('Producto creado con éxito.');
          setIsDialogOpen(false);
          
          // Recargar la lista de productos
          fetchProducts();
        } else {
          setOperationError('No se pudo crear el producto.');
        }
      }
    } catch (err: any) {
      console.error('Error al crear producto:', err);
      setOperationError(err.message || 'Error al crear el producto');
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

      if (!jwt) {
        setOperationError('No se encontró token de autenticación.');
        setOperationLoading(false);
        return;
      }

      console.log(`Intentando eliminar producto con documentId: ${documentId}`);
      
      // Enviar petición a GraphQL
      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        DELETE_PRODUCT,
        { documentId }, // Asegúrate de que la variable se llame documentId (no id)
        { Authorization: `Bearer ${jwt}` }
      );

      console.log('Resultado de eliminación:', result);

      // En Strapi v5, la respuesta puede tener una estructura diferente
      if (result && result.deleteProduct) {
        // Eliminar producto de la lista local
        setProducts(products.filter(p => p.documentId !== documentId));
        setOperationSuccess('Producto eliminado con éxito.');
        
        // Actualizar la lista de productos
        fetchProducts();
      } else {
        setOperationError('No se pudo eliminar el producto.');
      }
    } catch (err: any) {
      console.error('Error al eliminar producto:', err);
      setOperationError(err.message || 'Error al eliminar el producto');
    } finally {
      setOperationLoading(false);
    }
  };

  // Iniciar creación de un producto
  const startCreate = () => {
    setCurrentProduct({
      productName: '',
      slug: '',
      description: '',
      price: 0,
      active: true
    });
    setIsDialogOpen(true);
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
          <Button
            onClick={() => openCreateDialog()}
            className="mb-4"
          >
            <DynamicPlusCircleIcon className="w-4 h-4 mr-2" /> Añadir Nuevo Producto
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
                    <TableRow key={product.documentId || product.id}>
                      <TableCell>
                        <div className="font-medium">{product.productName}</div>
                      </TableCell>
                      <TableCell className="max-w-[300px] truncate">{product.description}</TableCell>
                      <TableCell>{product.price?.toFixed(2)}€</TableCell>
                      <TableCell className="text-right">
                        <div className="flex justify-end gap-2">
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => openEditDialog(product)}
                            disabled={operationLoading}
                            className="bg-blue-50 hover:bg-blue-100 text-blue-700 border-blue-300"
                          >
                            Editar
                          </Button>
                          <button
                            className="bg-red-600 hover:bg-red-700 text-white font-medium py-1 px-3 rounded text-sm"
                            onClick={() => deleteProduct(product.documentId!)}
                            disabled={operationLoading}
                          >
                            Eliminar
                          </button>
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
        <DialogContent className="sm:max-w-[700px] bg-white border shadow-lg">
          <DialogHeader className="bg-gray-50 rounded-t-lg p-4">
            <DialogTitle>Crear nuevo producto</DialogTitle>
            <DialogDescription>Completa los detalles del producto para crearlo</DialogDescription>
          </DialogHeader>
          <form onSubmit={createProduct} className="p-4 space-y-4">
            <div className="grid gap-4">
              <div className="space-y-2">
                <Label htmlFor="productName">Nombre del producto</Label>
                <Input
                  id="productName"
                  placeholder="Nombre del producto"
                  value={currentProduct.productName}
                  onChange={(e) => {
                    // Al cambiar el nombre, también generamos automáticamente el slug
                    const newName = e.target.value;
                    setCurrentProduct({ 
                      ...currentProduct, 
                      productName: newName,
                      slug: generateSlug(newName) // Generamos el slug automáticamente
                    });
                  }}
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="slug">Slug (generado automáticamente)</Label>
                <Input
                  id="slug"
                  placeholder="slug-del-producto"
                  value={currentProduct.slug}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, slug: e.target.value })}
                  disabled={true} // Deshabilitamos el campo ya que se genera automáticamente
                  className="bg-gray-100"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="description">Descripción</Label>
                <Textarea
                  id="description"
                  placeholder="Descripción del producto"
                  value={currentProduct.description}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, description: e.target.value })}
                  className="min-h-[100px]"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="price">Precio (€)</Label>
                <Input
                  id="price"
                  type="number"
                  placeholder="0"
                  value={currentProduct.price}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, price: parseFloat(e.target.value) })}
                  min="0"
                  step="0.01"
                />
              </div>
            </div>
            
            {/* Campos adicionales organizados en dos columnas */}
            <div className="grid grid-cols-2 gap-4 mt-4">
              <div className="space-y-2">
                <Label htmlFor="isFeatured">Destacado</Label>
                <Select 
                  value={currentProduct.isFeatured ? "true" : "false"}
                  onValueChange={(value) => setCurrentProduct({ ...currentProduct, isFeatured: value === "true" })}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Selecciona si es destacado" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="true">Sí</SelectItem>
                    <SelectItem value="false">No</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="weight">Peso (kg)</Label>
                <Input
                  id="weight"
                  type="number"
                  placeholder="0"
                  value={currentProduct.weight}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, weight: parseFloat(e.target.value) })}
                  min="0"
                  step="0.1"
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="dimensions">Dimensiones</Label>
                <Input
                  id="dimensions"
                  placeholder="Ej: 10x20x30 cm"
                  value={currentProduct.dimensions}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, dimensions: e.target.value })}
                />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="State">Estado</Label>
                <Select 
                  value={currentProduct.State || ""}
                  onValueChange={(value) => setCurrentProduct({ ...currentProduct, State: value })}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Selecciona el estado" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Nuevo">Nuevo</SelectItem>
                    <SelectItem value="Seminuevo">Seminuevo</SelectItem>
                    <SelectItem value="Nuevo Precintado">Nuevo Precintado</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            
            {/* Sección de ubicación */}
            <div className="border-t pt-4 mt-4">
              <h3 className="text-lg font-medium mb-2">Ubicación del producto</h3>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="cityName">Ciudad</Label>
                  <Input
                    id="cityName"
                    placeholder="Ej: Madrid"
                    value={currentProduct.cityName}
                    onChange={(e) => setCurrentProduct({ ...currentProduct, cityName: e.target.value })}
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="provinceName">Provincia</Label>
                  <Input
                    id="provinceName"
                    placeholder="Ej: Madrid"
                    value={currentProduct.provinceName}
                    onChange={(e) => setCurrentProduct({ ...currentProduct, provinceName: e.target.value })}
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="countryName">País</Label>
                  <Input
                    id="countryName"
                    placeholder="Ej: España"
                    value={currentProduct.countryName}
                    onChange={(e) => setCurrentProduct({ ...currentProduct, countryName: e.target.value })}
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="directionName">Dirección</Label>
                  <Input
                    id="directionName"
                    placeholder="Ej: Calle Principal 123"
                    value={currentProduct.directionName}
                    onChange={(e) => setCurrentProduct({ ...currentProduct, directionName: e.target.value })}
                  />
                </div>
              </div>
            </div>
            <div className="flex justify-end space-x-2">
              <Button
                type="button"
                variant="outline"
                onClick={() => setIsDialogOpen(false)}
              >
                Cancelar
              </Button>
              <Button
                type="submit"
                variant="outline"
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
                ) : currentProduct.documentId ? 'Guardar cambios' : 'Crear producto'}
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
