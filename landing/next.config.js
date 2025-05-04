/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    dangerouslyAllowSVG: true,
    contentSecurityPolicy: "default-src 'self'; script-src 'none'; sandbox;",
    domains: [
      'secure.gravatar.com',
      'gravatar.com', 
      'www.gravatar.com', 
      'localhost', 
      '127.0.0.1',
      'picsum.photos', // Para imágenes de relleno
      'loremflickr.com' // Para imágenes de relleno
    ],
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'secure.gravatar.com',
        pathname: '**',
      },
      {
        protocol: 'https',
        hostname: 'www.gravatar.com',
        pathname: '**',
      },
      {
        protocol: 'https',
        hostname: 'gravatar.com',
        pathname: '**',
      },
      {
        protocol: 'http',
        hostname: 'localhost',
        port: '1337',
        pathname: '/**',
      },
      {
        protocol: 'http',
        hostname: '127.0.0.1',
        port: '1337',
        pathname: '/**',
      },
      // Para imágenes de prueba
      {
        protocol: 'https',
        hostname: 'picsum.photos',
        pathname: '/**',
      },
      {
        protocol: 'https',
        hostname: 'loremflickr.com',
        pathname: '/**',
      },
    ],
  },
};

module.exports = nextConfig;
