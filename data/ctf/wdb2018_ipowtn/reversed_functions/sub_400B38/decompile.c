void __fastcall sub_400B38(char *a1, size_t a2)
{
  size_t i;
  char v3[4];

  memset(a1, 0, a2);
  for ( i = 0; i < a2 - 1; ++i )
  {
    v3[0] = 0;
    if ( read(0, v3, 1u) < 0 )
      exit(0);
    if ( v3[0] == 10 )
      break;
    a1[i] = v3[0];
  }
  a1[a2 - 1] = 0;
}