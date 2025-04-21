import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* otras configuraciones que puedas tener aquí */

  images: {
    remotePatterns: [
      {
        protocol: 'http', // Usa 'https' si tu Strapi corre en https
        hostname: 'localhost',
        port: '1337', // El puerto de Strapi
        pathname: '/uploads/**', // Permite cualquier imagen dentro de /uploads
      },

    ],
  },

}; 

export default nextConfig;