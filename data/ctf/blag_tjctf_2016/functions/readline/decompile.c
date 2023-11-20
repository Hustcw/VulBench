unsigned int __cdecl readline(char *a1, int a2, FILE *a3)
{
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  fgets(a1, a2, a3);
  a1[strcspn(a1, "\n")] = 0;
  return __readgsdword(0x14u) ^ v4;
}
