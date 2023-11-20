TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horAcc8(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  tmsize_t stride = PredictorState(tif)->stride;

  unsigned char *cp = (unsigned char *)cp0;

  if (cc > stride) {
    /*
     * Pipeline the most common cases.
     */
    if (stride == 3) {
      unsigned int cr = cp[0];
      unsigned int cg = cp[1];
      unsigned int cb = cp[2];
      cc -= 3;
      cp += 3;
      while (cc > 0) {
        cp[0] = (unsigned char)((cr += cp[0]) & 0xff);
        cp[1] = (unsigned char)((cg += cp[1]) & 0xff);
        cp[2] = (unsigned char)((cb += cp[2]) & 0xff);
        cc -= 3;
        cp += 3;
      }
    } else if (stride == 4) {
      unsigned int cr = cp[0];
      unsigned int cg = cp[1];
      unsigned int cb = cp[2];
      unsigned int ca = cp[3];
      cc -= 4;
      cp += 4;
      while (cc > 0) {
        cp[0] = (unsigned char)((cr += cp[0]) & 0xff);
        cp[1] = (unsigned char)((cg += cp[1]) & 0xff);
        cp[2] = (unsigned char)((cb += cp[2]) & 0xff);
        cp[3] = (unsigned char)((ca += cp[3]) & 0xff);
        cc -= 4;
        cp += 4;
      }
    } else {
      cc -= stride;
      do {
        REPEAT4(stride, cp[stride] = (unsigned char)((cp[stride] + *cp) & 0xff);
                cp++)
        cc -= stride;
      } while (cc > 0);
    }
  }
  return 1;
}

TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horAcc16(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  tmsize_t stride = PredictorState(tif)->stride;
  uint16_t *wp = (uint16_t *)cp0;
  tmsize_t wc = cc / 2;


  if (wc > stride) {
    wc -= stride;
    do {
      REPEAT4(stride, wp[stride] = (uint16_t)(((unsigned int)wp[stride] +
                                               (unsigned int)wp[0]) &
                                              0xffff);
              wp++)
      wc -= stride;
    } while (wc > 0);
  }
  return 1;
}

TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horAcc32(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  tmsize_t stride = PredictorState(tif)->stride;
  uint32_t *wp = (uint32_t *)cp0;
  tmsize_t wc = cc / 4;

#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", (cc % (4 * stride)) != 0);
#endif

  if (wc > stride) {
    wc -= stride;
    do {
      REPEAT4(stride, wp[stride] += wp[0]; wp++)
      wc -= stride;
    } while (wc > 0);
  }
  return 1;
}

static int fpAcc(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  tmsize_t stride = PredictorState(tif)->stride;
  uint32_t bps = tif->tif_dir.td_bitspersample / 8;
  tmsize_t wc = cc / bps;
  tmsize_t count = cc;
  uint8_t *cp = (uint8_t *)cp0;
  uint8_t *tmp;


  tmp = (uint8_t *)_TIFFmalloc(cc);
  if (!tmp)
    return 0;

  while (count > stride) {
    REPEAT4(stride, cp[stride] = (unsigned char)((cp[stride] + cp[0]) & 0xff);
            cp++)
    count -= stride;
  }

  _TIFFmemcpy(tmp, cp0, cc);
  cp = (uint8_t *)cp0;
  for (count = 0; count < wc; count++) {
    uint32_t byte;
    for (byte = 0; byte < bps; byte++) {
#if WORDS_BIGENDIAN
      cp[bps * count + byte] = tmp[byte * wc + count];
#else
      cp[bps * count + byte] = tmp[(bps - byte - 1) * wc + count];
#endif
    }
  }
  _TIFFfree(tmp);
  return 1;
}

static int PredictorDecodeTile(TIFF *tif, uint8_t *op0, tmsize_t occ0,
                               uint16_t s) {
  TIFFPredictorState *sp = PredictorState(tif);

  assert(sp != NULL);
  assert(sp->decodetile != NULL);

  if ((*sp->decodetile)(tif, op0, occ0, s)) {
    tmsize_t rowsize = sp->rowsize;
    assert(rowsize > 0);


    assert(sp->decodepfunc != NULL);
    while (occ0 > 0) {
      if (!(*sp->decodepfunc)(tif, op0, rowsize))
        return 0;
      occ0 -= rowsize;
      op0 += rowsize;
    }
    return 1;
  } else
    return 0;
}

TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horDiff8(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  TIFFPredictorState *sp = PredictorState(tif);
  tmsize_t stride = sp->stride;
  unsigned char *cp = (unsigned char *)cp0;

#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", (cc % stride) != 0);
#endif

  if (cc > stride) {
    cc -= stride;
    /*
     * Pipeline the most common cases.
     */
    if (stride == 3) {
      unsigned int r1, g1, b1;
      unsigned int r2 = cp[0];
      unsigned int g2 = cp[1];
      unsigned int b2 = cp[2];
      do {
        r1 = cp[3];
        cp[3] = (unsigned char)((r1 - r2) & 0xff);
        r2 = r1;
        g1 = cp[4];
        cp[4] = (unsigned char)((g1 - g2) & 0xff);
        g2 = g1;
        b1 = cp[5];
        cp[5] = (unsigned char)((b1 - b2) & 0xff);
        b2 = b1;
        cp += 3;
      } while ((cc -= 3) > 0);
    } else if (stride == 4) {
      unsigned int r1, g1, b1, a1;
      unsigned int r2 = cp[0];
      unsigned int g2 = cp[1];
      unsigned int b2 = cp[2];
      unsigned int a2 = cp[3];
      do {
        r1 = cp[4];
        cp[4] = (unsigned char)((r1 - r2) & 0xff);
        r2 = r1;
        g1 = cp[5];
        cp[5] = (unsigned char)((g1 - g2) & 0xff);
        g2 = g1;
        b1 = cp[6];
        cp[6] = (unsigned char)((b1 - b2) & 0xff);
        b2 = b1;
        a1 = cp[7];
        cp[7] = (unsigned char)((a1 - a2) & 0xff);
        a2 = a1;
        cp += 4;
      } while ((cc -= 4) > 0);
    } else {
      cp += cc - 1;
      do {
        REPEAT4(stride,
                cp[stride] = (unsigned char)((cp[stride] - cp[0]) & 0xff);
                cp--)
      } while ((cc -= stride) > 0);
    }
  }
  return 1;
}

TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horDiff16(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  TIFFPredictorState *sp = PredictorState(tif);
  tmsize_t stride = sp->stride;
  uint16_t *wp = (uint16_t *)cp0;
  tmsize_t wc = cc / 2;

#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", (cc % (2 * stride)) != 0);
#endif

  if (wc > stride) {
    wc -= stride;
    wp += wc - 1;
    do {
      REPEAT4(stride, wp[stride] = (uint16_t)(((unsigned int)wp[stride] -
                                               (unsigned int)wp[0]) &
                                              0xffff);
              wp--)
      wc -= stride;
    } while (wc > 0);
  }
  return 1;
}

TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horDiff32(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  TIFFPredictorState *sp = PredictorState(tif);
  tmsize_t stride = sp->stride;
  uint32_t *wp = (uint32_t *)cp0;
  tmsize_t wc = cc / 4;

#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", (cc % (4 * stride)) != 0);
#endif

  if (wc > stride) {
    wc -= stride;
    wp += wc - 1;
    do {
      REPEAT4(stride, wp[stride] -= wp[0]; wp--)
      wc -= stride;
    } while (wc > 0);
  }
  return 1;
}

TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int fpDiff(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  tmsize_t stride = PredictorState(tif)->stride;
  uint32_t bps = tif->tif_dir.td_bitspersample / 8;
  tmsize_t wc = cc / bps;
  tmsize_t count;
  uint8_t *cp = (uint8_t *)cp0;
  uint8_t *tmp;

#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", (cc % (bps * stride)) != 0);
#endif

  tmp = (uint8_t *)_TIFFmalloc(cc);
  if (!tmp)
    return 0;

  _TIFFmemcpy(tmp, cp0, cc);
  for (count = 0; count < wc; count++) {
    uint32_t byte;
    for (byte = 0; byte < bps; byte++) {
#if WORDS_BIGENDIAN
      cp[byte * wc + count] = tmp[bps * count + byte];
#else
      cp[(bps - byte - 1) * wc + count] = tmp[bps * count + byte];
#endif
    }
  }
  _TIFFfree(tmp);

  cp = (uint8_t *)cp0;
  cp += cc - stride - 1;
  for (count = cc; count > stride; count -= stride)
    REPEAT4(stride, cp[stride] = (unsigned char)((cp[stride] - cp[0]) & 0xff);
            cp--)
  return 1;
}

static int PredictorEncodeTile(TIFF *tif, uint8_t *bp0, tmsize_t cc0,
                               uint16_t s) {
  static const char module[] = "PredictorEncodeTile";
  TIFFPredictorState *sp = PredictorState(tif);
  uint8_t *working_copy;
  tmsize_t cc = cc0, rowsize;
  unsigned char *bp;
  int result_code;

  assert(sp != NULL);
  assert(sp->encodepfunc != NULL);
  assert(sp->encodetile != NULL);

  /*
   * Do predictor manipulation in a working buffer to avoid altering
   * the callers buffer. http://trac.osgeo.org/gdal/ticket/1965
   */
  working_copy = (uint8_t *)_TIFFmalloc(cc0);
  if (working_copy == NULL) {
    TIFFErrorExt(tif->tif_clientdata, module,
                 "Out of memory allocating %" PRId64 " byte temp buffer.",
                 (int64_t)cc0);
    return 0;
  }
  memcpy(working_copy, bp0, cc0);
  bp = working_copy;

  rowsize = sp->rowsize;
  assert(rowsize > 0);


  while (cc > 0) {
    (*sp->encodepfunc)(tif, bp, rowsize);
    cc -= rowsize;
    bp += rowsize;
  }
  result_code = (*sp->encodetile)(tif, working_copy, cc0, s);

  _TIFFfree(working_copy);

  return result_code;
}

