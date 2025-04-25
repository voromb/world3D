//src/components/BrandsCarousel.tsx

"use client";

import React, { useEffect, useState } from "react";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { Card } from "./ui/card";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "./ui/carousel";

type Brand = {
  id: number;
  brandName: string;
  slug: string;
  mainimage?: {
    url: string;
    formats?: {
      thumbnail?: {
        url: string;
      };
    };
  };
};

const BrandsCarousel: React.FC = () => {
  const router = useRouter();
  const [brands, setBrands] = useState<Brand[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchBrands = async () => {
      try {
        const url = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/brands?populate=*`;
        console.log("Obteniendo marcas desde:", url);

        const response = await fetch(url);
        const data = await response.json();
        console.log("Respuesta de marcas:", data);

        if (data && data.data) {
          console.log(
            "Estructura completa de marcas recibida:",
            JSON.stringify(data).substring(0, 500) + "..."
          );

          const parsedBrands: Brand[] = data.data.map((brand: any) => {
            // Determinar la estructura correcta basada en la respuesta de la API
            const brandData = brand.attributes || brand;
            const slug = brandData.slug || "";

            console.log(
              `Marca: ${brandData.brandName || "Sin nombre"}, Slug: ${slug}`
            );

            return {
              id: brand.id,
              brandName: brandData.brandName || "Sin nombre",
              slug: slug,
              mainimage: brandData.mainimage || undefined,
            };
          });

          console.log("Marcas procesadas:", parsedBrands);
          setBrands(parsedBrands);
        }
      } catch (err) {
        console.error("Error al cargar marcas:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchBrands();
  }, []);

  const handleBrandClick = (brand: Brand) => {
    console.log(
      `Redirigiendo a marca: ${brand.brandName}, slug: ${brand.slug}`
    );
    // Aseguramos que el slug no esté vacío
    if (brand.slug) {
      router.push(`/shop?brand=${encodeURIComponent(brand.slug)}`);
    } else {
      console.error("Error: La marca no tiene slug", brand);
    }
  };

  return (
    <div className="max-w-6xl py-4 mx-auto sm:py-16 sm:px-24">
      <div className="flex justify-between items-center mb-8 px-6">
        <h3 className="text-3xl font-bold">Marcas Destacadas</h3>
      </div>

      <div className="relative px-14">
        <Carousel className="w-full">
          <CarouselContent className="-ml-2 md:ml-4">
            {loading ? (
              Array(3)
                .fill(0)
                .map((_, index) => (
                  <CarouselItem
                    key={index}
                    className="md:basis-1/2 lg:basis-1/3"
                  >
                    <div className="p-1">
                      <Card className="h-48 bg-gray-200 animate-pulse" />
                    </div>
                  </CarouselItem>
                ))
            ) : brands.length > 0 ? (
              brands.map((brand: Brand) => (
                <CarouselItem
                  key={brand.id}
                  className="md:basis-1/2 lg:basis-1/4"
                >
                  <div className="p-4 text-center">
                    <Card
                      className="py-4 px-2 flex justify-center items-center h-40 cursor-pointer transition-transform hover:scale-105"
                      onClick={() => handleBrandClick(brand)}
                    >
                      {brand.mainimage?.formats?.thumbnail?.url ||
                      brand.mainimage?.url ? (
                        <Image
                          src={`${process.env.NEXT_PUBLIC_BACKEND_URL}${
                            brand.mainimage.formats?.thumbnail?.url ||
                            brand.mainimage.url
                          }`}
                          alt={brand.brandName}
                          width={120}
                          height={120}
                          style={{ width: "auto" }}
                          className="object-contain"
                        />
                      ) : (
                        <span className="text-gray-400">Sin imagen</span>
                      )}
                    </Card>
                    <p
                      className="mt-2 text-sm font-medium hover:text-blue-600 cursor-pointer"
                      onClick={() => handleBrandClick(brand)}
                    >
                      {brand.brandName}
                    </p>
                  </div>
                </CarouselItem>
              ))
            ) : (
              <CarouselItem className="basis-full">
                <div className="p-4 text-center">
                  No hay marcas para mostrar
                </div>
              </CarouselItem>
            )}
          </CarouselContent>

          {brands.length > 0 && (
            <>
              <CarouselPrevious className="absolute left-2 -translate-x-full" />
              <CarouselNext className="absolute right-2 translate-x-full" />
            </>
          )}
        </Carousel>
      </div>
    </div>
  );
};

export default BrandsCarousel;
