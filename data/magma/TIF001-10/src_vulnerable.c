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

