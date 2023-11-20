int cmd_build_dig()
{
  int v1;
  char v2;

  if ( (int)abs32(dword_8057F88 - dword_8058150) <= 9 )
    return check_pos();
  v1 = dword_8057F88 >> 1;
  v2 = byte_8057F98[dword_8057F88 >> 1];
  if ( ((v2 >> (4 * (dword_8057F88 & 1))) & 0xF) == 0 )
    return puts(">Crash< ... so hard!");
  if ( (dword_8057F88 & 1) != 0 )
    byte_8057F98[v1] = v2 - 16;
  else
    byte_8057F98[v1] = v2 - 1;
  ++dword_8057F8C;
  ++dword_8057F94;
  return puts("[Info] Dig..dig..dig..");
}
