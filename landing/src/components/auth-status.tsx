'use client';

import { useSession, signOut } from 'next-auth/react';
import Link from 'next/link';
import { useState } from 'react';
import { ChevronDown } from 'lucide-react';

export default function AuthStatus() {
  const { data: session, status } = useSession();
  const [menuOpen, setMenuOpen] = useState(false);

  if (status === 'loading') {
    return (
      <div className="flex items-center text-sm">
        <span className="text-gray-500">Cargando...</span>
      </div>
    );
  }

  if (status === 'unauthenticated') {
    return (
      <div className="flex items-center space-x-3">
        <Link
          href="/auth/login"
          className="text-sm text-gray-700 hover:text-gray-900"
        >
          Iniciar sesión
        </Link>
        <Link
          href="/auth/register"
          className="text-sm bg-blue-600 hover:bg-blue-700 text-white px-3 py-1 rounded-md"
        >
          Crear cuenta
        </Link>
      </div>
    );
  }

  // Usuario autenticado
  return (
    <div className="relative">
      <div
        className="flex items-center space-x-1 cursor-pointer"
        onClick={() => setMenuOpen(!menuOpen)}
      >
        <span className="text-sm font-medium text-gray-700">
          {session?.user?.name || 'Usuario'}
        </span>
        <ChevronDown className="w-4 h-4 text-gray-500" />
      </div>

      {/* Menú desplegable */}
      {menuOpen && (
        <div
          className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10"
          onMouseLeave={() => setMenuOpen(false)}
        >
          <div className="px-4 py-2 text-xs text-gray-500 border-b">
            {session?.user?.email}
          </div>
          
          <Link
            href="/profile"
            className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
          >
            Mi perfil
          </Link>
          
          <Link
            href="/loved-products"
            className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
          >
            Mis favoritos
          </Link>
          
          {session?.user?.role === 'Super Admin' && (
            <Link
              href="http://localhost:1337/admin"
              target="_blank"
              className="block px-4 py-2 text-sm text-blue-600 hover:bg-gray-100"
            >
              Panel Admin
            </Link>
          )}
          
          <button
            onClick={() => signOut({ callbackUrl: '/' })}
            className="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-gray-100"
          >
            Cerrar sesión
          </button>
        </div>
      )}
    </div>
  );
}
