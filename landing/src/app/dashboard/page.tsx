'use client';

import { useSession } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import { useEffect } from 'react';
import ProductDashboard from '@/components/dashboard/product-dashboard';

export default function DashboardPage() {
  const { data: session, status } = useSession();
  const router = useRouter();

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

  // Si el usuario está autenticado, mostrar el dashboard
  return (
    <div className="container mx-auto p-6">
      <h1 className="text-3xl font-bold mb-6">Panel de Administración</h1>
      
      {/* Información del usuario autenticado */}
      <div className="bg-blue-50 p-4 rounded-lg mb-8">
        <p className="text-sm">
          Sesión iniciada como: <span className="font-semibold">{session?.user?.name}</span> ({session?.user?.email})
        </p>
      </div>

      {/* Dashboard de productos */}
      <ProductDashboard />
    </div>
  );
}
