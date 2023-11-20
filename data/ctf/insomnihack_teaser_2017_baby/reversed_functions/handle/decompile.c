__int64 __fastcall handle(unsigned int a1)
{
  char v2[8];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  do
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          sendstr(
            a1,
            "Welcome to baby's first pwn.\n"
            "Pick your favorite vuln : \n"
            "   1. Stack overflow\n"
            "   2. Format string\n"
            "   3. Heap Overflow\n"
            "   4. Exit\n"
            "Your choice > ");
          recvlen(a1, (__int64)v2, 2uLL);
          if ( v2[0] != 50 )
            break;
          dofmt(a1);
        }
        if ( v2[0] > 50 )
          break;
        if ( v2[0] == 49 )
          dostack(a1);
      }
      if ( v2[0] != 51 )
        break;
      doheap(a1);
    }
  }
  while ( v2[0] != 52 );
  return 0LL;
}