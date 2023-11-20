void sub_C79()
{
  int i;
  __int64 v1;
  __int64 v2;

  for ( i = 2; i < n; ++i )
  {
    v1 = x[i - 2] * A;
    v2 = x[i - 1] * B;
    if ( v1 > 0 && v2 > 0x7FFFFFFFFFFFFFFFLL - v1 || v1 < 0 && v2 < 0x7FFFFFFFFFFFFFFFLL - v1 )
      sub_A97("Overflow detected");
    x[i] = v1 + v2;
  }
}