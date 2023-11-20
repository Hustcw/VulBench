void bn_sqr_normal(BN_ULONG *r, const BN_ULONG *a, int n, BN_ULONG *tmp)
{
    int i, j, max;
    const BN_ULONG *ap;
    BN_ULONG *rp;

    max = n * 2;
    ap = a;
    rp = r;
    rp[0] = rp[max - 1] = 0;
    rp++;
    j = n;

    if (--j > 0) {
        ap++;
        rp[j] = bn_mul_words(rp, ap, j, ap[-1]);
        rp += 2;
    }

    for (i = n - 2; i > 0; i--) {
        j--;
        ap++;
        rp[j] = bn_mul_add_words(rp, ap, j, ap[-1]);
        rp += 2;
    }

    bn_add_words(r, r, r, max);

    /* There will not be a carry */

    bn_sqr_words(tmp, a, n);

    bn_add_words(r, r, tmp, max);
}