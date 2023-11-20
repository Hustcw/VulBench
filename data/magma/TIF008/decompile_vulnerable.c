int __fastcall NeXTDecode(TIFF *tif, uint8_t *buf, tmsize_t occ, uint16_t s)
{
  tmsize_t v4;
  uint8_t *v5;
  tmsize_t tif_scanlinesize;
  int v7;
  uint8_t *tif_rawcp;
  __int64 tif_rawcc;
  uint8_t *v10;
  uint8_t v11;
  __int64 v12;
  unsigned __int64 v13;
  __int64 v14;
  __int64 v15;
  unsigned __int64 v16;
  tmsize_t v17;
  __int64 v18;
  unsigned int v19;
  unsigned int v20;
  uint8_t *i;
  unsigned __int8 v22;
  char v23;
  char v24;
  char v25;
  uint8_t v26;
  __int64 v27;
  uint8_t *v28;
  char v29;
  char v30;
  uint8_t v31;
  tmsize_t c;
  uint8_t *d;

  v4 = occ;
  v5 = buf;
  if ( occ > 0 )
    memset(buf, 255, occ);
  tif_scanlinesize = tif->tif_scanlinesize;
  if ( !(v4 % tif_scanlinesize) )
  {
    tif_rawcp = tif->tif_rawcp;
    tif_rawcc = tif->tif_rawcc;
    if ( tif_rawcc <= 0 || v4 <= 0 )
    {
LABEL_36:
      tif->tif_rawcp = tif_rawcp;
      tif->tif_rawcc = tif_rawcc;
      return 1;
    }
    c = tif->tif_scanlinesize;
    while ( 1 )
    {
      d = v5;
      v10 = tif_rawcp + 1;
      v11 = *tif_rawcp;
      v12 = tif_rawcc - 1;
      if ( *tif_rawcp == 64 )
        break;
      if ( v11 )
      {
        v18 = 100LL;
        if ( (tif->tif_flags & 0x400) == 0 )
          v18 = 88LL;
        v19 = *(_DWORD *)((char *)&tif->tif_name + v18);
        v20 = 0;
        for ( i = v5; ; i = v28 )
        {
          v22 = v11 & 0x3F;
          if ( (v11 & 0x3F) != 0 && v20 < v19 )
          {
            v23 = v11 >> 6;
            v24 = 4 * (v11 >> 6);
            v25 = 16 * (v11 >> 6);
            v26 = v11 & 0xC0;
            v27 = v22 - 1LL;
            v28 = i;
            while ( 2 )
            {
              v29 = v20++;
              v30 = v25;
              v31 = v26;
              switch ( v29 & 3 )
              {
                case 0:
                  goto LABEL_29;
                case 1:
                  goto LABEL_28;
                case 2:
                  v30 = v24;
                  v28 = i;
                  goto LABEL_28;
                case 3:
                  v28 = i + 1;
                  v30 = v23;
LABEL_28:
                  v31 = *i | v30;
LABEL_29:
                  *i = v31;
                  if ( v27 > 0 )
                  {
                    --v27;
                    i = v28;
                    if ( v20 < v19 )
                      continue;
                  }
                  if ( v20 < v19 )
                    goto LABEL_32;
                  goto LABEL_8;
              }
            }
          }
          v28 = i;
          if ( v20 >= v19 )
            break;
LABEL_32:
          if ( !v12 )
            goto bad;
          v11 = *v10++;
          --v12;
        }
LABEL_8:
        tif_rawcc = v12;
        tif_rawcp = v10;
        tif_scanlinesize = c;
        if ( v12 <= 0 )
          goto LABEL_36;
        goto LABEL_9;
      }
      if ( tif_rawcc <= tif_scanlinesize )
        goto bad;
      TIFFmemcpy(v5, tif_rawcp + 1, c);
      tif_scanlinesize = c;
      tif_rawcc = v12 - c;
      tif_rawcp = &v10[c];
      if ( v12 - c <= 0 )
        goto LABEL_36;
LABEL_9:
      v4 -= tif_scanlinesize;
      v5 = &d[tif_scanlinesize];
      if ( v4 <= 0 )
        goto LABEL_36;
    }
    if ( tif_rawcc < 5
      || (v13 = (unsigned __int64)tif_rawcp[3] << 8, v14 = tif_rawcp[4], v15 = v13 + v14 + 4, tif_rawcc <= v15)
      || (v16 = ((unsigned __int64)tif_rawcp[1] << 8) | tif_rawcp[2], v17 = v14 | v13, (__int64)(v17 + v16) > c) )
    {
bad:
      v7 = 0;
      TIFFErrorExt(tif->tif_clientdata, "NeXTDecode", "Not enough data for scanline %u", tif->tif_row);
      return v7;
    }
    TIFFmemcpy(&v5[v16], tif_rawcp + 5, v17);
    v10 += v15;
    v12 -= v15;
    goto LABEL_8;
  }
  v7 = 0;
  TIFFErrorExt(tif->tif_clientdata, "NeXTDecode", "Fractional scanlines cannot be read");
  return v7;
}
