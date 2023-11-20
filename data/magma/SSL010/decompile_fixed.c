BIGNUM *__fastcall bn_expand(BIGNUM *a, int bits)
{
  if ( a->dmax <= 0 )
    return bn_expand2(a, 1);
  else
    return a;
}
