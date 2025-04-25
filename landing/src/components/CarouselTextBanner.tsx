"use client";

import React, { useEffect, useState } from "react";
import Link from "next/link";
import { HeroImageType, StrapiBlock } from "@/types";
import ProductSearch from "./ProductSearch";

// Función auxiliar para procesar el texto
const processTextGeneral = (
  blocks: StrapiBlock[] | null
): { title: string; subtitle?: string } => {
  const defaultText = {
    title: "Encuentra tu impresora 3D ideal",
    subtitle: "Explora nuestra selección de impresoras 3D de segunda mano",
  };
  if (!blocks || !Array.isArray(blocks) || blocks.length === 0) {
    return defaultText;
  }
  const firstParagraphText = blocks[0]?.children?.[0]?.text;
  return {
    title: firstParagraphText || defaultText.title,
    subtitle: defaultText.subtitle,
  };
};

const CarouselTextBanner: React.FC = () => {
  // Estados
  const [loading, setLoading] = useState(true);
  const [heroImages, setHeroImages] = useState<HeroImageType[]>([]);
  const [activeIndex, setActiveIndex] = useState(0);
  const [categories, setCategories] = useState<any[]>([]);
  const [cities, setCities] = useState<string[]>([]);

  // Cargar datos de la API
  useEffect(() => {
    const fetchData = async () => {
      try {
        const apiToken = process.env.NEXT_PUBLIC_STRAPI_API_TOKEN;
        const headers: HeadersInit = {};
        if (apiToken) {
          headers["Authorization"] = `Bearer ${apiToken}`;
        }

        // Fetch imágenes
        const imagesUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/image-generals?populate=nameGeneralImage`;
        const imagesResponse = await fetch(imagesUrl, { headers });
        const imagesData = await imagesResponse.json();

        if (imagesData && Array.isArray(imagesData.data)) {
          const formattedImages: HeroImageType[] = imagesData.data
            .map((item: any): HeroImageType | null => {
              const imageArray = item.nameGeneralImage;
              if (!Array.isArray(imageArray) || imageArray.length === 0)
                return null;
              const imageField = imageArray[0];
              if (
                !imageField ||
                typeof imageField !== "object" ||
                !imageField.url
              )
                return null;

              const finalImageUrl = `${process.env.NEXT_PUBLIC_BACKEND_URL}${imageField.url}`;
              const processedText = processTextGeneral(
                item.textGeneral as StrapiBlock[] | null
              );

              return {
                id: item.id,
                documentId: item.documentId,
                imageGeneralName: item.imageGeneralName,
                slug: item.slug,
                text_general: processedText,
                links: item.links,
                url: finalImageUrl,
              };
            })
            .filter(
              (img: HeroImageType | null): img is HeroImageType => img !== null
            );

          setHeroImages(formattedImages);
        }

        // Fetch categorías y ciudades
        const [categoriesResponse, productsResponse] = await Promise.all([
          fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/categories`, {
            headers,
          }),
          fetch(
            `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/products?fields=cityName`,
            { headers }
          ),
        ]);

        if (categoriesResponse.ok) {
          const categoriesData = await categoriesResponse.json();
          setCategories(categoriesData.data || []);
        }

        if (productsResponse.ok) {
          const productsData = await productsResponse.json();
          if (productsData?.data) {
            // Primero filtramos para obtener solo strings válidos
            const cityValues: string[] = productsData.data
              .map((p: any) => p.cityName)
              .filter(
                (city: any): city is string =>
                  typeof city === "string" && city.trim() !== ""
              );

            // Convertimos a Set y luego de nuevo a array para obtener valores únicos
            const uniqueCitiesSet = new Set(cityValues);
            const uniqueCities: string[] = Array.from(uniqueCitiesSet).sort(); // Aserción de tipo explícita

            setCities(uniqueCities);
          }
        }
      } catch (error) {
        console.error("Error loading data:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  // Cambio de imagen automático
  useEffect(() => {
    if (heroImages.length <= 1) return;

    const interval = setInterval(() => {
      setActiveIndex((prev) => (prev + 1) % heroImages.length);
    }, 5000);

    return () => clearInterval(interval);
  }, [heroImages.length]);

  // Cambio de imagen manual
  const goToSlide = (index: number) => {
    setActiveIndex(index);
  };

  const goToNext = () => {
    if (heroImages.length <= 1) return;
    setActiveIndex((prev) => (prev + 1) % heroImages.length);
  };

  const goToPrev = () => {
    if (heroImages.length <= 1) return;
    setActiveIndex(
      (prev) => (prev - 1 + heroImages.length) % heroImages.length
    );
  };

  // Estados de carga
  if (loading) {
    return (
      <div
        style={{
          position: "relative",
          width: "100%",
          height: "800px",
          backgroundColor: "#f3f4f6",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <span style={{ color: "#6b7280" }}>Cargando...</span>
      </div>
    );
  }

  if (heroImages.length === 0) {
    return (
      <div
        style={{
          position: "relative",
          width: "100%",
          height: "800px",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <div style={{ textAlign: "center" }}>
          <h2
            style={{
              fontSize: "24px",
              fontWeight: "bold",
              marginBottom: "16px",
            }}
          >
            World 3D
          </h2>
          <p style={{ marginBottom: "24px" }}>No hay imágenes disponibles</p>
          <ProductSearch categories={categories} cities={cities} />
        </div>
      </div>
    );
  }

  const currentImage = heroImages[activeIndex];

  return (
    <div style={{ position: "relative" }}>
      {/* Banner con imagen actual */}
      <div
        style={{
          position: "relative",
          width: "100%",
          height: "800px",
          overflow: "hidden",
        }}
      >
        <img
          src={currentImage.url}
          alt={currentImage.imageGeneralName || "Banner"}
          style={{
            position: "absolute",
            width: "100%",
            height: "100%",
            objectFit: "cover",
          }}
        />

        {/* Overlay */}
        <div
          style={{
            position: "absolute",
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            backgroundColor: "rgba(0,0,0,0.4)",
          }}
        ></div>

        {/* Contenido */}
        <div
          style={{
            position: "absolute",
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            display: "flex",
            alignItems: "center",
          }}
        >
          <div
            style={{ maxWidth: "1200px", margin: "0 auto", padding: "0 24px" }}
          >
            <div style={{ maxWidth: "600px" }}>
              <h2
                style={{
                  fontSize: "42px",
                  fontWeight: "bold",
                  color: "white",
                  marginBottom: "24px",
                }}
              >
                {currentImage.text_general.title}
              </h2>

              {currentImage.text_general.subtitle && (
                <p
                  style={{
                    fontSize: "24px",
                    color: "white",
                    marginBottom: "48px",
                  }}
                >
                  {currentImage.text_general.subtitle}
                </p>
              )}

              <div>
                {currentImage.links && currentImage.links.length > 0 ? (
                  <Link
                    href={currentImage.links[0].url || "/shop"}
                    style={{
                      backgroundColor: "#2563eb",
                      color: "white",
                      padding: "12px 32px",
                      borderRadius: "8px",
                      textDecoration: "none",
                      display: "inline-block",
                      fontWeight: "500",
                      fontSize: "18px",
                    }}
                  >
                    {currentImage.links[0].text || "Explorar productos"}
                  </Link>
                ) : (
                  <Link
                    href="/shop"
                    style={{
                      backgroundColor: "#2563eb",
                      color: "white",
                      padding: "12px 32px",
                      borderRadius: "8px",
                      textDecoration: "none",
                      display: "inline-block",
                      fontWeight: "500",
                      fontSize: "18px",
                    }}
                  >
                    Explorar productos
                  </Link>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Controles de navegación */}
        {heroImages.length > 1 && (
          <>
            <button
              onClick={goToPrev}
              style={{
                position: "absolute",
                top: "50%",
                left: "24px",
                transform: "translateY(-50%)",
                backgroundColor: "rgba(255,255,255,0.3)",
                color: "white",
                border: "none",
                borderRadius: "50%",
                width: "48px",
                height: "48px",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                cursor: "pointer",
                fontSize: "24px",
              }}
              aria-label="Anterior"
            >
              &lt;
            </button>

            <button
              onClick={goToNext}
              style={{
                position: "absolute",
                top: "50%",
                right: "24px",
                transform: "translateY(-50%)",
                backgroundColor: "rgba(255,255,255,0.3)",
                color: "white",
                border: "none",
                borderRadius: "50%",
                width: "48px",
                height: "48px",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                cursor: "pointer",
                fontSize: "24px",
              }}
              aria-label="Siguiente"
            >
              &gt;
            </button>

            {/* Indicadores */}
            <div
              style={{
                position: "absolute",
                bottom: "32px",
                left: "50%",
                transform: "translateX(-50%)",
                display: "flex",
                gap: "12px",
              }}
            >
              {heroImages.map((_, idx) => (
                <button
                  key={idx}
                  onClick={() => goToSlide(idx)}
                  style={{
                    width: "16px",
                    height: "16px",
                    borderRadius: "50%",
                    backgroundColor:
                      idx === activeIndex ? "white" : "rgba(255,255,255,0.5)",
                    border: "none",
                    padding: 0,
                    cursor: "pointer",
                  }}
                  aria-label={`Ir a imagen ${idx + 1}`}
                />
              ))}
            </div>
          </>
        )}
      </div>

      {/* Buscador */}
      <div
        style={{
          maxWidth: "1200px",
          margin: "0 auto",
          padding: "0 16px",
          position: "relative",
          marginTop: "-60px",
          zIndex: 10,
        }}
      >
        <ProductSearch categories={categories} cities={cities} />
      </div>
    </div>
  );
};

export default CarouselTextBanner;
