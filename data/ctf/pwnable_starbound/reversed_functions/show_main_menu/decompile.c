void show_main_menu()
{
  int i;

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
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_info;
  func_ptr_list[2] = (int)cmd_move;
  func_ptr_list[3] = (int)cmd_view;
  func_ptr_list[4] = (int)cmd_build;
  func_ptr_list[5] = (int)cmd_kill;
  func_ptr_list[6] = (int)cmd_settings;
  func_ptr_list[7] = (int)cmd_multiplayer;
}