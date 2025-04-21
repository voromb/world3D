import { NextResponse } from 'next/server';
import { fetchHeroImages } from '@/lib/api/fetchHeroImages';

export async function GET() {
  try {
    const images = await fetchHeroImages();
    return NextResponse.json(images);
  } catch (error) {
    console.error('Error in hero-images API route:', error);
    return NextResponse.json(
      { error: 'Failed to fetch hero images' },
      { status: 500 }
    );
  }
}