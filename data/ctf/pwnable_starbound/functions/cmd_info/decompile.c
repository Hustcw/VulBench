int cmd_info()
{
  int i;
  char v2[28];

  get_server_key((int)v2);
  puts("\n-+STARBOUND v1.0: INFORMATION+-");
  __printf_chk(1, " |  Server ID: ");
  for ( i = 0; i <= 15; ++i )
    __printf_chk(1, "%02X", (unsigned __int8)v2[i]);
  puts("");
  __printf_chk(1, " |  Seed: %08X\n", me);
  __printf_chk(1, " |  Size: %d\n", dword_8057F84);
  __printf_chk(1, " +  Player: %s (from %s)\n", byte_80580D0, cp);
  __printf_chk(1, " |  Position: %d\n", dword_8057F88);
  __printf_chk(1, " |  HP: %d\n", dword_8057F90);
  __printf_chk(1, " |  Cobblestone: %d\n", dword_8057F8C);
  __printf_chk(1, " |  Score: %d\n", dword_8057F94);
  return puts("");
}
