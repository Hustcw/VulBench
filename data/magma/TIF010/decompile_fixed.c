int __fastcall LZWDecodeCompat(TIFF *tif, uint8_t *op0, tmsize_t occ0, uint16_t s)
{
  uint8_t *tif_data;
  TIFF *v6;
  __int64 v7;
  _QWORD *******v8;
  __int64 v9;
  tmsize_t v10;
  __int64 v11;
  char v12;
  unsigned __int64 v13;
  __int64 v14;
  __int64 i;
  unsigned __int64 v16;
  tmsize_t v17;
  uint8_t *v18;
  int v19;
  tmsize_t v20;
  __int64 v21;
  _QWORD **************v22;
  __int64 *v23;
  __int64 v24;
  uint8_t *v25;
  unsigned __int64 v26;
  __int64 v28;
  uint8_t *v29;
  tmsize_t v30;
  tmsize_t v31;
  __int64 v32;
  _QWORD **************v33;
  __int64 *v34;
  __int64 v35;
  uint8_t *tif_rawcp;
  unsigned __int64 v37;
  __int64 v38;
  __int64 v39;
  __int64 v40;
  __int64 v41;
  __int64 v42;
  unsigned __int64 v43;
  unsigned __int64 v44;
  unsigned __int64 v45;
  thandle_t v46;
  __int64 tif_curstrip;
  unsigned __int64 v48;
  signed __int64 v49;
  unsigned __int64 v50;
  __int64 v51;
  __int16 v52;
  unsigned int v53;
  unsigned __int64 v54;
  __int64 v55;
  _BYTE *v56;
  int v57;
  __int64 v58;
  tmsize_t v59;
  uint8_t *v60;
  uint8_t *v61;
  __int64 v62;
  uint8_t *v63;
  __int64 v64;
  unsigned __int64 v65;
  signed __int64 v66;
  __int64 v67;
  unsigned int v68;
  unsigned __int64 v69;
  tmsize_t v70;
  thandle_t tif_clientdata;
  __int64 tif_row;
  __int64 v74;
  unsigned __int64 v75;
  tmsize_t v76;
  uint8_t *v77;
  tmsize_t v78;
  __int64 v79;
  __int64 **v80;
  __int64 *v81;
  __int64 v82;
  __int16 v83;
  int v84;
  TIFF *v85;
  __int64 v86;
  __int64 v87;
  uint8_t *v88;
  unsigned __int64 v89;
  unsigned __int64 v90;
  uint8_t *v91;

  tif_data = tif->tif_data;
  if ( !tif_data )
    __assert_fail("sp != NULL", "tif_lzw.c", 0x25Au, "int LZWDecodeCompat(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v6 = tif;
  v7 = *((_QWORD *)tif_data + 21);
  if ( v7 )
  {
    v8 = (_QWORD *******)*((_QWORD *)tif_data + 25);
    v9 = *((unsigned __int16 *)v8 + 4);
    v10 = v9 - v7;
    if ( v9 - v7 > occ0 )
    {
      *((_QWORD *)tif_data + 21) = v7 + occ0;
      v11 = v9 - v7;
      v12 = v9 - v7 - occ0;
      v13 = v9 + ~v7 - occ0;
      v14 = v12 & 7;
      if ( v14 )
      {
        for ( i = 0LL; i != v14; ++i )
          v8 = (_QWORD *******)*v8;
        v10 = v11 - i;
      }
      if ( v13 >= 7 )
      {
        do
        {
          v8 = *(_QWORD ********)*******v8;
          v10 -= 8LL;
        }
        while ( v10 > occ0 );
      }
      v16 = occ0 - 1;
      v17 = occ0 & 3;
      if ( (occ0 & 3) != 0 )
      {
        do
        {
          op0[occ0 - 1] = *((_BYTE *)v8 + 10);
          v8 = (_QWORD *******)*v8;
          --occ0;
          --v17;
        }
        while ( v17 );
      }
      v18 = &op0[occ0];
      v19 = 1;
      if ( v16 >= 3 )
      {
        v20 = -occ0;
        v21 = 0LL;
        do
        {
          v18[v21 - 1] = *((_BYTE *)v8 + 10);
          v22 = (_QWORD **************)*v8;
          v18[v21 - 2] = *((_BYTE *)v22 + 10);
          v23 = (__int64 *)*v22;
          v18[v21 - 3] = *((_BYTE *)v23 + 10);
          v24 = *v23;
          v18[v21 - 4] = *(_BYTE *)(v24 + 10);
          v8 = *(_QWORD ********)v24;
          v21 -= 4LL;
        }
        while ( v20 != v21 );
      }
      return v19;
    }
    v25 = tif->tif_data;
    op0 += v10;
    v26 = v9 + ~v7;
    if ( (v10 & 3) != 0 )
    {
      v28 = 0LL;
      v29 = op0;
      do
      {
        *--v29 = *((_BYTE *)v8 + 10);
        v8 = (_QWORD *******)*v8;
        ++v28;
      }
      while ( (v10 & 3) != v28 );
      v30 = v10 - v28;
      v6 = tif;
      if ( v26 < 3 )
        goto LABEL_24;
    }
    else
    {
      v29 = op0;
      v30 = v10;
      if ( v26 < 3 )
      {
LABEL_24:
        occ0 -= v10;
        tif_data = v25;
        *((_QWORD *)v25 + 21) = 0LL;
        goto LABEL_25;
      }
    }
    v31 = -v30;
    v32 = 0LL;
    do
    {
      v29[v32 - 1] = *((_BYTE *)v8 + 10);
      v33 = (_QWORD **************)*v8;
      v29[v32 - 2] = *((_BYTE *)v33 + 10);
      v34 = (__int64 *)*v33;
      v29[v32 - 3] = *((_BYTE *)v34 + 10);
      v35 = *v34;
      v29[v32 - 4] = *(_BYTE *)(v35 + 10);
      v8 = *(_QWORD ********)v35;
      v32 -= 4LL;
    }
    while ( v31 != v32 );
    goto LABEL_24;
  }
LABEL_25:
  tif_rawcp = v6->tif_rawcp;
  v37 = *((_QWORD *)tif_data + 22) + 8 * (v6->tif_rawcc - *((_QWORD *)tif_data + 23));
  *((_QWORD *)tif_data + 22) = v37;
  LODWORD(v38) = *((unsigned __int16 *)tif_data + 64);
  v39 = *((_QWORD *)tif_data + 17);
  v40 = *((_QWORD *)tif_data + 18);
  v41 = *((_QWORD *)tif_data + 20);
  v42 = *((_QWORD *)tif_data + 26);
  v43 = *((_QWORD *)tif_data + 27);
  v44 = *((_QWORD *)tif_data + 28);
  if ( occ0 <= 0 )
  {
LABEL_68:
    v70 = v6->tif_rawcc + v6->tif_rawcp - tif_rawcp;
    v6->tif_rawcc = v70;
    v6->tif_rawcp = tif_rawcp;
    *((_QWORD *)tif_data + 23) = v70;
    *((_WORD *)tif_data + 64) = v38;
    *((_QWORD *)tif_data + 17) = v39;
    *((_QWORD *)tif_data + 18) = v40;
    *((_QWORD *)tif_data + 20) = v41;
    *((_QWORD *)tif_data + 26) = v42;
    *((_QWORD *)tif_data + 27) = v43;
    *((_QWORD *)tif_data + 28) = v44;
    if ( occ0 <= 0 )
      return 1;
    tif_clientdata = v6->tif_clientdata;
    tif_row = v6->tif_row;
    v19 = 0;
    TIFFErrorExt(tif_clientdata, "LZWDecodeCompat", "Not enough data at scanline %u (short %ld bytes)", tif_row, occ0);
    return v19;
  }
  v45 = *((unsigned __int16 *)tif_data + 64);
  v85 = v6;
  v90 = *((_QWORD *)tif_data + 26);
  if ( v37 < v45 )
  {
LABEL_27:
    v86 = v41;
    v83 = v38;
    v91 = tif_rawcp;
    v46 = v6->tif_clientdata;
    tif_curstrip = v6->tif_curstrip;
    v48 = v44;
    TIFFWarningExt(v46, "LZWDecodeCompat", "LZWDecode: Strip %u not terminated with EOI code", tif_curstrip);
    v41 = v86;
    LOWORD(v38) = v83;
    v44 = v48;
    v6 = v85;
    tif_rawcp = v91;
LABEL_67:
    v42 = v90;
    goto LABEL_68;
  }
  while ( 1 )
  {
    v49 = v39 | ((unsigned __int64)*tif_rawcp << v40);
    if ( v40 + 8 >= (__int64)v45 )
    {
      ++tif_rawcp;
      v51 = v40 + 8;
    }
    else
    {
      v50 = (unsigned __int64)tif_rawcp[1] << ((unsigned __int8)v40 + 8);
      tif_rawcp += 2;
      v49 |= v50;
      v51 = v40 + 16;
    }
    v87 = v41;
    v52 = v41 & v49;
    v53 = (unsigned __int16)(v41 & v49);
    v39 = v49 >> v38;
    v40 = v51 - v45;
    *((_QWORD *)tif_data + 22) = v37 - v45;
    if ( v53 == 256 )
      break;
    if ( v52 == 257 )
    {
      v6 = v85;
      v41 = v87;
      goto LABEL_67;
    }
    v54 = *((_QWORD *)tif_data + 29);
    if ( v43 < v54 || v43 >= v54 + 81904 || (*(_QWORD *)v43 = v90, v90 < v54) || v90 >= v54 + 81904 )
    {
      v19 = 0;
      TIFFErrorExt(v85->tif_clientdata, "LZWDecodeCompat", "Corrupted LZW table at scanline %u", v85->tif_row);
      return v19;
    }
    v84 = v38;
    v55 = 16LL * v53;
    *(_BYTE *)(v43 + 11) = *(_BYTE *)(v90 + 11);
    v38 = v54 + v55;
    *(_WORD *)(v43 + 8) = *(_DWORD *)(v90 + 8) + 1;
    v56 = (_BYTE *)(v54 + v55 + 11);
    if ( v54 + v55 >= v43 )
      v56 = (_BYTE *)(v43 + 11);
    *(_BYTE *)(v43 + 10) = *v56;
    v43 += 16LL;
    if ( v43 > v44 )
    {
      v57 = v84;
      if ( v84 >= 12 )
        v57 = 11;
      v84 = v57 + 1;
      v87 = ~(-1LL << ((unsigned __int8)v57 + 1));
      v44 = v54 + 16 * v87;
    }
    if ( v53 < 0x100 )
    {
      *op0++ = v52;
      --occ0;
      v42 = v54 + v55;
      LODWORD(v38) = v84;
      v41 = v87;
      if ( occ0 <= 0 )
        goto LABEL_73;
    }
    else
    {
      v58 = *(unsigned __int16 *)(v54 + v55 + 8);
      v41 = v87;
      if ( !v58 )
      {
        v19 = 0;
        TIFFErrorExt(
          v85->tif_clientdata,
          "LZWDecodeCompat",
          "Wrong length of decoded string: data probably corrupted at scanline %u",
          v85->tif_row);
        return v19;
      }
      v59 = occ0 - v58;
      if ( occ0 < v58 )
      {
        *((_QWORD *)tif_data + 25) = v38;
        v74 = v38;
        do
          v74 = *(_QWORD *)v74;
        while ( occ0 < *(unsigned __int16 *)(v74 + 8) );
        *((_QWORD *)tif_data + 21) = occ0;
        v75 = occ0 - 1;
        v76 = occ0 & 3;
        if ( (occ0 & 3) != 0 )
        {
          do
          {
            op0[occ0 - 1] = *(_BYTE *)(v74 + 10);
            v74 = *(_QWORD *)v74;
            --occ0;
            --v76;
          }
          while ( v76 );
          v77 = &op0[occ0];
        }
        else
        {
          v77 = &op0[occ0];
        }
        v6 = v85;
        if ( v75 >= 3 )
        {
          v78 = -occ0;
          v79 = 0LL;
          do
          {
            v77[v79 - 1] = *(_BYTE *)(v74 + 10);
            v80 = *(__int64 ***)v74;
            v77[v79 - 2] = *((_BYTE *)v80 + 10);
            v81 = *v80;
            v77[v79 - 3] = *((_BYTE *)v81 + 10);
            v82 = *v81;
            v77[v79 - 4] = *(_BYTE *)(v82 + 10);
            v74 = *(_QWORD *)v82;
            v79 -= 4LL;
          }
          while ( v78 != v79 );
        }
        occ0 = 0LL;
        v42 = v38;
        LOWORD(v38) = v84;
        goto LABEL_68;
      }
      v60 = &op0[v58];
      v61 = &op0[v58 - 1];
      v62 = v38;
      do
      {
        *v61 = *(_BYTE *)(v62 + 10);
        if ( v61 <= op0 )
          break;
        v62 = *(_QWORD *)v62;
        --v61;
      }
      while ( v62 );
      op0 = v60;
      occ0 = v59;
      v42 = v38;
      LODWORD(v38) = v84;
      if ( v59 <= 0 )
        goto LABEL_73;
    }
LABEL_62:
    v90 = v42;
    v37 = *((_QWORD *)tif_data + 22);
    v45 = (int)v38;
    v6 = v85;
    if ( v37 < (int)v38 )
      goto LABEL_27;
  }
  v63 = tif_rawcp;
  v88 = op0;
  v64 = *((_QWORD *)tif_data + 29);
  do
  {
    v43 = v64 + 4128;
    TIFFmemset((void *)(v64 + 4128), 0, 77776LL);
    v69 = *((_QWORD *)tif_data + 22);
    v64 = *((_QWORD *)tif_data + 29);
    if ( v69 <= 8 )
    {
      v89 = v64 + 8176;
      TIFFWarningExt(
        v85->tif_clientdata,
        "LZWDecodeCompat",
        "LZWDecode: Strip %u not terminated with EOI code",
        v85->tif_curstrip);
      v44 = v89;
      v41 = 511LL;
      LOWORD(v38) = 9;
      tif_rawcp = v63;
      v6 = v85;
      goto LABEL_67;
    }
    v66 = v39 | ((unsigned __int64)*v63 << v40);
    if ( v40 + 8 <= 8 )
    {
      v65 = (unsigned __int64)v63[1] << ((unsigned __int8)v40 + 8);
      v63 += 2;
      v66 |= v65;
      v67 = v40 + 16;
    }
    else
    {
      ++v63;
      v67 = v40 + 8;
    }
    v68 = v66 & 0x1FF;
    v39 = v66 >> 9;
    v40 = v67 - 9;
    *((_QWORD *)tif_data + 22) = v69 - 9;
  }
  while ( v68 == 256 );
  if ( v68 == 257 )
  {
    v44 = v64 + 8176;
    v41 = 511LL;
    LOWORD(v38) = 9;
    tif_rawcp = v63;
    v6 = v85;
    goto LABEL_67;
  }
  if ( v68 < 0x101 )
  {
    tif_rawcp = v63;
    v44 = v64 + 8176;
    *v88 = v66;
    op0 = v88 + 1;
    --occ0;
    v42 = *((_QWORD *)tif_data + 29) + 16 * (v66 & 0x1FF);
    v41 = 511LL;
    LODWORD(v38) = 9;
    if ( occ0 > 0 )
      goto LABEL_62;
LABEL_73:
    v6 = v85;
    goto LABEL_68;
  }
  v19 = 0;
  TIFFErrorExt(v85->tif_clientdata, v85->tif_name, "LZWDecode: Corrupted LZW table at scanline %u", v85->tif_row);
  return v19;
}
