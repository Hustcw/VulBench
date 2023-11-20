int __fastcall PixarLogDecode(TIFF *tif, uint8_t *op, tmsize_t occ, uint16_t s)
{
  tmsize_t v4;
  uint8_t *tif_data;
  unsigned int v8;
  signed int v9;
  int v10;
  int v11;
  uint16_t *v12;
  __int64 v13;
  tmsize_t v14;
  __int64 v15;
  thandle_t tif_clientdata;
  const char *v17;
  __int64 v19;
  thandle_t v20;
  const char *v21;
  int n;
  __int64 v23;
  __int64 v24;
  tmsize_t v25;

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
    v10 = 0;
    TIFFErrorExt(
      tif->tif_clientdata,
      "PixarLogDecode",
      "%u bit input not supported in PixarLog",
      tif->tif_dir.td_bitspersample);
    return v10;
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
    if ( 2 * v4 <= *((_QWORD *)tif_data + 30) )
    {
      while ( 1 )
      {
        v11 = inflate(tif_data + 128, 1LL);
        if ( v11 )
          break;
        if ( !*((_DWORD *)tif_data + 40) )
          goto LABEL_14;
      }
      if ( v11 == 1 )
      {
        v19 = *((unsigned int *)tif_data + 40);
        if ( (_DWORD)v19 )
        {
          v10 = 0;
          TIFFErrorExt(
            tif->tif_clientdata,
            "PixarLogDecode",
            "Not enough data at scanline %u (short %u bytes)",
            tif->tif_row,
            v19);
          return v10;
        }
LABEL_14:
        tif->tif_rawcp = (uint8_t *)*((_QWORD *)tif_data + 16);
        tif->tif_rawcc = *((unsigned int *)tif_data + 34);
        v12 = (uint16_t *)*((_QWORD *)tif_data + 31);
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
          v25 = v4;
          n = v9;
          v13 = 2LL * v9;
          v24 = 4LL * v9;
          v14 = 0LL;
          while ( 2 )
          {
            switch ( *((_DWORD *)tif_data + 66) )
            {
              case 0:
                horizontalAccumulate8(
                  v12,
                  n,
                  *((unsigned __int16 *)tif_data + 128),
                  op,
                  *((unsigned __int8 **)tif_data + 38));
                v15 = v23;
                goto LABEL_22;
              case 1:
                horizontalAccumulate8abgr(
                  v12,
                  n,
                  *((unsigned __int16 *)tif_data + 128),
                  op,
                  *((unsigned __int8 **)tif_data + 38));
                v15 = v23;
                goto LABEL_22;
              case 2:
                horizontalAccumulate11(v12, n, *((unsigned __int16 *)tif_data + 128), (uint16_t *)op);
                goto LABEL_21;
              case 3:
                horizontalAccumulate12(
                  v12,
                  n,
                  *((unsigned __int16 *)tif_data + 128),
                  (int16_t *)op,
                  *((float **)tif_data + 36));
                goto LABEL_21;
              case 4:
                horizontalAccumulate16(
                  v12,
                  n,
                  *((unsigned __int16 *)tif_data + 128),
                  (uint16_t *)op,
                  *((uint16_t **)tif_data + 37));
LABEL_21:
                v15 = v13;
                goto LABEL_22;
              case 5:
                horizontalAccumulateF(
                  v12,
                  n,
                  *((unsigned __int16 *)tif_data + 128),
                  (float *)op,
                  *((float **)tif_data + 36));
                v15 = v24;
LABEL_22:
                op += v15;
                v14 += v23;
                v12 = (uint16_t *)((char *)v12 + v13);
                if ( v14 < v25 )
                  continue;
                return 1;
              default:
                v10 = 0;
                TIFFErrorExt(
                  tif->tif_clientdata,
                  "PixarLogDecode",
                  "Unsupported bits/sample: %u",
                  tif->tif_dir.td_bitspersample);
                return v10;
            }
          }
        }
        return 1;
      }
      if ( v11 == -3 )
      {
        tif_clientdata = tif->tif_clientdata;
        v17 = "(null)";
        if ( *((_QWORD *)tif_data + 22) )
          v17 = (const char *)*((_QWORD *)tif_data + 22);
        v10 = 0;
        TIFFErrorExt(tif_clientdata, "PixarLogDecode", "Decoding error at scanline %u, %s", tif->tif_row, v17);
      }
      else
      {
        v20 = tif->tif_clientdata;
        v21 = "(null)";
        if ( *((_QWORD *)tif_data + 22) )
          v21 = (const char *)*((_QWORD *)tif_data + 22);
        v10 = 0;
        TIFFErrorExt(v20, "PixarLogDecode", "ZLib error: %s", v21);
      }
    }
    else
    {
      v10 = 0;
      TIFFErrorExt(tif->tif_clientdata, "PixarLogDecode", "sp->stream.avail_out > sp->tbuf_size");
    }
  }
  else
  {
    v10 = 0;
    TIFFErrorExt(tif->tif_clientdata, "PixarLogDecode", "ZLib cannot deal with buffers this size");
  }
  return v10;
}
