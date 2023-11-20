void __cdecl read_str(char *s, int a2)
{
  int i;
  ssize_t v3;
  char *v4;

  for ( i = 0; i < a2; i += v3 )
  {
    v3 = read(0, &s[i], 0x1F4u);
    if ( !v3 )
    {
      perror("read");
      exit(1);
    }
    v4 = strchr(s, 10);
    if ( v4 )
    {
      *v4 = 0;
      return;
    }
  }
}