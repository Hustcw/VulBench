__int64 __fastcall sub_C37(const char *a1)
{
  int i;

  for ( i = 0; i <= 31; ++i )
  {
    if ( destination[i] && !strcmp(a1, (const char *)destination[i]) )
      return (unsigned int)i;
  }
  return 0xFFFFFFFFLL;
}