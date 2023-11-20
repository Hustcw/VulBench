int show_build_menu()
{
  int result;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: TOOLS+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Pickaxe");
  puts("  3. Cobblestone");
  __printf_chk(1, "> ");
  for ( result = 0; result <= 9; ++result )
    dword_8058154[result] = (int)cmd_nop;
  dword_8058158 = (int)cmd_go_back;
  dword_805815C = (int)cmd_build_dig;
  dword_8058160 = (int)cmd_build_place;
  return result;
}
