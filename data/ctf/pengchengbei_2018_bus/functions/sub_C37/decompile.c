__int64 __fastcall sub_C37(const char *a1)
{
  int i;

  for ( i = 0; i <= 31; ++i )
  {
    if ( *((_QWORD *)&unk_202080 + i) && !strcmp(a1, *((const char **)&unk_202080 + i)) )
      return (unsigned int)i;
  }
  return 0xFFFFFFFFLL;
}
