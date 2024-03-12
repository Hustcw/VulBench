

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