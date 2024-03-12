

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