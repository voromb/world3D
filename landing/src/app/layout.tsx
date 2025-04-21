import type { Metadata } from "next";
import { Urbanist } from "next/font/google";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/navbar";
import Footer from "@/components/footer";
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';


const urbanist = Urbanist({
  subsets: ["latin"],
  variable: "--font-urbanist",
});

export const metadata: Metadata = {
  title: "",
  description: "Welcome to world3d by Voro",
};


export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <body className={`${urbanist.className}`} >
        <Navbar/>
        {children}
        <Footer/>
      </body>
    </html>
  );
}
