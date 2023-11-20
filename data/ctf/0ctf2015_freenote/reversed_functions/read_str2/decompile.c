__int64 __fastcall read_str2(char *a1, int a2)
{
  unsigned int i;

  if ( a2 <= 0 )
    return 0LL;
  for ( i = 0; a2 - 1 > (int)i && (int)read(0, &a1[i], 1uLL) > 0 && a1[i] != 10; ++i )
    ;
  a1[i] = 0;
  return i;
}