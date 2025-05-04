import { NextAuthOptions } from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';

// URL base para la API
const API_URL = process.env.NEXT_PUBLIC_STRAPI_API_URL || 'http://localhost:1337';

export const authOptions: NextAuthOptions = {
  providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" }
      },
      async authorize(credentials) {
        try {
          // Llamada a la API de autenticación de Strapi
          const res = await fetch(`${API_URL}/api/auth/local`, {
            method: 'POST',
            body: JSON.stringify({
              identifier: credentials?.email,
              password: credentials?.password,
            }),
            headers: { 'Content-Type': 'application/json' }
          });
          
          const data = await res.json();
          
          // Si tenemos un token JWT, consideramos la autenticación exitosa
          if (data.jwt) {
            // Obtener información del usuario
            return {
              id: data.user.id.toString(),
              name: data.user.username,
              email: data.user.email,
              jwt: data.jwt
            };
          }
          
          // Si no hay JWT, la autenticación falló
          return null;
        } catch (error) {
          console.error('Error de autenticación:', error);
          return null;
        }
      }
    })
  ],
  callbacks: {
    // Incluir información adicional en la sesión
    async session({ session, token }: { session: any, token: any }) {
      session.user = token.user;
      session.jwt = token.jwt;
      return session;
    },
    // Guardar información adicional en el token
    async jwt({ token, user }: { token: any, user: any }) {
      if (user) {
        token.user = {
          id: user.id,
          name: user.name,
          email: user.email,
        };
        token.jwt = user.jwt;
      }
      return token;
    }
  },
  pages: {
    signIn: '/auth/login',
    error: '/auth/error',
  },
  session: {
    strategy: 'jwt',
    maxAge: 30 * 24 * 60 * 60, // 30 días
  },
  secret: process.env.NEXTAUTH_SECRET || 'secreto-fuerte-para-nextauth-debe-ser-reemplazado-en-produccion',
};

export default authOptions;
