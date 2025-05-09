import React, { useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { useAuthStore } from '@/lib/store/auth-store';

interface AuthProviderProps {
  children: React.ReactNode;
}

export function AuthProvider({ children }: AuthProviderProps) {
  const { data: session, status } = useSession();
  const { setUser, setLoading } = useAuthStore();
  
  useEffect(() => {
    // Cuando el estado de la sesión cambia, actualizamos el store de Zustand
    if (status === 'loading') {
      setLoading(true);
    } else if (status === 'authenticated' && session?.user) {
      // Extraer usuario y JWT de la sesión de NextAuth
      const user = {
        id: session.user.id || '',
        name: session.user.name || '',
        email: session.user.email || '',
        image: session.user.image || '',
      };
      
      setUser(user, session.jwt || null);
    } else {
      // No autenticado
      setUser(null, null);
    }
  }, [session, status, setUser, setLoading]);
  
  return <>{children}</>;
}
