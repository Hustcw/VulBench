void cmd_move_left()
{
  int v0;

  v0 = pos - 1;
  pos = v0;
  if ( v0 < 0 )
    pos = dword_8057F84 + v0;
  puts("[Info] Moved left...");
  check_pos();
}