BIGNUM *__fastcall bn_expand(BIGNUM *a, int bits)
{
  int v2;

  v2 = (int)(bits + ((unsigned int)((bits + 63) >> 31) >> 26) + 63) >> 6;
  if ( v2 <= a->dmax )
    return a;
  else
    return bn_expand2(a, v2);
}
