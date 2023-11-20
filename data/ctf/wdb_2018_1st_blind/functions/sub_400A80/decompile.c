unsigned __int64 sub_400A80()
{
  unsigned int v1;
  char s[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("Index:");
  memset(s, 0, 0x10uLL);
  read(0, s, 0xFuLL);
  v1 = atoi(s);
  if ( v1 <= 5 && *(&ptr + v1) )
  {
    printf("Content:");
    sub_400932((__int64)*(&ptr + v1), 0x68u);
    puts("Done!");
  }
  return __readfsqword(0x28u) ^ v3;
}
