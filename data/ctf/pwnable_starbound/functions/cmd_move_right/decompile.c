int cmd_move_right()
{
  int v0;

  v0 = dword_8057F88 + 1;
  dword_8057F88 = v0;
  if ( v0 >= dword_8057F84 )
    dword_8057F88 = v0 - dword_8057F84;
  puts("[Info] Moved right...");
  return check_pos();
}
