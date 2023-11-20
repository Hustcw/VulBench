void __cdecl readline(char *a1, int a2, FILE *a3)
{
  fgets(a1, a2, a3);
  a1[strcspn(a1, "\n")] = 0;
}