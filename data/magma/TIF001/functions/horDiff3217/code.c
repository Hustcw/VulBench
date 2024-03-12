
TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int horDiff32(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  TIFFPredictorState *sp = PredictorState(tif);
  tmsize_t stride = sp->stride;
  uint32_t *wp = (uint32_t *)cp0;
  tmsize_t wc = cc / 4;

  if ((cc % (4 * stride)) != 0) {
    TIFFErrorExt(tif->tif_clientdata, "horDiff32", "%s", "(cc%(4*stride))!=0");
    return 0;
  }

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