import type { Metadata } from "next";
import { Urbanist } from "next/font/google";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/navbar";
import Footer from "@/components/footer";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { Providers } from "@/components/providers"; // Importamos el Provider de Apollo
import 'leaflet/dist/leaflet.css';
import { Toaster } from "react-hot-toast";
import { CartInitializerWrapper } from "@/components/cart/client-components";

const urbanist = Urbanist({
  subsets: ["latin"],
  variable: "--font-urbanist",
});

export const metadata: Metadata = {
  title: "",
  description: "Welcome to world3d by Voro",
};

// El inicializador del carrito ahora está en un componente cliente

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <body className={`${urbanist.className}`}>
        <Providers>
          {/* Envolvemos todo el contenido con el Provider */}
          <CartInitializerWrapper />
          <Navbar />
          {children}
          <Footer />
          <Toaster position="top-center" />
        </Providers>
      </body>
    </html>
  );
}
