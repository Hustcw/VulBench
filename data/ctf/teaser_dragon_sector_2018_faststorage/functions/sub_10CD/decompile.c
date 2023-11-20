int sub_10CD()
{
  size_t v1;
  void *v2;
  int v3;
  void *buf;
  size_t n[3];

  n[0] = 0LL;
  buf = 0LL;
  if ( !(unsigned int)sub_E3A((unsigned __int64 *)&buf, n) )
    return puts("No such entry!");
  printf("Value: ");
  v1 = n[0];
  v2 = buf;
  v3 = fileno(stdout);
  write(v3, v2, v1);
  return puts(byte_1446);
}
