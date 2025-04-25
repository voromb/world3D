// Esto amplía los tipos de react-leaflet sin intentar modificar los de leaflet
declare module 'react-leaflet' {
  import type { LatLngExpression, Icon, DivIcon } from 'leaflet';
  import type { FC, ReactNode } from 'react';
  
  // Interfaces para los props
  export interface MapContainerProps {
    center: LatLngExpression;
    zoom: number;
    scrollWheelZoom?: boolean;
    style?: React.CSSProperties;
    children?: ReactNode;
    [key: string]: any;
  }

  export interface TileLayerProps {
    attribution: string;
    url: string;
    [key: string]: any;
  }

  export interface MarkerProps {
    position: LatLngExpression;
    icon?: Icon | DivIcon;
    children?: ReactNode;
    [key: string]: any;
  }

  export interface PopupProps {
    children?: ReactNode;
    [key: string]: any;
  }

  // Exportaciones de componentes
  export const MapContainer: FC<MapContainerProps>;
  export const TileLayer: FC<TileLayerProps>;
  export const Marker: FC<MarkerProps>;
  export const Popup: FC<PopupProps>;
}