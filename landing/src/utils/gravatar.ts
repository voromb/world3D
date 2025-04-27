import crypto from 'crypto';

// Función para conseguir el avatar de gravatar a partir de un email
// size: tamaño de la imagen
// defaultImage: qué tipo de imagen poner si no hay gravatar (puede ser mp, identicon, etc)
export function getGravatarUrl(email: string, size: number = 80, defaultImage: string = 'mp'): string {
  // Si no hay email, devolver un gravatar por defecto
  if (!email) {
    return `https://secure.gravatar.com/avatar/00000000000000000000000000000000?s=${size}&d=${defaultImage}`;
  }

  // Normalizar el email y crear un hash MD5
  const normalizedEmail = email.trim().toLowerCase();
  const hash = crypto.createHash('md5').update(normalizedEmail).digest('hex');
  
  // Construir la URL de Gravatar
  return `https://secure.gravatar.com/avatar/${hash}?s=${size}&d=${defaultImage}`;
}
