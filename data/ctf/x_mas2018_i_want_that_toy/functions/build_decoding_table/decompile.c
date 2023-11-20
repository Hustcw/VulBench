unsigned __int64 build_decoding_table()
{
  int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  decoding_table = malloc(0x100uLL);
  for ( i = 0; i <= 63; ++i )
    *((_BYTE *)decoding_table + encoding_table[i]) = i;
  return __readfsqword(0x28u) ^ v2;
}
