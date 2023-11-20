void show_settings_menu()
{
  int i;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: SETTINGS+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Name");
  puts("  3. IP");
  puts("  4. Toggle View");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_set_name;
  func_ptr_list[3] = (int)cmd_set_ip;
  func_ptr_list[4] = (int)cmd_set_autoview;
}