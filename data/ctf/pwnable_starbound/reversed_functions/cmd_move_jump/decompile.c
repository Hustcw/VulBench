void cmd_move_jump()
{
  bool v0;
  int v1;
  int v2;
  int v3;
  char s[22];

  __printf_chk(1, "left or right? ");
  fgets(s, 10, stdin);
  v0 = memcmp(s, "left", 4u) == 0;
  v1 = pos;
  if ( v0 )
  {
    pos = v1 + rand() % 100 + 100;
  }
  else
  {
    v2 = rand();
    pos = v1 + 100 * (v2 / 100) - v2 - 100;
  }
  v3 = pos % dword_8057F84;
  pos = v3;
  if ( v3 < 0 )
    pos = v3 + dword_8057F84;
  __printf_chk(1, "Iku~~ ");
  sleep(1u);
  putchar(46);
  sleep(1u);
  putchar(46);
  sleep(1u);
  puts(".");
  __printf_chk(1, "Landing .");
  sleep(1u);
  putchar(46);
  sleep(1u);
  putchar(46);
  puts(" Ouch!");
  check_pos();
}