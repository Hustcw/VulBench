int show_main_menu()
{
  int result;

  puts("\n-+STARBOUND v1.0+-");
  puts("  0. Exit");
  puts("  1. Info");
  puts("  2. Move");
  puts("  3. View");
  puts("  4. Tools");
  puts("  5. Kill");
  puts("  6. Settings");
  puts("  7. Multiplayer");
  __printf_chk(1, "> ");
  for ( result = 0; result <= 9; ++result )
    dword_8058154[result] = (int)cmd_nop;
  dword_8058158 = (int)cmd_info;
  dword_805815C = (int)cmd_move;
  dword_8058160 = (int)cmd_view;
  dword_8058164 = (int)cmd_build;
  dword_8058168 = (int)cmd_kill;
  dword_805816C = (int)cmd_settings;
  dword_8058170 = (int)cmd_multiplayer;
  return result;
}
