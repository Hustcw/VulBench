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
  uint8_t *v13;
  __int64 v14;
  unsigned __int64 v15;
  __int64 v16;
  __int64 v17;
  unsigned __int64 v18;
  tmsize_t v19;
  __int64 v20;
  unsigned int v21;
  unsigned int v22;
  tmsize_t v23;
  bool v24;
  bool v25;
  unsigned __int8 v26;
  char v27;
  char v28;
  char v29;
  uint8_t v30;
  __int64 v31;
  char v32;
  uint8_t *v35;

  v4 = occ;
  v5 = buf;
  if ( occ > 0 )
    memset(buf, 255, occ);
  tif_scanlinesize = tif->tif_scanlinesize;
  if ( v4 % tif_scanlinesize )
  {
    v7 = 0;
    TIFFErrorExt(tif->tif_clientdata, "NeXTDecode", "Fractional scanlines cannot be read", s);
    return v7;
  }
  tif_rawcp = tif->tif_rawcp;
  tif_rawcc = tif->tif_rawcc;
  if ( tif_rawcc <= 0 || v4 <= 0 )
    goto LABEL_38;
  while ( 1 )
  {
    v10 = tif_rawcp + 1;
    v11 = *tif_rawcp;
    v12 = tif_rawcc - 1;
    if ( *tif_rawcp != 64 )
      break;
    if ( tif_rawcc < 5
      || (v15 = (unsigned __int64)tif_rawcp[3] << 8, v16 = tif_rawcp[4], v17 = v15 + v16 + 4, tif_rawcc <= v17)
      || (v18 = ((unsigned __int64)tif_rawcp[1] << 8) | tif_rawcp[2],
          v19 = v16 | v15,
          (__int64)(v19 + v18) > tif_scanlinesize) )
    {
bad:
      v7 = 0;
      TIFFErrorExt(tif->tif_clientdata, "NeXTDecode", "Not enough data for scanline %u", tif->tif_row);
      return v7;
    }
    TIFFmemcpy(&v5[v18], tif_rawcp + 5, v19);
    v13 = &v10[v17];
    v14 = v12 - v17;
LABEL_15:
    tif_rawcc = v14;
    tif_rawcp = v13;
    if ( v14 <= 0 )
      goto LABEL_38;
LABEL_16:
    v4 -= tif_scanlinesize;
    v5 += tif_scanlinesize;
    if ( v4 <= 0 )
      goto LABEL_38;
  }
  if ( !v11 )
  {
    if ( tif_rawcc <= tif_scanlinesize )
      goto bad;
    TIFFmemcpy(v5, tif_rawcp + 1, tif_scanlinesize);
    v13 = &v10[tif_scanlinesize];
    v14 = v12 - tif_scanlinesize;
    goto LABEL_15;
  }
  v20 = 100LL;
  if ( (tif->tif_flags & 0x400) == 0 )
    v20 = 88LL;
  v21 = *(_DWORD *)((char *)&tif->tif_name + v20);
  v22 = 0;
  v35 = v5;
  v23 = 0LL;
  while ( 1 )
  {
    v24 = v22 < v21;
    v25 = v23 < tif_scanlinesize;
    v26 = v11 & 0x3F;
    if ( (v11 & 0x3F) != 0 && v22 < v21 && v23 < tif_scanlinesize )
    {
      v27 = v11 >> 6;
      v28 = 4 * (v11 >> 6);
      v29 = 16 * (v11 >> 6);
      v30 = v11 & 0xC0;
      v31 = v26 - 1LL;
      do
      {
        v32 = v22++;
        switch ( v32 & 3 )
        {
          case 0:
            *v5 = v30;
            break;
          case 1:
            *v5 |= v29;
            break;
          case 2:
            *v5 |= v28;
            break;
          case 3:
            *v5++ |= v27;
            ++v23;
            break;
        }
        v24 = v22 < v21;
        v25 = v23 < tif_scanlinesize;
        if ( v31 <= 0 )
          break;
        if ( v22 >= v21 )
          break;
        --v31;
      }
      while ( v23 < tif_scanlinesize );
    }
    if ( !v24 )
      break;
    if ( !v25 )
    {
      v7 = 0;
      TIFFErrorExt(tif->tif_clientdata, "NeXTDecode", "Invalid data for scanline %u", tif->tif_row);
      return v7;
    }
    if ( !v12 )
      goto bad;
    v11 = *v10++;
    --v12;
  }
  tif_rawcc = v12;
  tif_rawcp = v10;
  v5 = v35;
  if ( v12 > 0 )
    goto LABEL_16;
LABEL_38:
  tif->tif_rawcp = tif_rawcp;
  tif->tif_rawcc = tif_rawcc;
  return 1;
}
