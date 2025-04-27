'use client';

import { useState } from 'react';
import Image from 'next/image';
import { request } from 'graphql-request';
import { FULL_STRAPI_GRAPHQL_URL } from '@/lib/graphql/client';

// Consulta para actualizar el avatar del usuario en Strapi v5
const UPDATE_USER_AVATAR = `
  mutation UpdateUserAvatar($userId: ID!, $avatarId: ID) {
    updateUsersPermissionsUser(
      documentId: $userId,
      data: {
        avatar: $avatarId
      }
    ) {
      documentId
      username
      avatar {
        url
      }
    }
  }
`;

// Tipos para las props del componente
interface AvatarUploaderProps {
  userId: string;
  currentAvatar: string;
  onAvatarUpdated: (newAvatarUrl: string) => void;
}

// Componente para subir avatar
export default function AvatarUploader({ userId, currentAvatar, onAvatarUpdated }: AvatarUploaderProps) {
  const [avatarFile, setAvatarFile] = useState<File | null>(null);
  const [uploading, setUploading] = useState(false);
  const [uploadError, setUploadError] = useState('');
  const [avatarPreview, setAvatarPreview] = useState(currentAvatar);
  const [uploadSuccess, setUploadSuccess] = useState(false);
  
  // Al cambiar el archivo seleccionado
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;
    
    const file = files[0];

    // Validar el tipo de archivo
    if (!file.type.match('image.*')) {
      setUploadError('Por favor, selecciona una imagen válida');
      return;
    }

    // Mostrar vista previa
    const reader = new FileReader();
    reader.onload = (event) => {
      if (event.target?.result) {
        setAvatarPreview(event.target.result as string);
      }
    };
    reader.readAsDataURL(file);
    setAvatarFile(file);
    setUploadError('');
  };

  // Función para subir el avatar
  const uploadAvatar = async () => {
    if (!avatarFile) return;

    setUploading(true);
    setUploadError('');
    
    // Obtener el token JWT de la sesión almacenada
    const session = await fetch('/api/auth/session').then(res => res.json());
    const jwt = session?.user?.jwt;
    
    if (!jwt) {
      console.error('No se encontró token JWT en la sesión');
      setUploadError('Error de autenticación. Por favor, inicia sesión nuevamente.');
      setUploading(false);
      return;
    }

    try {
      // Primero subimos el archivo a la API de upload de Strapi
      const formData = new FormData();
      formData.append('files', avatarFile);
      
      // Extraer la base URL de Strapi de la URL GraphQL
      const strapiBaseUrl = FULL_STRAPI_GRAPHQL_URL.replace('/graphql', '');
      
      // Usamos el endpoint directo de upload de Strapi
      const uploadResponse = await fetch(`${strapiBaseUrl}/api/upload`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${jwt}`
        },
        body: formData,
      });

      if (!uploadResponse.ok) {
        throw new Error('Error al subir la imagen');
      }

      const uploadResult = await uploadResponse.json();
      console.log('Resultado de la carga:', uploadResult);
      
      if (uploadResult && uploadResult.length > 0) {
        // Ahora actualizamos el perfil del usuario con el ID del archivo subido
        const response: any = await request(
          FULL_STRAPI_GRAPHQL_URL,
          UPDATE_USER_AVATAR,
          {
            userId,
            avatarId: uploadResult[0].id
          },
          { Authorization: `Bearer ${jwt}` } // Cabeceras con el token
        );

        console.log('Respuesta de actualización de avatar:', response);

        // Comprobar la respuesta y actualizar la UI
        if (response?.updateUsersPermissionsUser?.avatar?.url) {
          // Actualizar la URL del avatar en la interfaz
          let newAvatarUrl = response.updateUsersPermissionsUser.avatar.url;
          
          // Asegurarnos de que la URL es completa
          if (!newAvatarUrl.startsWith('http')) {
            newAvatarUrl = `${strapiBaseUrl}${newAvatarUrl}`;
          }
          
          onAvatarUpdated(newAvatarUrl);
          setUploadSuccess(true);
        } else {
          // Si tenemos la respuesta pero no la URL del avatar, usar la URL del archivo subido
          const newAvatarUrl = uploadResult[0].url.startsWith('http') 
            ? uploadResult[0].url 
            : `${strapiBaseUrl}${uploadResult[0].url}`;
            
          onAvatarUpdated(newAvatarUrl);
          setUploadSuccess(true);
        }
      }
    } catch (error) {
      console.error('Error al actualizar el avatar:', error);
      setUploadError('Error al subir la imagen. Inténtalo de nuevo.');
    } finally {
      setUploading(false);
    }
  };

  return (
    <div className="mt-6">
      <label className="block text-sm font-medium text-gray-700">Avatar</label>
      <div className="mt-2 flex items-center">
        <div className="relative h-20 w-20 overflow-hidden rounded-full bg-gray-100">
          {avatarPreview ? (
            <Image 
              src={avatarPreview}
              alt="Avatar del usuario"
              fill
              className="object-cover"
            />
          ) : (
            <div className="h-full w-full flex items-center justify-center bg-gray-200 text-gray-400">
              <span>Sin avatar</span>
            </div>
          )}
        </div>
        <div className="ml-5">
          <label htmlFor="avatar-upload" className="cursor-pointer rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
            Cambiar
            <input
              id="avatar-upload"
              name="avatar"
              type="file"
              accept="image/*"
              className="sr-only"
              onChange={handleFileChange}
            />
          </label>
        </div>
      </div>
      
      {avatarFile && (
        <div className="mt-4">
          <button
            type="button"
            onClick={uploadAvatar}
            disabled={uploading}
            className="inline-flex justify-center rounded-md border border-transparent bg-blue-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50"
          >
            {uploading ? 'Subiendo...' : 'Guardar avatar'}
          </button>
        </div>
      )}

      {uploadError && (
        <p className="mt-2 text-sm text-red-600">{uploadError}</p>
      )}
      
      {uploadSuccess && (
        <p className="mt-2 text-sm text-green-600">¡Avatar actualizado correctamente!</p>
      )}
    </div>
  );
}
