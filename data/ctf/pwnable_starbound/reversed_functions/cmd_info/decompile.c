void cmd_info()
{
  int i;
  char v1[28];

  get_server_key((int)v1);
  puts("\n-+STARBOUND v1.0: INFORMATION+-");
  __printf_chk(1, " |  Server ID: ");
  for ( i = 0; i <= 15; ++i )
    __printf_chk(1, "%02X", (unsigned __int8)v1[i]);
  puts("");
  __printf_chk(1, " |  Seed: %08X\n", me);
  __printf_chk(1, " |  Size: %d\n", dword_8057F84);
  __printf_chk(1, " +  Player: %s (from %s)\n", byte_80580D0, cp);
  __printf_chk(1, " |  Position: %d\n", pos);
  __printf_chk(1, " |  HP: %d\n", hp);
  __printf_chk(1, " |  Cobblestone: %d\n", dword_8057F8C);
  __printf_chk(1, " |  Score: %d\n", dword_8057F94);
  puts("");
}