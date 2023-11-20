void show_move_menu()
{
  int i;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: MOVE+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Left");
  puts("  3. Right");
  puts("  4. Jump");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_move_left;
  func_ptr_list[3] = (int)cmd_move_right;
  func_ptr_list[4] = (int)cmd_move_jump;
}