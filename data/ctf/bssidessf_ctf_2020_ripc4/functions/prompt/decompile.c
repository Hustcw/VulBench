char *__cdecl prompt(const char *prompt_str)
{
  size_t l;
  const char *rv;

  printf("%s> ", prompt_str);
  rv = fgets(buf_3753, 4096, stdin);
  if ( !rv )
    return 0LL;
  l = strlen(rv);
  if ( rv[l - 1] == 10 )
    rv[l - 1] = 0;
  return (char *)rv;
}
