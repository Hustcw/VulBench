char *__cdecl sub_B8C(char *s, int a2)
{
  char *result;
  int i;
  ssize_t v4;
  char *v5;

  for ( i = 0; ; i += v4 )
  {
    result = (char *)i;
    if ( i >= a2 )
      break;
    v4 = read(0, &s[i], 0x1F4u);
    if ( !v4 )
    {
      perror("read");
      exit(1);
    }
    v5 = strchr(s, 10);
    if ( v5 )
    {
      result = v5;
      *v5 = 0;
      return result;
    }
  }
  return result;
}
