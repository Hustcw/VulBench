__int64 __fastcall main(int a1, char **a2, char **a3)
{
  char buf[1032];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  setbuf(stdout, 0LL);
  setbuf(stdin, 0LL);
  setbuf(stderr, 0LL);
  puts("+++++++++++++++++++++++++++");
  puts("So, let's crash the world");
  puts("+++++++++++++++++++++++++++");
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu();
        if ( !read(0, buf, 0x400uLL) )
          return 1LL;
        if ( strncmp(buf, "create ", 7uLL) )
          break;
        create();
      }
      if ( strncmp(buf, "delete ", 7uLL) )
        break;
      delete();
    }
    if ( !strncmp(buf, "quit ", 5uLL) )
      break;
    puts("Invalid cmd");
  }
  puts("Bye~");
  return 0LL;
}