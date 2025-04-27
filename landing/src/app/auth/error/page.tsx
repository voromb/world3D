'use client';

import { useEffect, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import Link from 'next/link';

export default function AuthErrorPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [errorMessage, setErrorMessage] = useState('');

  useEffect(() => {
    const error = searchParams.get('error');
    
    if (error) {
      switch (error) {
        case 'CredentialsSignin':
          setErrorMessage('Credenciales incorrectas. Por favor, verifica tu email y contraseña.');
          break;
        case 'OAuthSignin':
          setErrorMessage('Error al iniciar sesión con proveedor externo.');
          break;
        case 'OAuthCallback':
          setErrorMessage('Error al procesar la respuesta del proveedor de autenticación.');
          break;
        case 'OAuthCreateAccount':
          setErrorMessage('Error al crear una cuenta usando el proveedor externo.');
          break;
        case 'EmailCreateAccount':
          setErrorMessage('Error al crear una cuenta. El email podría estar ya en uso.');
          break;
        case 'Callback':
          setErrorMessage('Error en el proceso de autenticación.');
          break;
        case 'OAuthAccountNotLinked':
          setErrorMessage('Este email ya está registrado con otro método de inicio de sesión.');
          break;
        case 'EmailSignin':
          setErrorMessage('Error al enviar el email de verificación.');
          break;
        case 'SessionRequired':
          setErrorMessage('Necesitas iniciar sesión para acceder a esta página.');
          break;
        default:
          setErrorMessage('Ha ocurrido un error durante la autenticación.');
      }
    } else {
      setErrorMessage('Ha ocurrido un error desconocido.');
    }
  }, [searchParams]);

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Error de autenticación
        </h2>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div className="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <div className="bg-red-50 border-l-4 border-red-400 p-4 mb-6">
            <p className="text-red-700">{errorMessage}</p>
          </div>

          <div className="flex flex-col space-y-4">
            <Link 
              href="/auth/login"
              className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
              Volver a iniciar sesión
            </Link>
            
            <Link 
              href="/"
              className="w-full flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
              Volver a la página principal
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
