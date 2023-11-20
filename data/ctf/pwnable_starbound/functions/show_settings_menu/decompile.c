int show_settings_menu()
{
  int result;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: SETTINGS+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Name");
  puts("  3. IP");
  puts("  4. Toggle View");
  __printf_chk(1, "> ");
  for ( result = 0; result <= 9; ++result )
    dword_8058154[result] = (int)cmd_nop;
  dword_8058158 = (int)cmd_go_back;
  dword_805815C = (int)cmd_set_name;
  dword_8058160 = (int)cmd_set_ip;
  dword_8058164 = (int)cmd_set_autoview;
  return result;
}
