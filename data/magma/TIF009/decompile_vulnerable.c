int __fastcall TIFFWriteDirectoryTagTransferfunction(TIFF *tif, uint32_t *ndir, TIFFDirEntry *dir)
{
  uint16_t td_bitspersample;
  unsigned int v4;
  unsigned __int16 v5;
  __int16 v6;
  tmsize_t v7;
  int v8;
  int v9;
  unsigned __int16 v10;
  __int64 v11;
  uint16_t *v12;
  uint16_t *v13;
  int v14;
  __int64 c;

  if ( !dir )
  {
    ++*ndir;
    return 1;
  }
  td_bitspersample = tif->tif_dir.td_bitspersample;
  v4 = 1 << td_bitspersample;
  v5 = tif->tif_dir.td_samplesperpixel - tif->tif_dir.td_extrasamples;
  v6 = 3;
  if ( v5 < 3u )
    v6 = tif->tif_dir.td_samplesperpixel - tif->tif_dir.td_extrasamples;
  if ( v5 < 3u )
  {
    if ( v6 != 2 )
      goto LABEL_12;
    v7 = 2LL * v4;
    goto LABEL_11;
  }
  v7 = 2LL * v4;
  v8 = TIFFmemcmp(tif->tif_dir.td_transferfunction[0], tif->tif_dir.td_transferfunction[2], v7);
  if ( v6 == 2 || !v8 )
LABEL_11:
    v6 = 2 - (TIFFmemcmp(tif->tif_dir.td_transferfunction[0], tif->tif_dir.td_transferfunction[1], v7) == 0);
LABEL_12:
  v10 = 1;
  if ( v6 )
    v10 = v6;
  v11 = v10 << td_bitspersample;
  v12 = (uint16_t *)TIFFmalloc(2 * v11);
  if ( !v12 )
  {
    v9 = 0;
    TIFFErrorExt(tif->tif_clientdata, "TIFFWriteDirectoryTagTransferfunction", "Out of memory");
    return v9;
  }
  v13 = v12;
  c = 2LL * v4;
  TIFFmemcpy(v12, tif->tif_dir.td_transferfunction[0], c);
  if ( v10 >= 2u )
  {
    TIFFmemcpy(&v13[v4], tif->tif_dir.td_transferfunction[1], c);
    if ( v10 != 2 )
      TIFFmemcpy(&v13[2 * v4], tif->tif_dir.td_transferfunction[2], c);
  }
  v14 = TIFFWriteDirectoryTagCheckedShortArray(tif, ndir, dir, 0x12Du, v11, v13);
  TIFFfree(v13);
  return v14;
}
