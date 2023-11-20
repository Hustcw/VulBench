__int64 menu_and_read_choice()
{
  puts("1. new");
  puts("2. delete");
  _printf_chk(1LL, "Your choice:");
  return read_num();
}