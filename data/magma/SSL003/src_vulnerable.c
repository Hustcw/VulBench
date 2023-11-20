int asn1_d2i_read_bio(BIO *in, BUF_MEM **pb) {
  BUF_MEM *b;
  unsigned char *p;
  int i;
  size_t want = HEADER_SIZE;
  uint32_t eos = 0;
  size_t off = 0;
  size_t len = 0;
  size_t diff;

  const unsigned char *q;
  long slen;
  int inf, tag, xclass;

  b = BUF_MEM_new();
  if (b == NULL) {
    ERR_raise(ERR_LIB_ASN1, ERR_R_MALLOC_FAILURE);
    return -1;
  }

  ERR_set_mark();
  for (;;) {
    diff = len - off;
    if (want >= diff) {
      want -= diff;

      if (len + want < len || !BUF_MEM_grow_clean(b, len + want)) {
        ERR_raise(ERR_LIB_ASN1, ERR_R_MALLOC_FAILURE);
        goto err;
      }
      i = BIO_read(in, &(b->data[len]), want);
      if (i < 0 && diff == 0) {
        ERR_raise(ERR_LIB_ASN1, ASN1_R_NOT_ENOUGH_DATA);
        goto err;
      }
      if (i > 0) {
        if (len + i < len) {
          ERR_raise(ERR_LIB_ASN1, ASN1_R_TOO_LONG);
          goto err;
        }
        len += i;
      }
    }
    /* else data already loaded */

    p = (unsigned char *)&(b->data[off]);
    q = p;
    diff = len - off;
    if (diff == 0)
      goto err;
    inf = ASN1_get_object(&q, &slen, &tag, &xclass, diff);
    if (inf & 0x80) {
      unsigned long e;

      e = ERR_GET_REASON(ERR_peek_last_error());
      if (e != ASN1_R_TOO_LONG)
        goto err;
      ERR_pop_to_mark();
    }
    i = q - p; /* header length */
    off += i;  /* end of data */

    if (inf & 1) {
      /* no data body so go round again */
      if (eos == UINT32_MAX) {
        ERR_raise(ERR_LIB_ASN1, ASN1_R_HEADER_TOO_LONG);
        goto err;
      }
      eos++;
      want = HEADER_SIZE;
    } else if (eos && (slen == 0) && (tag == V_ASN1_EOC)) {
      /* eos value, so go back and read another header */
      eos--;
      if (eos == 0)
        break;
      else
        want = HEADER_SIZE;
    } else {
      /* suck in slen bytes of data */
      want = slen;
      if (want > (len - off)) {
        want -= (len - off);
        size_t chunk_max = want;
        if (want > INT_MAX /* BIO_read takes an int length */ ||
            len + want < len) {
          ERR_raise(ERR_LIB_ASN1, ASN1_R_TOO_LONG);
          goto err;
        }
        while (want > 0) {
          /*
           * Read content in chunks of increasing size
           * so we can return an error for EOF without
           * having to allocate the entire content length
           * in one go.
           */
          size_t chunk = want > chunk_max ? chunk_max : want;

          if (!BUF_MEM_grow_clean(b, len + chunk)) {
            ERR_raise(ERR_LIB_ASN1, ERR_R_MALLOC_FAILURE);
            goto err;
          }
          want -= chunk;
          while (chunk > 0) {
            i = BIO_read(in, &(b->data[len]), chunk);
            if (i <= 0) {
              ERR_raise(ERR_LIB_ASN1, ASN1_R_NOT_ENOUGH_DATA);
              goto err;
            }
            /*
             * This can't overflow because |len+want| didn't
             * overflow.
             */
            len += i;
            chunk -= i;
          }
          if (chunk_max < INT_MAX / 2)
            chunk_max *= 2;
        }
      }
      if (off + slen < off) {
        ERR_raise(ERR_LIB_ASN1, ASN1_R_TOO_LONG);
        goto err;
      }
      off += slen;
      if (eos == 0) {
        break;
      } else
        want = HEADER_SIZE;
    }
  }

  if (off > INT_MAX) {
    ERR_raise(ERR_LIB_ASN1, ASN1_R_TOO_LONG);
    goto err;
  }

  *pb = b;
  return off;
err:
  ERR_clear_last_mark();
  BUF_MEM_free(b);
  return -1;
}

