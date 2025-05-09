import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { signIn, signOut } from 'next-auth/react';

interface User {
  id: string;
  name?: string;
  email?: string;
  image?: string;
}

interface AuthState {
  user: User | null;
  jwt: string | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  
  // Acciones
  login: (credentials: { identifier: string; password: string }) => Promise<boolean>;
  logout: () => Promise<void>;
  setUser: (user: User | null, jwt: string | null) => void;
  setLoading: (isLoading: boolean) => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      jwt: null,
      isAuthenticated: false,
      isLoading: true,
      
      // Iniciar sesión con credenciales
      login: async (credentials) => {
        try {
          const response = await signIn('credentials', {
            redirect: false,
            identifier: credentials.identifier,
            password: credentials.password,
          });
          
          if (response?.ok) {
            return true;
          }
          return false;
        } catch (error) {
          console.error('Error al iniciar sesión:', error);
          return false;
        }
      },
      

      
      // Cerrar sesión
      logout: async () => {
        await signOut({ callbackUrl: '/' });
        set({ user: null, jwt: null, isAuthenticated: false });
      },
      
      // Establecer usuario y token JWT
      setUser: (user, jwt) => {
        set({ 
          user, 
          jwt, 
          isAuthenticated: !!user && !!jwt,
          isLoading: false
        });
      },
      
      // Establecer estado de carga
      setLoading: (isLoading) => {
        set({ isLoading });
      },
    }),
    {
      name: 'auth-storage', // Nombre para localStorage
      partialize: (state) => ({ 
        user: state.user,
        jwt: state.jwt,
        isAuthenticated: state.isAuthenticated
      }),
    }
  )
);
