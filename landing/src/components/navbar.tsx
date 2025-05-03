//src/components/navbar.tsx

"use client";

import { Heart } from "lucide-react";
import { CartDrawer } from "./cart/cart-drawer";
import { useRouter } from "next/navigation";
import MenuList from "./menu-list";
import ItemsMenuMobile from "./items-menu-mobile";
import UserMenu from "./user-menu";



const Navbar = () => {
  const router = useRouter();

  return (
    <div className="flex item-center justify-between p-4 mx-auto cursor-pointer sm:max-w-4xl md:max-w-6xl">
      <h1 className="text-3xl" onClick={() => router.push("/")}>
        World
        <span className="font-bold">3D</span>
      </h1>
      <div className="items-center justify-between hidden sm:flex">
        <MenuList />
      </div>
      <div className="flex sm:hidden">
        <ItemsMenuMobile />
      </div>
      <div className="flex item-center justify-between gap-2 sm:gap-7">
        <CartDrawer />

        <Heart
          strokeWidth="1"
          className="cursor-pointer"
          onClick={() => router.push("/loved-products")}
        />
        <UserMenu router={router} />
      </div>
    </div>
  );
};

export default Navbar;
