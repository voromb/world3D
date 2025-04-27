'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import { request } from 'graphql-request';
import { FULL_STRAPI_GRAPHQL_URL } from '@/lib/graphql/client';
import Link from 'next/link';
import Image from 'next/image';
import AvatarUploader from '@/components/avatar-uploader';
import { getGravatarUrl } from '@/utils/gravatar';

// como strapi v5 no deja acceder bien a los avatares usamos gravatar

// esto simula que actualizamos el perfil pero realmente no lo hace todavia
const UPDATE_USER_PROFILE = `
  mutation UpdateUserProfile($username: String, $email: String) {
    updateMe(data: {
      username: $username,
      email: $email
    }) {
      username
      email
    }
  }
`;

// Página de perfil de usuario
export default function ProfilePage() {
  const { data: session, status } = useSession();
  const router = useRouter();
  
  // Estado para los datos del usuario
  const [userData, setUserData] = useState({
    username: '',
    email: '',
    avatar: ''
  });
  
  // Estado para el formulario de edición
  const [formData, setFormData] = useState({
    username: '',
    email: ''
  });
  
  // Estados para el UI
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  // Redirigir si no hay sesión
  useEffect(() => {
    if (status === 'unauthenticated') {
      router.push('/auth/login');
    }
  }, [status, router]);

  // cargar la info del usuario
  useEffect(() => {
    const loadUserData = () => {
      if (status !== 'authenticated' || !session?.user) return;
      
      try {
        setLoading(true);
        
        // cogemos datos de session
        const username = session?.user?.name || 'Usuario';
        const email = session?.user?.email || '';
        
        // usamos gravatar q es mas facil
        const avatarUrl = getGravatarUrl(email, 100, 'identicon');
        
        setUserData({
          username,
          email,
          avatar: avatarUrl
        });
        
        setFormData({
          username,
          email
        });
      } 
      catch (error) {
        console.error('Error al cargar datos del usuario:', error);
        setError('No se pudieron cargar los datos del perfil');
      } 
      finally {
        setLoading(false);
      }
    };

    loadUserData();
  }, [session, status]);

  if (status === 'loading' || loading) {
    return (
      <div className="flex justify-center items-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
      </div>
    );
  }

  // cuando cambia algo en el form
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  // esto es cuando se envia el form
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    setSaving(true);
    
    try {
      if (!session?.user) {
        setError('Error de autenticación. Inicia sesión nuevamente.');
        return;
      }
      
      // falta implementar la llamada a la api, por ahora solo hacemos como q funciona
      setTimeout(() => {
        // actualizar datos locales
        setUserData(prev => ({
          ...prev,
          username: formData.username, 
          email: formData.email
        }));
        
        // nota: el avatar no cambia porq usa el email
        
        setSuccess('Perfil actualizado correctamente (simulado)');
        setEditing(false);
        setSaving(false);
      }, 800); // Simular un pequeño retraso para que parezca real
      
      return; // Evitar que se ejecute el finally demasiado pronto
    } catch (error) {
      console.error('Error al actualizar perfil:', error);
      setError('No se pudo actualizar el perfil. Verifica los datos e inténtalo de nuevo.');
    } finally {
      setSaving(false);
    }
  };
  
  // Manejar actualización de avatar
  const handleAvatarUpdated = (newAvatarUrl: string) => {
    setUserData(prev => ({
      ...prev,
      avatar: newAvatarUrl.startsWith('/') ? `http://localhost:1337${newAvatarUrl}` : newAvatarUrl
    }));
    setSuccess('Avatar actualizado correctamente');
  };

  return (
    <div className="py-10">
      <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
        <h1 className="text-3xl font-bold text-gray-900">Perfil de usuario</h1>
        
        <div className="mt-8 bg-white shadow overflow-hidden sm:rounded-lg">
          <div className="px-4 py-5 sm:px-6 flex justify-between items-center">
            <div>
              <h3 className="text-lg leading-6 font-medium text-gray-900">Información personal</h3>
              <p className="mt-1 max-w-2xl text-sm text-gray-500">Detalles de tu cuenta</p>
            </div>
            
            {!editing && (
              <button
                onClick={() => setEditing(true)}
                className="inline-flex items-center px-3 py-1.5 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
              >
                Editar perfil
              </button>
            )}
          </div>
          
          {error && (
            <div className="mx-4 my-2 bg-red-50 border-l-4 border-red-400 p-4">
              <p className="text-red-700">{error}</p>
            </div>
          )}
          
          {success && (
            <div className="mx-4 my-2 bg-green-50 border-l-4 border-green-400 p-4">
              <p className="text-green-700">{success}</p>
            </div>
          )}
          
          <div className="border-t border-gray-200 px-4 py-5">
            {editing ? (
              <form onSubmit={handleSubmit}>
                <div className="space-y-6">
                  <div>
                    <label htmlFor="username" className="block text-sm font-medium text-gray-700">
                      Nombre de usuario
                    </label>
                    <div className="mt-1">
                      <input
                        id="username"
                        name="username"
                        type="text"
                        required
                        value={formData.username}
                        onChange={handleChange}
                        className="shadow-sm focus:ring-blue-500 focus:border-blue-500 block w-full sm:text-sm border-gray-300 rounded-md"
                      />
                    </div>
                  </div>
                  
                  <div>
                    <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                      Correo electrónico
                    </label>
                    <div className="mt-1">
                      <input
                        id="email"
                        name="email"
                        type="email"
                        required
                        value={formData.email}
                        onChange={handleChange}
                        className="shadow-sm focus:ring-blue-500 focus:border-blue-500 block w-full sm:text-sm border-gray-300 rounded-md"
                      />
                    </div>
                  </div>
                  
                  <div className="flex justify-end space-x-3">
                    <button
                      type="button"
                      onClick={() => setEditing(false)}
                      className="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                    >
                      Cancelar
                    </button>
                    <button
                      type="submit"
                      disabled={saving}
                      className="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50"
                    >
                      {saving ? 'Guardando...' : 'Guardar cambios'}
                    </button>
                  </div>
                </div>
              </form>
            ) : (
              <>
                <dl className="grid grid-cols-1 gap-x-4 gap-y-6 sm:grid-cols-2">
                  <div className="sm:col-span-1">
                    <dt className="text-sm font-medium text-gray-500">Nombre de usuario</dt>
                    <dd className="mt-1 text-sm text-gray-900">{userData.username}</dd>
                  </div>
                  
                  <div className="sm:col-span-1">
                    <dt className="text-sm font-medium text-gray-500">Correo electrónico</dt>
                    <dd className="mt-1 text-sm text-gray-900">{userData.email}</dd>
                  </div>
                </dl>
                
                {/* hay q arreglar esto cuando funcione bien la api */}
                <div className="mt-6">
                  <div className="flex flex-col items-center">
                    <div className="relative h-24 w-24 overflow-hidden rounded-full bg-gray-100 mb-4">
                      <Image 
                        src={userData.avatar}
                        alt="Avatar del usuario"
                        width={96}
                        height={96}
                        className="object-cover"
                      />
                    </div>
                  </div>
                </div>
              </>
            )}
          </div>
          
          <div className="px-4 py-3 bg-gray-50 text-right sm:px-6">
            <Link
              href="/loved-products"
              className="mr-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
              Ver favoritos
            </Link>
            <Link
              href="/"
              className="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
              Volver a inicio
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
