// Stripe config
import Stripe from 'stripe';

// tomo la key del .env
const stripeSecretKey = process.env.STRIPE_SECRET_KEY || '';

// compruebo que existe la key
if (!process.env.STRIPE_SECRET_KEY) {
  console.warn('⚠️ No hay key de Stripe en el .env');
  console.warn('Los pagos no funcionarán bien');
  // uso string vacía por el tipado
}

export const stripe = new Stripe(stripeSecretKey, {
  apiVersion: '2023-10-16' as any, // esta version me funciona
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
