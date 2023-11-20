static int JBIGDecode(TIFF *tif, uint8_t *buffer, tmsize_t size, uint16_t s) {
  struct jbg_dec_state decoder;
  int decodeStatus = 0;
  unsigned char *pImage = NULL;
  unsigned long decodedSize;
  (void)s;

  if (isFillOrder(tif, tif->tif_dir.td_fillorder)) {
    TIFFReverseBits(tif->tif_rawcp, tif->tif_rawcc);
  }

  jbg_dec_init(&decoder);

#if defined(HAVE_JBG_NEWLEN)
  jbg_newlen(tif->tif_rawcp, (size_t)tif->tif_rawcc);
  /*
   * I do not check the return status of jbg_newlen because even if this
   * function fails it does not necessarily mean that decoding the image
   * will fail.  It is generally only needed for received fax images
   * that do not contain the actual length of the image in the BIE
   * header.  I do not log when an error occurs because that will cause
   * problems when converting JBIG encoded TIFF's to
   * PostScript.  As long as the actual image length is contained in the
   * BIE header jbg_dec_in should succeed.
   */
#endif /* HAVE_JBG_NEWLEN */

  decodeStatus = jbg_dec_in(&decoder, (unsigned char *)tif->tif_rawcp,
                            (size_t)tif->tif_rawcc, NULL);
  if (JBG_EOK != decodeStatus) {
    /*
     * XXX: JBG_EN constant was defined in pre-2.0 releases of the
     * JBIG-KIT. Since the 2.0 the error reporting functions were
     * changed. We will handle both cases here.
     */
    TIFFErrorExt(tif->tif_clientdata, "JBIG", "Error (%d) decoding: %s",
                 decodeStatus,
#if defined(JBG_EN)
                 jbg_strerror(decodeStatus, JBG_EN)
#else
                 jbg_strerror(decodeStatus)
#endif
    );
    jbg_dec_free(&decoder);
    return 0;
  }

  decodedSize = jbg_dec_getsize(&decoder);
  if ((tmsize_t)decodedSize < size) {
    TIFFWarningExt(tif->tif_clientdata, "JBIG",
                   "Only decoded %lu bytes, whereas %" TIFF_SSIZE_FORMAT
                   " requested",
                   decodedSize, size);
  } else if ((tmsize_t)decodedSize > size) {
    TIFFWarningExt(tif->tif_clientdata, "JBIG",
                   "Decoded %lu bytes, whereas %lu were requested", decodedSize,
                   (unsigned long)size);
  }
  pImage = jbg_dec_getimage(&decoder, 0);
  _TIFFmemcpy(buffer, pImage, decodedSize);
  jbg_dec_free(&decoder);

  tif->tif_rawcp += tif->tif_rawcc;
  tif->tif_rawcc = 0;

  return 1;
}

