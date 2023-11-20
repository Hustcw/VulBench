int show_multiplayer_menu()
{
  int result;

  puts("\n-+STARBOUND v1.0: MULTIPLAYER+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Enable");
  puts("  3. Disable");
  puts("  4. Teleport");
  puts("  5. Share Your Coordinate");
  __printf_chk(1, "> ");
  for ( result = 0; result <= 9; ++result )
    dword_8058154[result] = (int)cmd_nop;
  dword_8058158 = (int)cmd_go_back;
  dword_805815C = (int)cmd_multiplayer_enable;
  dword_8058160 = (int)cmd_multiplayer_disable;
  dword_8058164 = (int)cmd_multiplayer_recvmap;
  dword_8058168 = (int)cmd_multiplayer_sendmap;
  return result;
}
