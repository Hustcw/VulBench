int BN_lshift(BIGNUM *r, const BIGNUM *a, int n)
{
    int i, nw, lb, rb;
    BN_ULONG *t, *f;
    BN_ULONG l;

    bn_check_top(r);
    bn_check_top(a);

    if (n < 0) {
        BNerr(BN_F_BN_LSHIFT, BN_R_INVALID_SHIFT);
        return 0;
    }

    nw = n / BN_BITS2;
    if (bn_wexpand(r, a->top + nw + 1) == NULL)
        return 0;
    r->neg = a->neg;
    lb = n % BN_BITS2;
    rb = BN_BITS2 - lb;
    f = a->d;
    t = r->d;
    t[a->top + nw] = 0;
    if (lb == 0)
        for (i = a->top - 1; i >= 0; i--)
            t[nw + i] = f[i];
    else
        for (i = a->top - 1; i >= 0; i--) {
            l = f[i];
            t[nw + i + 1] |= (l >> rb) & BN_MASK2;
            t[nw + i] = (l << lb) & BN_MASK2;
        }
    memset(t, 0, sizeof(*t) * nw);
    r->top = a->top + nw + 1;
    bn_correct_top(r);
    bn_check_top(r);
    return 1;
}