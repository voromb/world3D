import Link from "next/link";
import { Popover, PopoverContent, PopoverTrigger } from "./ui/popover";
import { Menu } from "lucide-react";

const ItemsMenuMobile = () => {
  return (
    <div>
      <Popover>
        <PopoverTrigger>
          <Menu />
        </PopoverTrigger>
        <PopoverContent className="bg-white border rounded-md">
          <Link href="/shop?category=impresora-filamento" className="block py-2 hover:bg-gray-50 px-3">Impresoras filamento</Link>
          <Link href="/shop?category=impresora-resina" className="block py-2 hover:bg-gray-50 px-3">Impresoras resina</Link>
          <Link href="/shop?category=electronica" className="block py-2 hover:bg-gray-50 px-3">Electrónica</Link>
          <Link href="/shop?category=filamento" className="block py-2 hover:bg-gray-50 px-3">Filamentos</Link>
          <Link href="/shop?category=resina" className="block py-2 hover:bg-gray-50 px-3">Resinas</Link>
          <Link href="/shop?category=perfileria" className="block py-2 hover:bg-gray-50 px-3">Perfilería</Link>
          <Link href="/shop" className="block py-2 hover:bg-gray-50 px-3 text-blue-600 font-medium">Ver toda la tienda</Link>
        </PopoverContent>
      </Popover>
    </div>
  );
};

export default ItemsMenuMobile;
