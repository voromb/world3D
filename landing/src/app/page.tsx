import { checkStrapiConnection } from '@/lib/api';

export default async function Home() {
  const connectionStatus = await checkStrapiConnection();
  
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="z-10 max-w-5xl w-full flex flex-col items-center">
        <h1 className="text-4xl font-bold mb-8">World3D</h1>
        
        <div className="w-full max-w-md p-6 border rounded-lg shadow-lg">
          <h2 className="text-2xl font-semibold mb-4">Estado de conexión</h2>
          
          <div className={`p-4 rounded-md mb-4 ${connectionStatus.connected ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
            <div className="flex items-center">
              <div className={`w-4 h-4 rounded-full mr-2 ${connectionStatus.connected ? 'bg-green-500' : 'bg-red-500'}`}></div>
              <span className="font-medium">
                {connectionStatus.connected ? 'Conectado' : 'Desconectado'}
              </span>
            </div>
            <p className="mt-2 text-sm">{connectionStatus.message}</p>
          </div>
          
          <div className="mt-6">
            <h3 className="text-lg font-medium mb-2">Información del servidor:</h3>
            <ul className="list-disc pl-5 space-y-1">
              <li>URL: {process.env.NEXT_PUBLIC_API_URL || 'http://localhost:1337'}</li>
              <li>Estado: {connectionStatus.connected ? 'Activo' : 'Inactivo'}</li>
            </ul>
          </div>
        </div>
        
        <div className="mt-8 text-center">
          <p className="text-sm text-gray-500">
            Esta página verifica la conexión con el backend de Strapi.
            {!connectionStatus.connected && (
              <span className="block mt-2 text-red-500">
                Asegúrate de que Strapi esté ejecutándose en {process.env.NEXT_PUBLIC_API_URL || 'http://localhost:1337'}
              </span>
            )}
          </p>
        </div>
      </div>
    </main>
  );
}