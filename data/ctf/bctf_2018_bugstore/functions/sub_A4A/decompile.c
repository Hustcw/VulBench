unsigned __int64 sub_A4A()
{
  char v1[312];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  strcpy(
    v1,
    "=================================================\n"
    " _ __  __   , ,___    __, _________  _ __  ______\n"
    "( /  )( /  / /   /   (   (  /  /  ()( /  )(  /   \n"
    " /--<  /  / /  __     `.   /  /   /  /--<   /--  \n"
    "/___/ (_,/_(___/    (___)_/  (___/  /   _(/____/\n"
    "\n"
    "=================================================\n"
    "\n");
  puts(v1);
  signal(14, (__sighandler_t)handler);
  alarm(0x32u);
  return __readfsqword(0x28u) ^ v2;
}
