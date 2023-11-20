void cmd_build_place()
{
  int v0;
  char v1;
  int v2;

  v0 = pos >> 1;
  v1 = byte_8057F98[pos >> 1];
  if ( (int)abs32(pos - dword_8058150) > 9 )
  {
    if ( ((byte_8057F98[pos >> 1] >> (4 * (pos & 1))) & 0xF) == 15 )
    {
      puts("I can't breathe anymore!!");
      hp -= 10;
      if ( hp <= 0 )
        do_die("*Suffocated*");
    }
    else
    {
      v2 = dword_8057F8C;
      if ( dword_8057F8C <= 0 )
      {
        puts("No more cobblestone :(");
      }
      else
      {
        if ( (pos & 1) != 0 )
          byte_8057F98[v0] = v1 + 16;
        else
          byte_8057F98[v0] = v1 + 1;
        dword_8057F8C = v2 - 1;
        ++dword_8057F94;
      }
    }
  }
  else
  {
    check_pos();
  }
}