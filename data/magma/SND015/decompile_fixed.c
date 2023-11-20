void __fastcall i2alaw_array(const int *ptr, int count, unsigned __int8 *buffer)
{
  __int64 v3;
  __int64 i;
  unsigned __int8 v5;
  unsigned __int64 v6;

  if ( count > 0 )
  {
    v3 = (unsigned int)count;
    for ( i = 0LL; i != v3; ++i )
    {
      v6 = (unsigned int)ptr[i];
      v5 = -86;
      if ( v6 != 0x80000000 )
      {
        if ( (v6 & 0x80000000) != 0LL )
          v5 = alaw_encode[-(int)v6 >> 20] & 0x7F;
        else
          v5 = alaw_encode[v6 >> 20];
      }
      buffer[i] = v5;
    }
  }
}
