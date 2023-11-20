int __fastcall PixarLogDecode(TIFF *tif, uint8_t *op, tmsize_t occ, uint16_t s)
{
  tmsize_t v4;
  uint8_t *tif_data;
  unsigned int v8;
  signed int v9;
  int v10;
  uint16_t *v11;
  __int64 v12;
  tmsize_t v13;
  int v14;
  __int64 v15;
  thandle_t tif_clientdata;
  const char *v17;
  __int64 v18;
  thandle_t v19;
  const char *v20;
  int n;
  __int64 v23;

  v4 = occ;
  tif_data = tif->tif_data;
  v8 = *((_DWORD *)tif_data + 66);
  if ( v8 - 2 < 3 )
  {
    v4 = (unsigned __int64)occ >> 1;
LABEL_7:
    if ( !tif_data )
LABEL_5:
      __assert_fail("sp != NULL", "tif_pixarlog.c", 0x311u, "int PixarLogDecode(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    goto LABEL_8;
  }
  if ( v8 < 2 )
    goto LABEL_7;
  if ( v8 != 5 )
  {
    v14 = 0;
    TIFFErrorExt(
      tif->tif_clientdata,
      "PixarLogDecode",
      "%u bit input not supported in PixarLog",
      tif->tif_dir.td_bitspersample);
    return v14;
  }
  v4 = (unsigned __int64)occ >> 2;
  if ( !tif_data )
    goto LABEL_5;
LABEL_8:
  v9 = tif->tif_dir.td_imagewidth * *((unsigned __int16 *)tif_data + 128);
  *((_QWORD *)tif_data + 16) = tif->tif_rawcp;
  *((_DWORD *)tif_data + 34) = tif->tif_rawcc;
  *((_QWORD *)tif_data + 19) = *((_QWORD *)tif_data + 31);
  *((_DWORD *)tif_data + 40) = 2 * v4;
  if ( 2 * (_DWORD)v4 == 2 * v4 )
  {
    while ( 1 )
    {
      v10 = inflate(tif_data + 128, 1LL);
      if ( v10 )
        break;
      if ( !*((_DWORD *)tif_data + 40) )
        goto LABEL_11;
    }
    if ( v10 == 1 )
    {
      v18 = *((unsigned int *)tif_data + 40);
      if ( (_DWORD)v18 )
      {
        v14 = 0;
        TIFFErrorExt(
          tif->tif_clientdata,
          "PixarLogDecode",
          "Not enough data at scanline %u (short %u bytes)",
          tif->tif_row,
          v18);
        return v14;
      }
LABEL_11:
      tif->tif_rawcp = (uint8_t *)*((_QWORD *)tif_data + 16);
      tif->tif_rawcc = *((unsigned int *)tif_data + 34);
      v11 = (uint16_t *)*((_QWORD *)tif_data + 31);
      if ( SLOBYTE(tif->tif_flags) < 0 )
        TIFFSwabArrayOfShort(*((uint16_t **)tif_data + 31), v4);
      v23 = v9;
      if ( v4 % v9 )
      {
        TIFFWarningExt(
          tif->tif_clientdata,
          "PixarLogDecode",
          "stride %d is not a multiple of sample count, %ld, data truncated.",
          (unsigned int)v9,
          v4);
        v4 -= v4 % v9;
      }
      if ( v4 > 0 )
      {
        n = v9;
        v12 = 2LL * v9;
        v13 = 0LL;
        while ( 2 )
        {
          switch ( *((_DWORD *)tif_data + 66) )
          {
            case 0:
              horizontalAccumulate8(
                v11,
                n,
                *((unsigned __int16 *)tif_data + 128),
                op,
                *((unsigned __int8 **)tif_data + 38));
              v15 = v23;
              goto LABEL_20;
            case 1:
              horizontalAccumulate8abgr(
                v11,
                n,
                *((unsigned __int16 *)tif_data + 128),
                op,
                *((unsigned __int8 **)tif_data + 38));
              v15 = v23;
              goto LABEL_20;
            case 2:
              horizontalAccumulate11(v11, n, *((unsigned __int16 *)tif_data + 128), (uint16_t *)op);
              goto LABEL_19;
            case 3:
              horizontalAccumulate12(
                v11,
                n,
                *((unsigned __int16 *)tif_data + 128),
                (int16_t *)op,
                *((float **)tif_data + 36));
              goto LABEL_19;
            case 4:
              horizontalAccumulate16(
                v11,
                n,
                *((unsigned __int16 *)tif_data + 128),
                (uint16_t *)op,
                *((uint16_t **)tif_data + 37));
LABEL_19:
              v15 = v12;
              goto LABEL_20;
            case 5:
              horizontalAccumulateF(
                v11,
                n,
                *((unsigned __int16 *)tif_data + 128),
                (float *)op,
                *((float **)tif_data + 36));
              v15 = 4 * v23;
LABEL_20:
              op += v15;
              v13 += v23;
              v11 = (uint16_t *)((char *)v11 + v12);
              if ( v13 < v4 )
                continue;
              return 1;
            default:
              v14 = 0;
              TIFFErrorExt(
                tif->tif_clientdata,
                "PixarLogDecode",
                "Unsupported bits/sample: %u",
                tif->tif_dir.td_bitspersample);
              return v14;
          }
        }
      }
      return 1;
    }
    if ( v10 == -3 )
    {
      tif_clientdata = tif->tif_clientdata;
      v17 = "(null)";
      if ( *((_QWORD *)tif_data + 22) )
        v17 = (const char *)*((_QWORD *)tif_data + 22);
      v14 = 0;
      TIFFErrorExt(tif_clientdata, "PixarLogDecode", "Decoding error at scanline %u, %s", tif->tif_row, v17);
    }
    else
    {
      v19 = tif->tif_clientdata;
      v20 = "(null)";
      if ( *((_QWORD *)tif_data + 22) )
        v20 = (const char *)*((_QWORD *)tif_data + 22);
      v14 = 0;
      TIFFErrorExt(v19, "PixarLogDecode", "ZLib error: %s", v20);
    }
  }
  else
  {
    v14 = 0;
    TIFFErrorExt(tif->tif_clientdata, "PixarLogDecode", "ZLib cannot deal with buffers this size");
  }
  return v14;
}
