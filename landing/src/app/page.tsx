import BrandsCarousel from "@/components/BrandsCarousel";
import CarouselTextBanner from "@/components/CarouselTextBanner";
import FeaturedProducts from "@/components/FeaturedProducts";

export default function Home() {
  return (
    <main>
      <CarouselTextBanner />
      <BrandsCarousel />
      <FeaturedProducts />
      
      
      {/* Sección de categorías */}
      <section className="py-16 bg-gray-50">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-center">
            Explora por Categorías
          </h2>
          
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
            {/* Impresoras de Filamento */}
            <a 
              href="/shop?category=impresora-filamento" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow hover:bg-blue-50"
            >
              <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-blue-600">
                  <path d="M17 17H7a5 5 0 0 1 0-10h10a5 5 0 0 1 0 10Z"></path>
                  <path d="M12 4v16"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Impresoras de Filamento</h3>
              <p className="text-gray-600 text-center">
                Explora nuestra selección de impresoras 3D FDM de segunda mano.
              </p>
            </a>
            
            {/* Impresoras de Resina */}
            <a 
              href="/shop?category=impresora-resina" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow hover:bg-indigo-50"
            >
              <div className="w-16 h-16 bg-indigo-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-indigo-600">
                  <path d="M9 12h.01"></path>
                  <path d="M15 12h.01"></path>
                  <path d="M10 16c.5.3 1.2.5 2 .5s1.5-.2 2-.5"></path>
                  <path d="M19 6.3a9 9 0 0 1 1.8 3.9 2 2 0 0 1 0 3.6 9 9 0 0 1-17.6 0 2 2 0 0 1 0-3.6A9 9 0 0 1 12 3c2 0 3.5 1.1 3.5 2.5s-.9 2.5-2 2.5c-.8 0-1.5-.4-1.5-1"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Impresoras de Resina</h3>
              <p className="text-gray-600 text-center">
                Descubre impresoras 3D SLA/DLP/LCD para impresiones de alta precisión.
              </p>
            </a>
            
            {/* Filamentos */}
            <a 
              href="/shop?category=filamento" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow hover:bg-orange-50"
            >
              <div className="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-orange-600">
                  <path d="M12 3a9 9 0 0 0 9 9 9 9 0 0 0-9 9 9 9 0 0 0-9-9 9 9 0 0 0 9-9Z"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Filamentos</h3>
              <p className="text-gray-600 text-center">
                PLA, ABS, PETG y filamentos especiales para tus proyectos de impresión.
              </p>
            </a>
            
            {/* Resinas */}
            <a 
              href="/shop?category=resina" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow hover:bg-purple-50"
            >
              <div className="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-purple-600">
                  <path d="M8.5 14.5A2.5 2.5 0 0 0 11 12c0-1.38-.5-2-1-3s.5-1.5 1-2"></path>
                  <path d="M3 12h1m8-9v1M4.6 5.6l.7.7m12.1-.7-.7.7M17 12h1M5.6 17.6l.7.7"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Resinas</h3>
              <p className="text-gray-600 text-center">
                Resinas de alta calidad para impresiones detalladas y duraderas.
              </p>
            </a>
            
            {/* Electrónica */}
            <a 
              href="/shop?category=electronica" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow hover:bg-red-50"
            >
              <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-red-600">
                  <rect x="8" y="2" width="8" height="4" rx="1"></rect>
                  <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                  <path d="M12 14v4"></path>
                  <path d="M12 10v.01"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Electrónica</h3>
              <p className="text-gray-600 text-center">
                Componentes electrónicos, placas y accesorios para tus proyectos.
              </p>
            </a>
            
            {/* Perfilería */}
            <a 
              href="/shop?category=perfileria" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow hover:bg-green-50"
            >
              <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-green-600">
                  <path d="M3 3v18h18"></path>
                  <path d="M3 9h18"></path>
                  <path d="M15 3v18"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Perfilería</h3>
              <p className="text-gray-600 text-center">
                Perfiles de aluminio, uniones y piezas para estructuras y marcos.
              </p>
            </a>
          </div>
          
          {/* Botón para ver todas las categorías */}
          <div className="text-center mt-8">
            <a 
              href="/shop" 
              className="inline-block bg-blue-600 text-white px-6 py-3 rounded-full font-medium hover:bg-blue-700 transition-colors"
            >
              Ver todos los productos
            </a>
          </div>
        </div>
      </section>
      
      {/* Sección CTA */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="bg-blue-600 text-white rounded-2xl p-8 md:p-12">
            <div className="grid md:grid-cols-2 gap-8 items-center">
              <div>
                <h2 className="text-3xl font-bold mb-4">¿Por qué comprar en World3D?</h2>
                <ul className="space-y-4">
                  <li className="flex items-start">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2 text-blue-200 flex-shrink-0">
                      <path d="M20 6 9 17l-5-5"></path>
                    </svg>
                    <span>Amplio catálogo de impresoras 3D de filamento y resina</span>
                  </li>
                  <li className="flex items-start">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2 text-blue-200 flex-shrink-0">
                      <path d="M20 6 9 17l-5-5"></path>
                    </svg>
                    <span>Productos de calidad verificada</span>
                  </li>
                  <li className="flex items-start">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2 text-blue-200 flex-shrink-0">
                      <path d="M20 6 9 17l-5-5"></path>
                    </svg>
                    <span>Envíos seguros en toda España</span>
                  </li>
                  <li className="flex items-start">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2 text-blue-200 flex-shrink-0">
                      <path d="M20 6 9 17l-5-5"></path>
                    </svg>
                    <span>Soporte técnico para todas tus dudas</span>
                  </li>
                </ul>
                <div className="mt-8">
                  <a 
                    href="/shop" 
                    className="bg-white text-blue-600 hover:bg-blue-50 font-medium py-2 px-6 rounded-lg transition-colors inline-block"
                  >
                    Explorar productos
                  </a>
                </div>
              </div>
              <div className="hidden md:block text-center">
                <div className="relative mx-auto h-64 w-full max-w-md bg-blue-50 rounded-xl p-4 shadow-sm">
                  <div className="bg-white rounded-lg h-full w-full flex items-center justify-center overflow-hidden">
                    <img 
                      src="http://localhost:1337/uploads/prusa_ba34cae5ad.jpg"
                      alt="Impresora 3D Prusa"
                      className="object-contain max-h-56 p-2"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
  );
}