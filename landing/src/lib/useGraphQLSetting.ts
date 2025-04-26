// src/lib/useGraphQLSetting.ts
import { useState, useEffect } from 'react';

interface GraphQLSetting {
  enabled: boolean;
  useRealData: boolean;
}

/**
 * Hook personalizado para gestionar la configuración de GraphQL
 * @returns Objeto con la configuración actual de GraphQL y funciones para modificarla
 */
export function useGraphQLSetting(): {
  settings: GraphQLSetting;
  toggleEnabled: () => void;
  toggleUseRealData: () => void;
} {
  // Estado para almacenar la configuración
  const [settings, setSettings] = useState<GraphQLSetting>({
    enabled: true, // Por defecto, GraphQL está habilitado
    useRealData: true, // Por defecto, se usan datos reales
  });

  // Efecto para cargar la configuración guardada en localStorage (solo cliente)
  useEffect(() => {
    if (typeof window !== 'undefined') {
      try {
        const savedSettings = localStorage.getItem('graphql-settings');
        if (savedSettings) {
          setSettings(JSON.parse(savedSettings));
        }
      } catch (error) {
        console.error('Error al cargar la configuración de GraphQL:', error);
      }
    }
  }, []);

  // Función para guardar la configuración en localStorage
  const saveSettings = (newSettings: GraphQLSetting) => {
    if (typeof window !== 'undefined') {
      try {
        localStorage.setItem('graphql-settings', JSON.stringify(newSettings));
      } catch (error) {
        console.error('Error al guardar la configuración de GraphQL:', error);
      }
    }
  };

  // Función para activar/desactivar GraphQL
  const toggleEnabled = () => {
    const newSettings = {
      ...settings,
      enabled: !settings.enabled,
    };
    setSettings(newSettings);
    saveSettings(newSettings);
  };

  // Función para alternar entre datos reales y simulados
  const toggleUseRealData = () => {
    const newSettings = {
      ...settings,
      useRealData: !settings.useRealData,
    };
    setSettings(newSettings);
    saveSettings(newSettings);
  };

  return {
    settings,
    toggleEnabled,
    toggleUseRealData,
  };
}
