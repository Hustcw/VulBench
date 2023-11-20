__int64 __fastcall sub_B38(_BYTE *a1)
{
  int i;
  unsigned int v4;

  v4 = 0;
  while ( *a1 )
  {
    for ( i = 0; i <= 7; ++i )
    {
      if ( (((int)(unsigned __int8)*a1 >> i) & 1) != 0 )
        LOBYTE(v4) = v4 + 1;
    }
    ++a1;
    v4 &= 0x1Fu;
  }
  return v4;
}
