char *__fastcall sub_400B38(char *a1, size_t a2)
{
  char *result;
  unsigned int i;
  char v4[4];

  memset(a1, 0, a2);
  for ( i = 0; i < a2 - 1; ++i )
  {
    v4[0] = 0;
    if ( read(0, v4, 1u) < 0 )
      exit(0);
    if ( v4[0] == 10 )
      break;
    a1[i] = v4[0];
  }
  result = &a1[a2 - 1];
  *result = 0;
  return result;
}
