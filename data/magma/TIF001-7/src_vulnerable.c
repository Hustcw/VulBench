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

