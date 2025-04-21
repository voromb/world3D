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
              href="/shop?category=impresoras-filamento" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow"
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
              href="/shop?category=impresoras-resina" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow"
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
            
            {/* Accesorios */}
            <a 
              href="/shop?category=accesorios" 
              className="bg-white rounded-lg shadow-md p-6 flex flex-col items-center hover:shadow-lg transition-shadow"
            >
              <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-green-600">
                  <path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-2">Accesorios</h3>
              <p className="text-gray-600 text-center">
                Encuentra accesorios, repuestos y mejoras para tu impresora 3D.
              </p>
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
                <div className="relative mx-auto h-64 w-full max-w-md">
                  {/* Aquí podrías poner una imagen ilustrativa */}
                  <div className="w-full h-full bg-blue-500 rounded-lg opacity-50"></div>
                  <div className="absolute inset-0 flex items-center justify-center">
                    <span className="text-white text-xl font-bold">World3D</span>
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