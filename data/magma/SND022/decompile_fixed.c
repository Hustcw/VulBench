void __fastcall d2ulaw_array(const double *ptr, int count, unsigned __int8 *buffer, double normfact)
{
  __int64 i;
  unsigned __int8 v6;
  int v7;
  double v8;

  if ( count > 0 )
  {
    for ( i = 0LL; i != count; buffer[i++] = v6 )
    {
      if ( fabs(ptr[i]) == INFINITY )
      {
        v6 = 0;
      }
      else
      {
        v8 = ptr[i];
        v7 = psf_lrint_15(v8);
        if ( v8 >= 0.0 )
          v6 = ulaw_encode[v7];
        else
          v6 = ulaw_encode[-v7] & 0x7F;
      }
    }
  }
}
