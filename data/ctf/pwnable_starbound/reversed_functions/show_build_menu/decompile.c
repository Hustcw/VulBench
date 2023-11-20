void show_build_menu()
{
  int i;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: TOOLS+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Pickaxe");
  puts("  3. Cobblestone");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_build_dig;
  func_ptr_list[3] = (int)cmd_build_place;
}