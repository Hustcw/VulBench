TIFF_NOSANITIZE_UNSIGNED_INT_OVERFLOW
static int fpDiff(TIFF *tif, uint8_t *cp0, tmsize_t cc) {
  tmsize_t stride = PredictorState(tif)->stride;
  uint32_t bps = tif->tif_dir.td_bitspersample / 8;
  tmsize_t wc = cc / bps;
  tmsize_t count;
  uint8_t *cp = (uint8_t *)cp0;
  uint8_t *tmp;

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

