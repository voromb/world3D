import { NextAuthOptions } from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';
import GoogleProvider from 'next-auth/providers/google';
import GitHubProvider from 'next-auth/providers/github';

// URL base para la API
const API_URL = process.env.NEXT_PUBLIC_STRAPI_API_URL || 'http://localhost:1337';

export const authOptions: NextAuthOptions = {
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID || '',
      clientSecret: process.env.GOOGLE_CLIENT_SECRET || '',
      authorization: {
        params: {
          prompt: "consent",
          access_type: "offline",
          response_type: "code"
        }
      }
    }),
    GitHubProvider({
      clientId: process.env.GITHUB_CLIENT_ID || '',
      clientSecret: process.env.GITHUB_CLIENT_SECRET || ''
    }),
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
    async jwt({ token, user, account }: { token: any, user: any, account: any }) {
      // Si es un inicio de sesión con credenciales, ya tenemos el JWT
      if (user && account?.provider === 'credentials') {
        token.user = {
          id: user.id,
          name: user.name,
          email: user.email,
        };
        token.jwt = user.jwt;
      }
      
      // Si es un inicio de sesión con proveedor social, necesitamos obtener un JWT de Strapi
      if (user && (account?.provider === 'google' || account?.provider === 'github')) {
        try {
          // Conectar con Strapi para obtener un JWT
          const response = await fetch(`${API_URL}/api/auth/${account.provider}/callback?access_token=${account.access_token}`);
          const data = await response.json();
          
          if (data.jwt) {
            token.jwt = data.jwt;
            token.user = {
              id: data.user.id.toString(),
              name: data.user.username || user.name,
              email: data.user.email || user.email,
            };
          }
        } catch (error) {
          console.error(`Error al autenticar con ${account.provider}:`, error);
        }
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
