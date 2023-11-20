void __cdecl __noreturn do_die(const char *a1)
{
  int v1;
  char buf[1036];

  __printf_chk(1, a1);
  puts("");
  __printf_chk(1, "Save your record? (y/n)");
  read(0, buf, 0x400u);
  if ( buf[0] == 121 )
  {
    v1 = __sprintf_chk(buf, 1, 1024, "Map seed: %08X\nScore: %d\n", me, dword_8057F94);
    memcpy(&buf[v1], byte_8057F98, dword_8057F84 >> 1);
    do_send_record(buf, 0x400u);
  }
  do_bye();
  exit(0);
}