static
ECDSA_SIG *SM2_sig_gen(const EC_KEY *key, const BIGNUM *e)
{
    const BIGNUM *dA = EC_KEY_get0_private_key(key);
    const EC_GROUP *group = EC_KEY_get0_group(key);
    const BIGNUM *order = EC_GROUP_get0_order(group);

    ECDSA_SIG *sig = NULL;
    EC_POINT *kG = NULL;
    BN_CTX *ctx = NULL;
    BIGNUM *k = NULL;
    BIGNUM *rk = NULL;
    BIGNUM *r = NULL;
    BIGNUM *s = NULL;
    BIGNUM *x1 = NULL;
    BIGNUM *tmp = NULL;

    kG = EC_POINT_new(group);
    if (kG == NULL)
        goto done;

    ctx = BN_CTX_new();
    if (ctx == NULL)
        goto done;

    BN_CTX_start(ctx);

    k = BN_CTX_get(ctx);
    rk = BN_CTX_get(ctx);
    x1 = BN_CTX_get(ctx);
    tmp = BN_CTX_get(ctx);

    if (tmp == NULL)
        goto done;

    /* These values are returned and so should not be allocated out of the context */
    r = BN_new();
    s = BN_new();

    if (r == NULL || s == NULL)
        goto done;

    for (;;) {
        BN_priv_rand_range(k, order);

        if (EC_POINT_mul(group, kG, k, NULL, NULL, ctx) == 0)
            goto done;

        if (EC_POINT_get_affine_coordinates_GFp(group, kG, x1, NULL, ctx) == 0)
            goto done;

        if (BN_mod_add(r, e, x1, order, ctx) == 0)
            goto done;

        /* try again if r == 0 or r+k == n */
        if (BN_is_zero(r))
            continue;

        BN_add(rk, r, k);

        if (BN_cmp(rk, order) == 0)
            continue;

        BN_add(s, dA, BN_value_one());
        BN_mod_inverse(s, s, order, ctx);

        BN_mod_mul(tmp, dA, r, order, ctx);
        BN_sub(tmp, k, tmp);

        BN_mod_mul(s, s, tmp, order, ctx);

        sig = ECDSA_SIG_new();

        if (sig == NULL)
            goto done;

         /* takes ownership of r and s */
        ECDSA_SIG_set0(sig, r, s);
        break;
    }

 done:

    if (sig == NULL) {
        BN_free(r);
        BN_free(s);
    }

    BN_CTX_free(ctx);
    EC_POINT_free(kG);
    return sig;

}