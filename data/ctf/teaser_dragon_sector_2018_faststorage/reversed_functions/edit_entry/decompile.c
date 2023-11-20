void edit_entry()
{
  size_t v0;
  void *v1;
  int v2;
  char *s;
  __int64 n;

  n[0] = 0LL;
  s = 0LL;
  if ( (unsigned int)get_entry_by_name(&s, &n) )
  {
    printf("Value: ");
    memset(s, 0, n[0]);
    v0 = n[0];
    v1 = s;
    v2 = fileno(stdin);
    read(v2, v1, v0);
  }
  else
  {
    puts("No such entry!");
  }
}