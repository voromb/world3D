/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['secure.gravatar.com', 'gravatar.com', 'www.gravatar.com', 'localhost', '127.0.0.1'],
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
    ],
  },
};

module.exports = nextConfig;
