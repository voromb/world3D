'use client';

import { useSession } from 'next-auth/react';
import { useRouter, usePathname } from 'next/navigation';
import { useEffect } from 'react';
import Link from 'next/link';
import { ShoppingBag, Package, User } from 'lucide-react';

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { data: session, status } = useSession();
  const router = useRouter();
  const pathname = usePathname();

  // Redirigir a la página de login si el usuario no está autenticado
  useEffect(() => {
    if (status === 'unauthenticated') {
      router.push('/auth/login');
    }
  }, [status, router]);

  // Mostrar pantalla de carga mientras se verifica la autenticación
  if (status === 'loading') {
    return (
      <div className="flex justify-center items-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6">
      <h1 className="text-3xl font-bold mb-6">Mi cuenta</h1>
      
      {/* Información del usuario autenticado */}
      <div className="bg-blue-50 p-4 rounded-lg mb-8">
        <p className="text-sm">
          Sesión iniciada como: <span className="font-semibold">{session?.user?.name}</span> ({session?.user?.email})
        </p>
      </div>

      {/* Navegación del dashboard */}
      <div className="flex mb-8 border-b">
        <Link 
          href="/dashboard" 
          className={`mr-6 pb-3 px-2 ${
            pathname === '/dashboard' 
              ? 'border-b-2 border-blue-500 text-blue-500 font-medium' 
              : 'text-gray-500 hover:text-gray-800'
          }`}
        >
          <Package className="inline-block mr-1 h-4 w-4" />
          Mis productos
        </Link>
        
        <Link 
          href="/dashboard/orders" 
          className={`mr-6 pb-3 px-2 ${
            pathname === '/dashboard/orders' 
              ? 'border-b-2 border-blue-500 text-blue-500 font-medium' 
              : 'text-gray-500 hover:text-gray-800'
          }`}
        >
          <ShoppingBag className="inline-block mr-1 h-4 w-4" />
          Mis pedidos
        </Link>
      </div>

      {/* Contenido de la página */}
      {children}
    </div>
  );
}
