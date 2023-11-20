void __noreturn cmd_kill()
{
  char v1[268];

  __printf_chk(1, "Why???? ");
  v1[readn(v1, 0x100u) - 1] = 0;
  do_die(v1);
}
