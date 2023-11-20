void __fastcall i2ulaw_array(const int *ptr, int count, unsigned __int8 *buffer)
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
      if ( (v6 & 0x80000000) != 0LL )
        v5 = ulaw_encode[-(int)v6 >> 18] & 0x7F;
      else
        v5 = ulaw_encode[v6 >> 18];
      buffer[i] = v5;
    }
  }
}
