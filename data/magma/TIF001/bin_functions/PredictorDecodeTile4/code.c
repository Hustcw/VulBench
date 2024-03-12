int __fastcall PredictorDecodeTile(TIFF *tif, uint8_t *op0, tmsize_t occ0, uint16_t s)
{
  uint8_t *tif_data;
  unsigned int (__fastcall *v5)(TIFF *, uint8_t *, tmsize_t, _QWORD);
  tmsize_t v6;
  int v7;
  __int64 v8;
  unsigned int (__fastcall *v9)(TIFF *, uint8_t *, _QWORD);
  uint8_t *v10;
  bool v11;
  uint8_t *v12;

  tif_data = tif->tif_data;
  if ( !tif_data )
    __assert_fail(
      "sp != NULL",
      "tif_predict.c",
      0x1F7u,
      "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v5 = (unsigned int (__fastcall *)(TIFF *, uint8_t *, tmsize_t, _QWORD))*((_QWORD *)tif_data + 9);
  if ( !v5 )
    __assert_fail(
      "sp->decodetile != NULL",
      "tif_predict.c",
      0x1F8u,
      "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v6 = occ0;
  v7 = 0;
  if ( v5(tif, op0, occ0, s) )
  {
    v8 = *((_QWORD *)tif_data + 2);
    if ( v8 <= 0 )
      __assert_fail(
        "rowsize > 0",
        "tif_predict.c",
        0x1FCu,
        "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    v9 = (unsigned int (__fastcall *)(TIFF *, uint8_t *, _QWORD))*((_QWORD *)tif_data + 10);
    if ( !v9 )
      __assert_fail(
        "sp->decodepfunc != NULL",
        "tif_predict.c",
        0x20Au,
        "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    if ( v6 <= 0 )
      return 1;
    if ( v9(tif, op0, *((_QWORD *)tif_data + 2)) )
    {
      v10 = &op0[v8];
      while ( 1 )
      {
        v11 = v6 <= v8;
        v6 -= v8;
        if ( v11 )
          break;
        v12 = v10;
        v10 += v8;
        if ( !(*((unsigned int (__fastcall **)(TIFF *, uint8_t *, __int64))tif_data + 10))(tif, v12, v8) )
          return v7;
      }
      return 1;
    }
  }
  return v7;
}
