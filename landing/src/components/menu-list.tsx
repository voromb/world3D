"use client";

import * as React from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { cn } from "@/lib/utils";

import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger,
  navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu";

const MenuList = () => {
  const router = useRouter();

  return (
    <NavigationMenu>
      <NavigationMenuList>
        <NavigationMenuItem>
          <NavigationMenuTrigger
            className="cursor-pointer"
            onClick={() => router.push("/shop")}
          >
            Tienda
          </NavigationMenuTrigger>
          <NavigationMenuContent className="bg-white border shadow-lg rounded-md">
            <ul className="grid w-[400px] gap-3 p-4 md:w-[500px] md:grid-cols-2 lg:w-[600px]">
              {components.map((component) => (
                <ListItem
                  key={component.title}
                  title={component.title}
                  href={component.href}
                >
                  {component.description}
                </ListItem>
              ))}
            </ul>
          </NavigationMenuContent>
        </NavigationMenuItem>
        <NavigationMenuItem>
          <NavigationMenuLink asChild className={navigationMenuTriggerStyle()}>
            <Link href="/offers">Ofertas</Link>
          </NavigationMenuLink>
        </NavigationMenuItem>
        <NavigationMenuItem>
          <NavigationMenuLink asChild className={navigationMenuTriggerStyle()}>
            <Link href="/about">Sobre Nosotros</Link>
          </NavigationMenuLink>
        </NavigationMenuItem>
        <NavigationMenuItem>
          <NavigationMenuLink asChild className={navigationMenuTriggerStyle()}>
            <Link href="/contact">Contacto</Link>
          </NavigationMenuLink>
        </NavigationMenuItem>
      </NavigationMenuList>
    </NavigationMenu>
  );
};

export default MenuList;

const components: { title: string; href: string; description: string }[] = [
  {
    title: "Impresora de Filamento",
    href: "/shop?category=impresora-filamento",
    description:
      "Aquí encontrarás todas las impresoras 3D que utilizan tecnología FDM",
  },
  {
    title: "Impresora de Resina",
    href: "/shop?category=impresora-resina",
    description:
      "Explora nuestra selección de impresoras 3D de resina (SLA/DLP)",
  },
  {
    title: "Filamento",
    href: "/shop?category=filamento",
    description:
      "Gran variedad de filamentos PLA, ABS, PETG y materiales especiales",
  },
  {
    title: "Resina",
    href: "/shop?category=resina",
    description: "Resinas de alta calidad para impresiones detalladas y precisas",
  },
  {
    title: "Perfilería",
    href: "/shop?category=perfileria",
    description:
      "Perfiles de aluminio, escuadras y conectores para tus estructuras",
  },
  {
    title: "Electrónica",
    href: "/shop?category=electronica",
    description:
      "Componentes electrónicos, placas y accesorios para tus proyectos",
  },
];

const ListItem = React.forwardRef<
  HTMLAnchorElement,
  React.ComponentPropsWithoutRef<"a"> & { href: string }
>(({ className, title, children, href, ...props }, ref) => {
  return (
    <li>
      <NavigationMenuLink asChild>
        <Link
          href={href}
          ref={ref}
          className={cn(
            "block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground",
            className
          )}
          {...props}
        >
          <div className="text-sm font-medium leading-none">{title}</div>
          <p className="line-clamp-2 text-sm leading-snug text-muted-foreground">
            {children}
          </p>
        </Link>
      </NavigationMenuLink>
    </li>
  );
});

ListItem.displayName = "ListItem";

export { ListItem };
