/*
 * If |pad| is zero, the operation is effectively reduced to memcpy,
 * and if |pad| is 0xff, then it performs two's complement, ~dst + 1.
 * Note that in latter case sequence of zeros yields itself, and so
 * does 0x80 followed by any number of zeros. These properties are
 * used elsewhere below...
 */
static void twos_complement(unsigned char *dst, const unsigned char *src,
                            size_t len, unsigned char pad)
{
    unsigned int carry = pad & 1;

    /* Begin at the end of the encoding */
    if (len != 0) {
        /*
         * if len == 0 then src/dst could be NULL, and this would be undefined
         * behaviour.
         */
        dst += len;
        src += len;
    }
    /* two's complement value: ~value + 1 */
    while (len-- != 0) {
        *(--dst) = (unsigned char)(carry += *(--src) ^ pad);
        carry >>= 8;
    }
}

static size_t i2c_ibuf(const unsigned char *b, size_t blen, int neg,
                       unsigned char **pp) {
  unsigned int pad = 0;
  size_t ret, i;
  unsigned char *p, pb = 0;

  if (b != NULL && blen) {
    ret = blen;
    i = b[0];
    if (!neg && (i > 127)) {
      pad = 1;
      pb = 0;
    } else if (neg) {
      pb = 0xFF;
      if (i > 128) {
        pad = 1;
      } else if (i == 128) {
        /*
         * Special case [of minimal negative for given length]:
         * if any other bytes non zero we pad, otherwise we don't.
         */
        for (pad = 0, i = 1; i < blen; i++)
          pad |= b[i];
        pb = pad != 0 ? 0xffU : 0;
        pad = pb & 1;
      }
    }
    ret += pad;
  } else {
    ret = 1;
    blen = 0; /* reduce '(b == NULL || blen == 0)' to '(blen == 0)' */
  }

  if (pp == NULL || (p = *pp) == NULL)
    return ret;

  /*
   * This magically handles all corner cases, such as '(b == NULL ||
   * blen == 0)', non-negative value, "negative" zero, 0x80 followed
   * by any number of zeros...
   */
  *p = pb;
  p += pad; /* yes, p[0] can be written twice, but it's little
             * price to pay for eliminated branches */
  twos_complement(p, b, blen, pb);

  *pp += ret;
  return ret;
}
