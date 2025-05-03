// Configuración de Stripe para el servidor
import Stripe from 'stripe';

// Asegúrate de que esto esté en un archivo .env.local
const stripeSecretKey = process.env.STRIPE_SECRET_KEY || 
                        'sk_test_4eC39HqLyjWDarjtT1zdp7dc'; // Usa tu propia clave de prueba

export const stripe = new Stripe(stripeSecretKey, {
  apiVersion: '2023-10-16', // Usar la versión más reciente disponible
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
