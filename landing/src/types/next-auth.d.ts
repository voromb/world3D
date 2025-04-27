import NextAuth from "next-auth";

declare module "next-auth" {
  /**
   * Extiende la interfaz de usuario por defecto
   */
  interface User {
    id: string;
    name?: string | null;
    email?: string | null;
    image?: string | null;
    role?: string;
    jwt?: string;
  }

  /**
   * Extiende la interfaz de sesión por defecto
   */
  interface Session {
    user?: User;
    jwt?: string;
    expires: string;
  }
}

declare module "next-auth/jwt" {
  /**
   * Extiende la interfaz de token por defecto
   */
  interface JWT {
    id?: string;
    role?: string;
    jwt?: string;
  }
}
