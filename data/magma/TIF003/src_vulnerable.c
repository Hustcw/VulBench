static tmsize_t TIFFReadEncodedStripGetStripSize(TIFF *tif, uint32_t strip,
                                                 uint16_t *pplane) {
  static const char module[] = "TIFFReadEncodedStrip";
  TIFFDirectory *td = &tif->tif_dir;
  uint32_t rowsperstrip;
  uint32_t stripsperplane;
  uint32_t stripinplane;
  uint32_t rows;
  tmsize_t stripsize;
  if (!TIFFCheckRead(tif, 0))
    return ((tmsize_t)(-1));
  if (strip >= td->td_nstrips) {
    TIFFErrorExt(tif->tif_clientdata, module,
                 "%" PRIu32 ": Strip out of range, max %" PRIu32, strip,
                 td->td_nstrips);
    return ((tmsize_t)(-1));
  }

  rowsperstrip = td->td_rowsperstrip;
  if (rowsperstrip > td->td_imagelength)
    rowsperstrip = td->td_imagelength;
  stripsperplane = ((td->td_imagelength + rowsperstrip - 1) / rowsperstrip);
  stripinplane = (strip % stripsperplane);
  if (pplane)
    *pplane = (uint16_t)(strip / stripsperplane);
  rows = td->td_imagelength - stripinplane * rowsperstrip;
  if (rows > rowsperstrip)
    rows = rowsperstrip;
  stripsize = TIFFVStripSize(tif, rows);
  if (stripsize == 0)
    return ((tmsize_t)(-1));
  return stripsize;
}

