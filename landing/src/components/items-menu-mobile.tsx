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
        <PopoverContent>
          <Link href="/category/impresoraFilamento" className="block">Impresoras filamento</Link>
          <Link href="/category/impresoraResina" className="block">Impresoras resina</Link>
          <Link href="/category/electronica" className="block">Electronica</Link>
          <Link href="/category/filamento" className="block">Filamentos</Link>
          <Link href="/category/resina" className="block">Resinas</Link>
        </PopoverContent>
      </Popover>
    </div>
  );
};

export default ItemsMenuMobile;
