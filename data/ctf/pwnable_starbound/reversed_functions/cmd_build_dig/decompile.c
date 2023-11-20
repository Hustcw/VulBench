void cmd_build_dig()
{
  int v0;
  char v1;

  if ( (int)abs32(pos - dword_8058150) > 9 )
  {
    v0 = pos >> 1;
    v1 = byte_8057F98[pos >> 1];
    if ( ((v1 >> (4 * (pos & 1))) & 0xF) != 0 )
    {
      if ( (pos & 1) != 0 )
        byte_8057F98[v0] = v1 - 16;
      else
        byte_8057F98[v0] = v1 - 1;
      ++dword_8057F8C;
      ++dword_8057F94;
      puts("[Info] Dig..dig..dig..");
    }
    else
    {
      puts(">Crash< ... so hard!");
    }
  }
  else
  {
    check_pos();
  }
}