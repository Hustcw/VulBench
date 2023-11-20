unsigned __int64 __fastcall debug(const char *a1, char *a2, char *a3)
{
  char *i;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  printf("Debug in %s\n", a1);
  printf("  main @ %p\n", main);
  printf("  printf @ %p\n", &printf);
  printf("  malloc @ %p\n", &malloc);
  putchar(10);
  printf("RSP is %p, RBP is %p\n", a3, a2);
  putchar(10);
  for ( i = a3; i <= a2; i += 16 )
    hexdump_line(i);
  return __readfsqword(0x28u) ^ v6;
}