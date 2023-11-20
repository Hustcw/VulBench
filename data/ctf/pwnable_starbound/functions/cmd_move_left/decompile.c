int cmd_move_left()
{
  int v0;

  v0 = dword_8057F88 - 1;
  dword_8057F88 = v0;
  if ( v0 < 0 )
    dword_8057F88 = dword_8057F84 + v0;
  puts("[Info] Moved left...");
  return check_pos();
}
