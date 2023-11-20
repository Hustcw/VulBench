const char *__cdecl sub_80489C8(const char *a1)
{
  const char *v2;
  const char *i;

  if ( !a1 || !*a1 )
    return a1;
  v2 = a1;
  for ( i = &a1[strlen(a1) - 1]; i > v2; --i )
  {
    *v2 ^= *i;
    *i ^= *v2;
    *v2++ ^= *i;
  }
  return a1;
}