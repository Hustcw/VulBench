void cmd_move_right()
{
  int v0;

  v0 = pos + 1;
  pos = v0;
  if ( v0 >= dword_8057F84 )
    pos = v0 - dword_8057F84;
  puts("[Info] Moved right...");
  check_pos();
}