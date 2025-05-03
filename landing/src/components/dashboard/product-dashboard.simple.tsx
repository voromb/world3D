'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { request } from 'graphql-request';
import { FULL_STRAPI_GRAPHQL_URL } from '@/lib/graphql/client';
import {
  GET_PRODUCTS_FOR_DASHBOARD,
  SIMPLIFIED_CREATE_PRODUCT,
  DELETE_PRODUCT,
  generateSlug,
  Product
} from '@/lib/graphql/product-crud';

// Importación de componentes de UI
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Table, TableBody, TableCaption, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import { Alert, AlertDescription } from "@/components/ui/alert";

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
    active: true
  });

  // Estado de la sesión
  const { data: session } = useSession();

  // Efecto para cargar productos al montar el componente
  useEffect(() => {
    if (session?.user) {
      fetchProducts();
    }
  }, [session]);

  // Función para obtener los productos
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
      
      // Hacer la petición a GraphQL para obtener todos los productos
      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        GET_PRODUCTS_FOR_DASHBOARD,
        {},
        { Authorization: `Bearer ${jwt}` }
      );
      
      if (result && result.products && Array.isArray(result.products)) {
        // Mapear los productos y filtrar por usuario
        const allProducts = result.products
          .filter((product: any) => product)
          .map((product: any) => ({
            documentId: product.documentId || '',
            productName: product.productName || '',
            slug: product.slug || '',
            description: product.description || '',
            price: typeof product.price === 'number' ? product.price : 0,
            active: product.active || false,
            owner_id: product.owner_id || ''
          }));
        
        // Filtrar productos por usuario (en el cliente)
        const userProducts = allProducts.filter((product: Product) => 
          product.owner_id === userId.toString()
        );
        
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

      // Preparar datos para la creación
      const productData = {
        productName: currentProduct.productName || 'Nuevo Producto',
        slug: currentProduct.slug || generateSlug(currentProduct.productName || 'nuevo-producto'),
        description: currentProduct.description || '',
        price: typeof currentProduct.price === 'number' ? currentProduct.price : 0,
        active: true,
        owner_id: userId.toString()
      };

      // Enviar petición a GraphQL
      const result: any = await request(
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

      // Enviar petición a GraphQL
      const result: any = await request(
        FULL_STRAPI_GRAPHQL_URL,
        DELETE_PRODUCT,
        { id: documentId },
        { Authorization: `Bearer ${jwt}` }
      );

      if (result && result.deleteProduct) {
        // Eliminar producto de la lista local
        setProducts(products.filter(p => p.documentId !== documentId));
        setOperationSuccess('Producto eliminado con éxito.');
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
                    <TableRow key={product.documentId || product.id}>
                      <TableCell>
                        <div className="font-medium">{product.productName}</div>
                      </TableCell>
                      <TableCell className="max-w-[300px] truncate">{product.description}</TableCell>
                      <TableCell>{product.price?.toFixed(2)}€</TableCell>
                      <TableCell className="text-right">
                        <Button
                          variant="destructive"
                          size="sm"
                          onClick={() => deleteProduct(product.documentId!)}
                          disabled={operationLoading}
                        >
                          Eliminar
                        </Button>
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
        <DialogContent className="sm:max-w-[525px]">
          <DialogHeader>
            <DialogTitle>Crear nuevo producto</DialogTitle>
            <DialogDescription>Completa los detalles del producto para crearlo</DialogDescription>
          </DialogHeader>
          <form onSubmit={createProduct} className="space-y-4">
            <div className="grid gap-4">
              <div className="space-y-2">
                <Label htmlFor="productName">Nombre del producto</Label>
                <Input
                  id="productName"
                  placeholder="Nombre del producto"
                  value={currentProduct.productName}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, productName: e.target.value })}
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="slug">Slug</Label>
                <Input
                  id="slug"
                  placeholder="slug-del-producto"
                  value={currentProduct.slug}
                  onChange={(e) => setCurrentProduct({ ...currentProduct, slug: e.target.value })}
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
                ) : 'Crear producto'}
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
