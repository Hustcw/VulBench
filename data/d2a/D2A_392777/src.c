static int asn1_get_length(const unsigned char **pp, int *inf, long *rl,
                           int max)
{
    const unsigned char *p = *pp;
    unsigned long ret = 0;
    unsigned int i;

    if (max-- < 1)
        return (0);
    if (*p == 0x80) {
        *inf = 1;
        ret = 0;
        p++;
    } else {
        *inf = 0;
        i = *p & 0x7f;
        if (*(p++) & 0x80) {
            if (max < (int)i)
                return 0;
            /* Skip leading zeroes */
            while (i && *p == 0) {
                p++;
                i--;
            }
            if (i > sizeof(long))
                return 0;
            while (i-- > 0) {
                ret <<= 8L;
                ret |= *(p++);
            }
        } else
            ret = i;
    }
    if (ret > LONG_MAX)
        return 0;
    *pp = p;
    *rl = (long)ret;
    return (1);
}