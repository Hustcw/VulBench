__int64 __fastcall dofmt(int a1)
{
  unsigned int v2;
  char s[1032];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sendstr(a1, "Simply type '\\n' to return\n");
  while ( 1 )
  {
    sendstr(a1, "Your format > ");
    v2 = recvlen_until(a1, s, 0x400uLL, "\n");
    if ( v2 == 1 )
      break;
    printf("%d\n", v2);
    puts(s);
    s[v2] = 0;
    dprintf(a1, s);
  }
  return 0LL;
}
