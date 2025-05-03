import { NextResponse } from 'next/server';
import { stripe, formatAmountForStripe } from '@/lib/stripe/stripe-server';

export async function POST(request: Request) {
  try {
    // Obtener los datos del carrito enviados desde el cliente
    const { items, customer } = await request.json();
    
    if (!items || items.length === 0) {
      return NextResponse.json(
        { error: 'Carrito vacío' },
        { status: 400 }
      );
    }

    // Crear líneas de pedido para Stripe
    const lineItems = items.map((item: any) => ({
      price_data: {
        currency: 'eur',
        product_data: {
          name: item.productName,
          images: item.imageUrl ? [item.imageUrl] : [],
          description: `ID del producto: ${item.documentId}`,
        },
        unit_amount: formatAmountForStripe(item.price),
      },
      quantity: item.quantity,
    }));

    // Crear una sesión de Checkout en Stripe
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: lineItems,
      mode: 'payment',
      success_url: `${process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'}/checkout/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'}/cart`,
      metadata: {
        userId: customer?.userId || 'guest',
      },
      shipping_address_collection: {
        allowed_countries: ['ES'],
      },
      shipping_options: [
        {
          shipping_rate_data: {
            type: 'fixed_amount',
            fixed_amount: {
              amount: 0, // Envío gratuito (0 céntimos)
              currency: 'eur',
            },
            display_name: 'Envío gratuito',
            delivery_estimate: {
              minimum: {
                unit: 'business_day',
                value: 3,
              },
              maximum: {
                unit: 'business_day',
                value: 5,
              },
            },
          },
        },
        {
          shipping_rate_data: {
            type: 'fixed_amount',
            fixed_amount: {
              amount: 500, // 5€ (500 céntimos)
              currency: 'eur',
            },
            display_name: 'Envío urgente',
            delivery_estimate: {
              minimum: {
                unit: 'business_day',
                value: 1,
              },
              maximum: {
                unit: 'business_day',
                value: 2,
              },
            },
          },
        },
      ],
    });

    return NextResponse.json({ sessionId: session.id, url: session.url });
  } catch (error: any) {
    console.error('Error al crear la sesión de Stripe:', error);
    return NextResponse.json(
      { error: error.message || 'Error al procesar el pago' },
      { status: 500 }
    );
  }
}
