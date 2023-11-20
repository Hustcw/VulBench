int __fastcall TIFFWriteDirectoryTagTransferfunction(TIFF *tif, uint32_t *ndir, TIFFDirEntry *dir)
{
  uint16_t td_bitspersample;
  unsigned __int16 v5;
  unsigned __int16 v6;
  uint16_t *v7;
  int v8;
  int v9;
  uint16_t *v10;
  __int64 v11;
  uint16_t *v12;
  uint16_t *v13;
  tmsize_t v14;
  int v15;
  unsigned int v17;

  if ( !dir )
  {
    ++*ndir;
    return 1;
  }
  td_bitspersample = tif->tif_dir.td_bitspersample;
  v17 = 1 << td_bitspersample;
  v5 = tif->tif_dir.td_samplesperpixel - tif->tif_dir.td_extrasamples;
  v6 = 3;
  if ( v5 < 3u )
    v6 = tif->tif_dir.td_samplesperpixel - tif->tif_dir.td_extrasamples;
  if ( v5 < 3u )
  {
    if ( !v6 )
    {
LABEL_15:
      v6 = 1;
      goto LABEL_16;
    }
    if ( v6 != 2 )
      goto LABEL_16;
  }
  else
  {
    v7 = tif->tif_dir.td_transferfunction[2];
    if ( v7 )
    {
      v8 = TIFFmemcmp(tif->tif_dir.td_transferfunction[0], v7, 2LL * v17);
      if ( v6 != 2 )
      {
        if ( v8 )
        {
          if ( v6 )
            goto LABEL_16;
          goto LABEL_15;
        }
      }
    }
  }
  v10 = tif->tif_dir.td_transferfunction[1];
  if ( !v10 )
    goto LABEL_15;
  v6 = 2;
  if ( !TIFFmemcmp(tif->tif_dir.td_transferfunction[0], v10, 2LL * v17) )
    goto LABEL_15;
LABEL_16:
  v11 = v6 << td_bitspersample;
  v12 = (uint16_t *)TIFFmalloc(2 * v11);
  if ( !v12 )
  {
    v9 = 0;
    TIFFErrorExt(tif->tif_clientdata, "TIFFWriteDirectoryTagTransferfunction", "Out of memory");
    return v9;
  }
  v13 = v12;
  v14 = 2LL * v17;
  TIFFmemcpy(v12, tif->tif_dir.td_transferfunction[0], v14);
  if ( v6 >= 2u )
  {
    TIFFmemcpy(&v13[v17], tif->tif_dir.td_transferfunction[1], v14);
    if ( v6 != 2 )
      TIFFmemcpy(&v13[2 * v17], tif->tif_dir.td_transferfunction[2], v14);
  }
  v15 = TIFFWriteDirectoryTagCheckedShortArray(tif, ndir, dir, 0x12Du, v11, v13);
  TIFFfree(v13);
  return v15;
}
