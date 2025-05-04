import NextAuth from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import { request } from "graphql-request";

// URL del servidor GraphQL de Strapi (usamos la URL completa)
const STRAPI_GRAPHQL_URL = process.env.NEXT_PUBLIC_STRAPI_GRAPHQL_URL || "http://localhost:1337/graphql";

// Consulta GraphQL para login - formato probado con curl
const LOGIN_MUTATION = `
  mutation($identifier: String!, $password: String!) {
    login(input: { identifier: $identifier, password: $password }) {
      jwt
      user {
        id
        username
        email
      }
    }
  }
`;



// Esta consulta ME_QUERY no se usa en NextAuth, pero la dejamos por si se necesita en el futuro
// Strapi v5 tiene diferentes endpoints para esto
const ME_QUERY = `
  query {
    me {
      id
      username
      email
    }
  }
`;

const handler = NextAuth({
  secret: process.env.NEXTAUTH_SECRET || "secret-key-for-development-only",
  providers: [
    CredentialsProvider({
      name: "Credentials",
      credentials: {
        identifier: { label: "Email o nombre de usuario", type: "text" },
        password: { label: "Contraseña", type: "password" },
      },
      async authorize(credentials) {
        try {
          if (!credentials?.identifier || !credentials?.password) {
            return null;
          }

          // Realizar petición GraphQL para autenticar
          // Usar el formato que hemos probado con curl
          console.log('Intentando iniciar sesión con:', credentials.identifier);

          const response: any = await request(
            STRAPI_GRAPHQL_URL,
            LOGIN_MUTATION,
            {
              identifier: credentials.identifier,
              password: credentials.password,
            }
          );

          console.log('Respuesta del login:', JSON.stringify(response, null, 2));

          // Verificar respuesta y devolver usuario
          if (response?.login?.jwt && response?.login?.user) {
            const { jwt, user } = response.login;
            
            // En Strapi v5, la información de blocked/confirmed podría no estar disponible en este punto
            // Si realmente se necesita, se podría hacer una consulta adicional

            // Añadir el token JWT al objeto de usuario para usarlo en las cabeceras
            return {
              id: user.id,
              name: user.username,
              email: user.email,
              jwt: jwt, // Guardamos el JWT para usarlo en peticiones autenticadas
            };
          }
          return null;
        } catch (error) {
          console.error("Error durante la autenticación:", error);
          return null;
        }
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      // Cuando el usuario inicia sesión
      if (user) {
        token.id = user.id;
        token.role = user.role;
        token.jwt = user.jwt; // Guardamos el JWT en el token
      }
      return token;
    },
    async session({ session, token }) {
      // Añadimos información extra a la sesión
      if (token && session.user) {
        session.user.id = token.id as string;
        session.user.role = token.role as string;
        // Guardamos el JWT tanto en sesion.jwt (por compatibilidad) como en session.user.jwt (para acceso en componentes)
        session.jwt = token.jwt as string;
        session.user.jwt = token.jwt as string;
      }
      return session;
    },
  },
  session: {
    strategy: "jwt",
    maxAge: 30 * 24 * 60 * 60, // 30 días
  },
  pages: {
    signIn: "/auth/login",
    signOut: "/auth/logout",
    error: "/auth/error",
  },
});

export { handler as GET, handler as POST };
