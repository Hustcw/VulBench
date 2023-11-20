void sub_4009A7()
{
  unsigned int v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index:");
  memset(s, 0, 0x10uLL);
  read(0, s, 0xFuLL);
  v0 = atoi(s);
  if ( v0 <= 5 && !a1[v0] )
  {
    a1[v0] = malloc(0x68uLL);
    printf("Content:");
    sub_400932(a1[v0], 104LL);
    puts("Done!");
  }
}