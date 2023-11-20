void __cdecl read_str(char *a1, unsigned int a2)
{
  unsigned int v2;
  int v3;
  unsigned int i;

  v3 = getchar();
  for ( i = 0; i < a2 && v3 != -1 && v3 != 10; ++i )
  {
    v2 = i;
    a1[v2] = v3;
    v3 = getchar();
  }
  a1[i] = 0;
  a1[a2 - 1] = 0;
}