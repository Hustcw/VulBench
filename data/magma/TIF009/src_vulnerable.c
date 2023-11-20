static int TIFFWriteDirectoryTagTransferfunction(TIFF *tif, uint32_t *ndir,
                                                 TIFFDirEntry *dir) {
  static const char module[] = "TIFFWriteDirectoryTagTransferfunction";
  uint32_t m;
  uint16_t n;
  uint16_t *o;
  int p;
  if (dir == NULL) {
    (*ndir)++;
    return (1);
  }
  m = (1 << tif->tif_dir.td_bitspersample);
  n = tif->tif_dir.td_samplesperpixel - tif->tif_dir.td_extrasamples;
  /*
   * Check if the table can be written as a single column,
   * or if it must be written as 3 columns.  Note that we
   * write a 3-column tag if there are 2 samples/pixel and
   * a single column of data won't suffice--hmm.
   */
  if (n > 3)
    n = 3;
  if (n == 3) {
    if (!_TIFFmemcmp(tif->tif_dir.td_transferfunction[0],
                     tif->tif_dir.td_transferfunction[2], m * sizeof(uint16_t)))
      n = 2;
  }
  if (n == 2) {
    if (!_TIFFmemcmp(tif->tif_dir.td_transferfunction[0],
                     tif->tif_dir.td_transferfunction[1], m * sizeof(uint16_t)))
      n = 1;
  }
  if (n == 0)
    n = 1;
  o = _TIFFmalloc(n * m * sizeof(uint16_t));
  if (o == NULL) {
    TIFFErrorExt(tif->tif_clientdata, module, "Out of memory");
    return (0);
  }
  _TIFFmemcpy(&o[0], tif->tif_dir.td_transferfunction[0], m * sizeof(uint16_t));
  if (n > 1)
    _TIFFmemcpy(&o[m], tif->tif_dir.td_transferfunction[1],
                m * sizeof(uint16_t));
  if (n > 2)
    _TIFFmemcpy(&o[2 * m], tif->tif_dir.td_transferfunction[2],
                m * sizeof(uint16_t));
  p = TIFFWriteDirectoryTagCheckedShortArray(
      tif, ndir, dir, TIFFTAG_TRANSFERFUNCTION, n * m, o);
  _TIFFfree(o);
  return (p);
}

