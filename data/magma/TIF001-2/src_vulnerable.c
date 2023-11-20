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

