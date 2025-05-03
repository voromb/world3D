import { create } from 'zustand';
import { cartService } from '../services/cart-service';

// Definimos la interfaz para un producto en el carrito
export interface CartItem {
  documentId: string;
  productName: string;
  price: number;
  quantity: number;
  slug: string;
  imageUrl?: string;
}

// Interfaz para nuestra tienda del carrito
interface CartStore {
  items: CartItem[];
  totalItems: number;
  totalPrice: number;
  
  // Acciones
  addItem: (item: CartItem) => void;
  removeItem: (documentId: string) => void;
  updateQuantity: (documentId: string, quantity: number) => void;
  clearCart: () => void;
}

// Creamos la tienda sin persistencia (ahora la persistencia está en la base de datos)
export const useCartStore = create<CartStore>()((set, get) => {
  // Intentamos cargar el carrito al iniciar
  let cartId: number | null = null;
  
  // Función para cargar los productos del carrito desde la API
  const loadCartItems = async () => {
    if (!cartId) {
      cartId = await cartService.getOrCreateCart();
    }
    
    if (cartId) {
      const items = await cartService.getCartItems(cartId);
      const totalItems = items.reduce((sum, item) => sum + item.quantity, 0);
      const totalPrice = items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
      
      set({
        items,
        totalItems,
        totalPrice
      });
    }
  };
  
  // Cargar el carrito al inicializar el store
  loadCartItems();
  
  return {
    items: [],
    totalItems: 0,
    totalPrice: 0,
      
      // Añadir producto al carrito
      addItem: async (item: CartItem) => {
        // Primero actualizamos la UI para una experiencia más rápida
        const currentItems = get().items;
        const existingItem = currentItems.find(
          (i) => i.documentId === item.documentId
        );
        
        let newItems: CartItem[];
        
        if (existingItem) {
          // Si el producto ya existe, actualizamos su cantidad
          newItems = currentItems.map((i) =>
            i.documentId === item.documentId
              ? { ...i, quantity: i.quantity + item.quantity }
              : i
          );
        } else {
          // Si no existe, lo añadimos al carrito
          newItems = [...currentItems, item];
        }
        
        // Calculamos los totales
        const totalItems = newItems.reduce((sum, item) => sum + item.quantity, 0);
        const totalPrice = newItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        
        set({
          items: newItems,
          totalItems,
          totalPrice
        });
        
        // Luego sincronizamos con la base de datos
        if (!cartId) {
          cartId = await cartService.getOrCreateCart();
        }
        
        if (cartId) {
          // Añadir o actualizar en la base de datos
          const product = {
            id: parseInt(item.documentId),
            attributes: {
              title: item.productName,
              price: item.price,
              slug: item.slug
            }
          };
          
          await cartService.addItem(cartId, product, item.quantity);
        }
      },
      
      // Eliminar producto del carrito
      removeItem: async (documentId: string) => {
        // Primero actualizamos la UI
        const currentItems = get().items;
        const newItems = currentItems.filter(item => item.documentId !== documentId);
        
        // Calculamos los totales
        const totalItems = newItems.reduce((sum, item) => sum + item.quantity, 0);
        const totalPrice = newItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        
        set({
          items: newItems,
          totalItems,
          totalPrice
        });
        
        // Luego sincronizamos con la base de datos
        await cartService.removeItem(parseInt(documentId));
      },
      
      // Actualizar cantidad de un producto
      updateQuantity: async (documentId: string, quantity: number) => {
        const currentItems = get().items;
        
        // Si la cantidad es 0, eliminamos el producto
        if (quantity <= 0) {
          return get().removeItem(documentId);
        }
        
        // Primero actualizamos la UI
        const newItems = currentItems.map(item => 
          item.documentId === documentId ? { ...item, quantity } : item
        );
        
        // Calculamos los totales
        const totalItems = newItems.reduce((sum, item) => sum + item.quantity, 0);
        const totalPrice = newItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        
        set({
          items: newItems,
          totalItems,
          totalPrice
        });
        
        // Luego sincronizamos con la base de datos
        await cartService.updateItemQuantity(parseInt(documentId), quantity);
      },
      
      // Vaciar el carrito
      clearCart: async () => {
        // Primero actualizamos la UI
        set({
          items: [],
          totalItems: 0,
          totalPrice: 0
        });
        
        // Luego sincronizamos con la base de datos
        if (cartId) {
          await cartService.clearCart(cartId);
        }
      }
    };
  });

