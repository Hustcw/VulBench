tmsize_t __fastcall TIFFReadEncodedStripGetStripSize(TIFF *tif, uint32_t strip, uint16_t *pplane)
{
  __int64 td_nstrips;
  uint32_t td_imagelength;
  uint32_t td_rowsperstrip;
  unsigned int v9;
  uint32_t v10;
  tmsize_t v11;

  if ( !TIFFCheckRead(tif, 0) )
    return -1LL;
  td_nstrips = tif->tif_dir.td_nstrips;
  if ( (unsigned int)td_nstrips <= strip )
  {
    TIFFErrorExt(tif->tif_clientdata, "TIFFReadEncodedStrip", "%u: Strip out of range, max %u", strip, td_nstrips);
    return -1LL;
  }
  td_imagelength = tif->tif_dir.td_imagelength;
  td_rowsperstrip = tif->tif_dir.td_rowsperstrip;
  if ( td_rowsperstrip > td_imagelength )
    td_rowsperstrip = td_imagelength;
  v9 = td_imagelength / td_rowsperstrip - ((td_imagelength % td_rowsperstrip == 0) - 1);
  if ( pplane )
    *pplane = strip / v9;
  v10 = td_imagelength - td_rowsperstrip * (strip % v9);
  if ( v10 > td_rowsperstrip )
    v10 = td_rowsperstrip;
  v11 = TIFFVStripSize(tif, v10);
  return -(__int64)(v11 == 0) | v11;
}
