'use client';

import { useState, useEffect } from 'react';
import { useSession, signOut } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import Image from 'next/image';
import { User, LogOut, Heart, Settings, ChevronDown } from 'lucide-react';
import { getGravatarUrl } from '@/utils/gravatar';


// Props para el componente UserMenu
interface UserMenuProps {
  router: any;
}

// Componente para mostrar el menú de usuario con avatar
export default function UserMenu({ router }: UserMenuProps) {
  const { data: session, status } = useSession();
  const [menuOpen, setMenuOpen] = useState(false);
  const [avatarUrl, setAvatarUrl] = useState<string>('');
  
  // esto es para poner el avatar
  useEffect(() => {
    if (status === 'authenticated' && session?.user) {
      // coger el email
      const email = session.user.email || '';
      // lo pongo de 50px porq asi queda bien en el menu
      setAvatarUrl(getGravatarUrl(email, 50, 'identicon'));
    }
  }, [session, status]);
  
  // Si está cargando, mostrar un placeholder
  if (status === 'loading') {
    return (
      <div className="h-8 w-8 rounded-full bg-gray-200 animate-pulse"></div>
    );
  }
  
  // Si no está autenticado, mostrar enlace de inicio de sesión
  if (status === 'unauthenticated') {
    return (
      <Link href="/auth/login">
        <User strokeWidth="1" className="cursor-pointer" />
      </Link>
    );
  }
  
  // Si está autenticado, mostrar el menú con avatar
  return (
    <div className="relative">
      <div 
        className="flex items-center gap-1 cursor-pointer" 
        onClick={() => setMenuOpen(!menuOpen)}
      >
        {avatarUrl ? (
          <div className="h-8 w-8 rounded-full overflow-hidden relative">
            <Image 
              src={avatarUrl} 
              alt="Avatar del usuario" 
              width={32}
              height={32}
              className="object-cover" 
            />
          </div>
        ) : (
          <div className="h-8 w-8 flex items-center justify-center rounded-full bg-blue-50 text-blue-700">
            <span className="text-xs font-semibold">
              {session?.user?.name?.charAt(0).toUpperCase() || 'U'}
            </span>
          </div>
        )}
        <ChevronDown size={16} className="text-gray-600" />
      </div>

      {menuOpen && (
        <div 
          className="absolute right-0 mt-2 w-48 rounded-md shadow-lg py-1 bg-white ring-1 ring-black ring-opacity-5 z-50"
          onMouseLeave={() => setMenuOpen(false)}
        >
          <div className="px-4 py-2 text-xs text-gray-500 border-b">
            {session?.user?.email}
          </div>

          <Link 
            href="/profile" 
            className="px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 flex items-center"
            onClick={() => setMenuOpen(false)}
          >
            <Settings size={16} className="mr-2" />
            Mi perfil
          </Link>

          <Link 
            href="/loved-products" 
            className="px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 flex items-center"
            onClick={() => setMenuOpen(false)}
          >
            <Heart size={16} className="mr-2" />
            Mis favoritos
          </Link>

          <button
            onClick={() => signOut({ callbackUrl: '/' })}
            className="w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-gray-100 flex items-center"
          >
            <LogOut size={16} className="mr-2" />
            Cerrar sesión
          </button>
        </div>
      )}
    </div>
  );
}
