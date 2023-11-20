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
    func_ptr_list[result] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_multiplayer_enable;
  func_ptr_list[3] = (int)cmd_multiplayer_disable;
  func_ptr_list[4] = (int)cmd_multiplayer_recvmap;
  func_ptr_list[5] = (int)cmd_multiplayer_sendmap;
  return result;
}