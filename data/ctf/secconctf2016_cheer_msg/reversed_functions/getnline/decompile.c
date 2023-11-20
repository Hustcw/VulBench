size_t __cdecl getnline(char *s, int n)
{
  char *v3; 

  fgets(s, n, stdin);
  v3 = strchr(s, 10);
  if ( v3 )
    *v3 = 0;
  return strlen(s);
}