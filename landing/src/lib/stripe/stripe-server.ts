// Configuración de Stripe para el servidor
import Stripe from 'stripe';

// Verificar que la clave de API de Stripe está configurada en las variables de entorno
const stripeSecretKey = process.env.STRIPE_SECRET_KEY || '';

if (!process.env.STRIPE_SECRET_KEY) {
  console.warn('⚠️ La clave secreta de Stripe no está configurada en el archivo .env.local');
  console.warn('La funcionalidad de pagos estará deshabilitada o en modo de simulación');
  // Estamos usando una cadena vacía como valor por defecto para satisfacer el tipado,
  // pero el código debería manejar esto apropiadamente
}

export const stripe = new Stripe(stripeSecretKey, {
  apiVersion: '2023-10-16' as any, // Usar la versión más reciente disponible
});

// Función para calcular el precio en centavos (Stripe usa centavos)
export const formatAmountForStripe = (amount: number): number => {
  const numberFormat = new Intl.NumberFormat('es-ES', {
    style: 'currency',
    currency: 'EUR',
    currencyDisplay: 'symbol',
  });
  
  const parts = numberFormat.formatToParts(amount);
  let zeroDecimalCurrency = true;
  
  for (const part of parts) {
    if (part.type === 'decimal') {
      zeroDecimalCurrency = false;
    }
  }
  
  return zeroDecimalCurrency ? amount : Math.round(amount * 100);
};
