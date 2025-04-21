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
          <NavigationMenuTrigger>Home</NavigationMenuTrigger>
          <NavigationMenuContent>
            <ul className="grid gap-3 p-4 md:w-[400px] lg:w-[500px] lg:grid-cols-[.75fr_1fr]">
              <ListItem href="/shop" title="Tienda">
                Accede a la tienda
              </ListItem>
              <ListItem href="/offers" title="Ofertas">
                Sección dedicada a las ofertas y promociones especiales
              </ListItem>
              <ListItem href="/accessories" title="Accesorios">
                Sección dedicada a los accesorios como herramientas, filamento y
                resinas
              </ListItem>
            </ul>
          </NavigationMenuContent>
        </NavigationMenuItem>
        <NavigationMenuItem>
          <NavigationMenuTrigger
            className="cursor-pointer"
            onClick={() => router.push("/shop")}
          >
            Tienda
          </NavigationMenuTrigger>
          <NavigationMenuContent>
            <ul className="grid w-[400px] gap-3 p-4 md:w-[500px] md:grid-cols-2 lg:w-[600px] ">
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
    href: "/category/impresoraFilamento",
    description:
      "Aqui encontrarás todas las impresoras de filamentos que exiten en el mercado",
  },
  {
    title: "Impresora de Resina",
    href: "/category/impresoraResina",
    description:
      "Aqui encontrarás todas las impresoras de resina que exiten en el mercado",
  },
  {
    title: "Filamento",
    href: "/category/filamento",
    description:
      "Aqui encontrarás todas las filamentos que exiten en el mercado",
  },
  {
    title: "Resina",
    href: "/category/resina",
    description: "Aqui encontrarás todas las resinas que exiten en el mercado",
  },
  {
    title: "Perfilería",
    href: "/category/perfileria",
    description:
      "Aqui encontrarás todas las perfilerías que exiten en el mercado",
  },
  {
    title: "Electronica",
    href: "/category/electronica",
    description:
      "Aqui encontrarás todas las electronica que exiten en el mercado",
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
