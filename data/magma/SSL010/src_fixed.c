static ossl_inline BIGNUM *bn_expand(BIGNUM *a, int bits) {
  if (bits > (INT_MAX - BN_BITS2 + 1))
    return NULL;

  if (((bits + BN_BITS2 - 1) / BN_BITS2) <= (a)->dmax)
    return a;

  return bn_expand2((a), (bits + BN_BITS2 - 1) / BN_BITS2);
}
