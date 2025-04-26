//src/app/lib/useGraphQLSetting.ts

'use client';

import { useState, useEffect } from 'react';

// Clave para almacenar la preferencia en localStorage
const GRAPHQL_PREFERENCE_KEY = 'use_graphql_api';

export function useGraphQLSetting(): [boolean, (value: boolean) => void] {
  // Estado local para la preferencia de usar GraphQL
  const [useGraphQL, setUseGraphQL] = useState<boolean>(false);

  // Cargar la preferencia de localStorage al inicializar
  useEffect(() => {
    const savedPreference = localStorage.getItem(GRAPHQL_PREFERENCE_KEY);
    if (savedPreference !== null) {
      setUseGraphQL(savedPreference === 'true');
    }
  }, []);

  // Función para cambiar la preferencia
  const toggleGraphQL = (value: boolean) => {
    setUseGraphQL(value);
    localStorage.setItem(GRAPHQL_PREFERENCE_KEY, value.toString());
  };

  return [useGraphQL, toggleGraphQL];
}
