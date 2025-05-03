// Cliente Stripe para el frontend
import { loadStripe } from '@stripe/stripe-js';

// Asegúrate de que esto esté en un archivo .env.local
const stripePublishableKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY || 
                          'pk_test_TYooMQauvdEDq54NiTphI7jx'; // Usa tu propia clave de prueba

export const getStripe = () => {
  let stripePromise = null;
  
  if (!stripePromise) {
    stripePromise = loadStripe(stripePublishableKey);
  }
  
  return stripePromise;
};
