int __fastcall PredictorEncodeTile(TIFF *tif, uint8_t *bp0, tmsize_t cc0, uint16_t s)
{
  uint8_t *tif_data;
  char *v7;
  char *v8;
  __int64 v9;
  char *v10;
  __int64 v11;
  bool v12;
  int v13;
  uint16_t v15;
  tmsize_t v16;

  tif_data = tif->tif_data;
  if ( !tif_data )
    __assert_fail(
      "sp != NULL",
      "tif_predict.c",
      0x2F7u,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  if ( !*((_QWORD *)tif_data + 6) )
    __assert_fail(
      "sp->encodepfunc != NULL",
      "tif_predict.c",
      0x2F8u,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  if ( !*((_QWORD *)tif_data + 5) )
    __assert_fail(
      "sp->encodetile != NULL",
      "tif_predict.c",
      0x2F9u,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v7 = (char *)TIFFmalloc(cc0);
  if ( v7 )
  {
    v8 = v7;
    v15 = s;
    memcpy(v7, bp0, cc0);
    v9 = *((_QWORD *)tif_data + 2);
    if ( v9 <= 0 )
      __assert_fail(
        "rowsize > 0",
        "tif_predict.c",
        0x30Bu,
        "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    v16 = cc0;
    if ( cc0 > 0 )
    {
      v10 = v8;
      v11 = v16;
      do
      {
        (*((void (__fastcall **)(TIFF *, char *, __int64))tif_data + 6))(tif, v10, v9);
        v10 += v9;
        v12 = v11 <= v9;
        v11 -= v9;
      }
      while ( !v12 );
    }
    v13 = (*((__int64 (__fastcall **)(TIFF *, char *, tmsize_t, _QWORD))tif_data + 5))(tif, v8, v16, v15);
    TIFFfree(v8);
    return v13;
  }
  else
  {
    TIFFErrorExt(tif->tif_clientdata, "PredictorEncodeTile", "Out of memory allocating %ld byte temp buffer.", cc0);
    return 0;
  }
}
