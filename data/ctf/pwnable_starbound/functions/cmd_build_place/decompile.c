int cmd_build_place()
{
  int v0;
  char v1;
  int result;
  int v3;

  v0 = dword_8057F88 >> 1;
  v1 = byte_8057F98[dword_8057F88 >> 1];
  if ( (int)abs32(dword_8057F88 - dword_8058150) <= 9 )
    return check_pos();
  if ( ((byte_8057F98[dword_8057F88 >> 1] >> (4 * (dword_8057F88 & 1))) & 0xF) == 15 )
  {
    puts("I can't breathe anymore!!");
    result = dword_8057F90 - 10;
    dword_8057F90 = result;
    if ( result <= 0 )
      do_die("*Suffocated*");
  }
  else
  {
    v3 = dword_8057F8C;
    if ( dword_8057F8C <= 0 )
    {
      return puts("No more cobblestone :(");
    }
    else
    {
      if ( (dword_8057F88 & 1) != 0 )
        byte_8057F98[v0] = v1 + 16;
      else
        byte_8057F98[v0] = v1 + 1;
      result = v3 - 1;
      dword_8057F8C = result;
      ++dword_8057F94;
    }
  }
  return result;
}
