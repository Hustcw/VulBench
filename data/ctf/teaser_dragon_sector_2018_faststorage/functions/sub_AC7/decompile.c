__int64 __fastcall sub_AC7(unsigned __int8 *a1)
{
  unsigned __int16 v3;

  v3 = 0;
  while ( *a1 && a1[1] )
  {
    v3 ^= *(_WORD *)a1;
    a1 += 2;
  }
  if ( *a1 )
    v3 ^= *a1;
  return ((v3 >> 10) ^ (unsigned __int8)(v3 ^ (v3 >> 5))) & 0x1F;
}
