int __cdecl printmenu()
{
  puts("1) Add note\n2) Edit note\n3) Remove note\n4) View note\n5) Exit");
  printf(">> ");
  return get_int();
}
