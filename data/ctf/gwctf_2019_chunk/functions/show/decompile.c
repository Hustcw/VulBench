unsigned __int64 show()
{
  char nptr;
  int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("Which book do you want to show?");
  read_0(&nptr, 16LL);
  v2 = atoi(&nptr);
  printf("Content: %s", (const char *)chunk[v2]);
  return __readfsqword(0x28u) ^ v3;
}
