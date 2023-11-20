void sub_400A80()
{
  unsigned int v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index:");
  memset(s, 0, 0x10uLL);
  read(0, s, 0xFuLL);
  v0 = atoi(s);
  if ( v0 <= 5 )
  {
    if ( a1[v0] )
    {
      printf("Content:");
      sub_400932(a1[v0], 0x68u);
      puts("Done!");
    }
  }
}