void __fastcall d2ulaw_array(const double *ptr, int count, unsigned __int8 *buffer, double normfact, double a5)
{
  __int64 i;
  unsigned __int8 v7;
  int v8;
  double v9;

  if ( count > 0 )
  {
    for ( i = 0LL; i != count; buffer[i++] = v7 )
    {
      v9 = ptr[i];
      v8 = psf_lrint_15(a5);
      if ( v9 < 0.0 )
        v7 = ulaw_encode[-v8] & 0x7F;
      else
        v7 = ulaw_encode[v8];
    }
  }
}
