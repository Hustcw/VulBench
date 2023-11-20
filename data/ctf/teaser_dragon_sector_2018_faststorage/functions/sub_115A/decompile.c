int sub_115A()
{
  size_t v1;
  void *v2;
  int v3;
  void *s;
  size_t n[3];

  n[0] = 0LL;
  s = 0LL;
  if ( !(unsigned int)sub_E3A((unsigned __int64 *)&s, n) )
    return puts("No such entry!");
  printf("Value: ");
  memset(s, 0, n[0]);
  v1 = n[0];
  v2 = s;
  v3 = fileno(stdin);
  return read(v3, v2, v1);
}
