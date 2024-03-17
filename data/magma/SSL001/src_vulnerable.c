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
  if (blen == 0)
    *(p++) = 0;
  else if (!neg)
    memcpy(p, b, (unsigned int)blen);
  else {
    /* Begin at the end of the encoding */
    const unsigned char *n = b + blen - 1;
    p += blen - 1;
    i = blen;

    /**
     * The representation of a negative zero is just all zeros. This routine
     * tries to optimize 2's complement by skipping all trailing zeros,
     * since trailing zeros are convserved by 2's complement. However, a
     * negative zero number is all trailing zeros. Thus, the routine will
     * underflow trying to skip them.
     */

    /* Copy zeros to destination as long as source is zero */
    while (!*n) {
      *(p--) = 0;
      n--;
      i--;
    }
    /* Complement and increment next octet */
    *(p--) = ((*(n--)) ^ 0xff) + 1;
    i--;
    /* Complement any octets left */
    for (; i > 0; i--)
      *(p--) = *(n--) ^ 0xff;
  }

  *pp += ret;
  return ret;
}
