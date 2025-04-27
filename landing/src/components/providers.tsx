//src/components/providers.tsx
"use client";

import { ApolloProvider } from "@apollo/client";
import { createApolloClient } from "@/lib/graphql/client";
import { SessionProvider } from "next-auth/react";
import { ReactNode } from "react";

// Crear el cliente Apollo
const client = createApolloClient();

export function Providers({ children }: { children: ReactNode }) {
  return (
    <SessionProvider>
      <ApolloProvider client={client}>{children}</ApolloProvider>
    </SessionProvider>
  );
}