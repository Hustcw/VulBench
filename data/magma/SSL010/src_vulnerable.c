static ossl_inline BIGNUM *bn_expand(BIGNUM *a, int bits) {
  return ((((((bits + BN_BITS2 - 1)) / BN_BITS2)) <= (a)->dmax)
              ? (a)
              : bn_expand2((a), (bits + BN_BITS2 - 1) / BN_BITS2));
}

