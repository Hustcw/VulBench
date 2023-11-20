void __fastcall MAGMA_png_combine_row(png_const_structrp png_ptr, png_bytep dp, int display)
{
  unsigned __int64 transformed_pixel_depth;
  png_bytep row_buf;
  unsigned __int64 width;
  __int64 pass;
  size_t info_rowbytes;
  unsigned __int64 v9;
  char v10;
  unsigned __int64 v11;
  png_byte *v12;
  unsigned int v13;
  png_bytep v14;
  png_uint_32 transformations;
  int v16;
  unsigned __int64 v17;
  unsigned int v18;
  unsigned __int8 v19;
  __int64 v20;
  int *v21;
  unsigned __int64 v22;
  unsigned __int64 v23;
  __int64 v24;
  unsigned __int64 v25;
  size_t v26;
  unsigned __int64 v27;
  png_byte *v28;
  png_byte *v29;
  unsigned int v30;
  unsigned __int64 v31;
  __int64 v32;
  bool v33;
  __int64 v34;
  unsigned int v35;
  __int64 v36;
  __int64 v37;
  __int64 v38;
  _WORD *v39;
  png_byte *v40;
  __int64 v41;
  __int16 v42;
  unsigned __int64 v43;
  __int64 v44;
  unsigned __int64 v45;
  png_bytep v46;
  png_bytep v47;
  size_t v48;
  __int64 v49;
  unsigned int v50;
  png_byte *v51;
  png_byte *v52;
  size_t v53;
  int v54;
  __int64 v55;
  png_byte v56;
  __int64 v57;
  __int64 v58;
  __int64 v59;
  _DWORD *v60;
  png_byte *v61;
  __int64 v62;
  int v63;
  unsigned __int64 v64;
  __int64 v65;
  unsigned __int64 v66;
  __int64 v67;
  __int128 v68;
  __int128 v69;
  __int128 v70;
  __int128 v71;
  __int64 v72;
  __int64 v73;
  __int128 v74;
  unsigned __int64 v75;
  __int64 v76;
  __int64 v77;
  unsigned __int64 v78;
  __int64 v79;
  __int128 v80;
  __int128 v81;
  __int128 v82;
  __int128 v83;
  __int64 v84;
  __int64 v85;
  __int128 v86;
  unsigned __int64 v87;
  __int64 v88;
  __int64 v89;
  png_byte v90;
  png_bytep v91;
  unsigned __int64 v92;
  png_bytep v93;
  unsigned int v94;

  transformed_pixel_depth = png_ptr->transformed_pixel_depth;
  if ( !png_ptr->transformed_pixel_depth )
    MAGMA_png_error(png_ptr, "internal row logic error");
  row_buf = png_ptr->row_buf;
  width = png_ptr->width;
  pass = png_ptr->pass;
  info_rowbytes = png_ptr->info_rowbytes;
  if ( info_rowbytes )
  {
    if ( (unsigned __int8)transformed_pixel_depth < 8u )
    {
      if ( info_rowbytes != (transformed_pixel_depth * width + 7) >> 3 )
        goto LABEL_131;
    }
    else if ( info_rowbytes != width * (transformed_pixel_depth >> 3) )
    {
LABEL_131:
      MAGMA_png_error(png_ptr, "internal row size calculation error");
    }
  }
  if ( !(_DWORD)width )
    MAGMA_png_error(png_ptr, "internal row width error");
  v9 = transformed_pixel_depth * width;
  v10 = (transformed_pixel_depth * width) & 7;
  if ( v10 )
  {
    v11 = (v9 + 7) >> 3;
    if ( (unsigned __int8)transformed_pixel_depth > 7u )
      v11 = width * (transformed_pixel_depth >> 3);
    v12 = &dp[v11 - 1];
    v90 = *v12;
    if ( (png_ptr->transformations & 0x10000) != 0 )
      v13 = 255 << v10;
    else
      v13 = 0xFFu >> v10;
  }
  else
  {
    v90 = 0;
    LOBYTE(v13) = 0;
    v12 = 0LL;
  }
  v14 = row_buf + 1;
  if ( !png_ptr->interlaced )
    goto LABEL_22;
  if ( (unsigned __int8)pass > 5u )
    goto LABEL_22;
  transformations = png_ptr->transformations;
  if ( (transformations & 2) == 0 )
    goto LABEL_22;
  if ( display != 1 )
  {
    if ( !display )
    {
      v16 = pass & 1;
      goto LABEL_28;
    }
LABEL_22:
    v17 = (v9 + 7) >> 3;
    if ( (unsigned __int8)transformed_pixel_depth > 7u )
      v17 = width * (transformed_pixel_depth >> 3);
    memcpy(dp, row_buf + 1, v17);
LABEL_25:
    if ( v12 )
      *v12 = v13 & v90 | *v12 & ~(_BYTE)v13;
    return;
  }
  v16 = 1;
  if ( (pass & 1) == 0 )
    goto LABEL_22;
LABEL_28:
  v18 = (v16 << (3 - ((unsigned int)(pass + 1) >> 1))) & 7;
  if ( (unsigned int)width <= v18 )
    return;
  if ( (unsigned __int8)transformed_pixel_depth <= 7u )
  {
    v19 = 8u / (unsigned __int8)transformed_pixel_depth;
    v20 = 0LL;
    if ( (_BYTE)transformed_pixel_depth != 1 )
      v20 = 2LL - ((_BYTE)transformed_pixel_depth == 2);
    if ( (transformations & 0x10000) != 0 )
    {
      if ( display )
        v21 = (int *)(((2 * (_DWORD)pass) & 0xFFFFFFFC) + 12 * v20 + 4335392);
      else
        v21 = (int *)(4LL * png_ptr->pass + 24 * v20 + 4335248);
    }
    else if ( display )
    {
      v21 = (int *)(((2 * (_DWORD)pass) & 0xFFFFFFFC) + 12 * v20 + 4335428);
    }
    else
    {
      v21 = (int *)(4 * pass + 24 * v20 + 4335320);
    }
    v54 = *v21;
    v55 = 0LL;
    if ( (_BYTE)v54 == 0xFF )
      goto LABEL_83;
LABEL_81:
    if ( (_BYTE)v54 )
    {
      v56 = dp[v55] & ~(_BYTE)v54 | v54 & v14[v55];
      goto LABEL_84;
    }
    while ( 1 )
    {
      v33 = width <= v19;
      width -= v19;
      if ( v33 )
        goto LABEL_25;
      v54 = __ROL4__(v54, 24);
      ++v55;
      if ( (_BYTE)v54 != 0xFF )
        goto LABEL_81;
LABEL_83:
      v56 = v14[v55];
LABEL_84:
      dp[v55] = v56;
    }
  }
  if ( (transformed_pixel_depth & 7) != 0 )
    MAGMA_png_error(png_ptr, "invalid user transform pixel depth");
  v22 = transformed_pixel_depth >> 3;
  v23 = v22 * width;
  v24 = (unsigned int)v22 * v18;
  v25 = v22 * width - v24;
  v26 = (unsigned int)v22;
  if ( display )
  {
    v27 = (unsigned int)((_DWORD)v22 << ((unsigned int)(6 - pass) >> 1));
    v26 = (unsigned int)v25;
    if ( v25 >= v27 )
      v26 = (unsigned int)v27;
  }
  v28 = &dp[v24];
  v29 = &v14[v24];
  v30 = (_DWORD)v22 << ((unsigned int)(7 - pass) >> 1);
  if ( (_DWORD)v26 == 1 )
  {
    *v28 = *v29;
    if ( v25 > v30 )
    {
      v34 = v30 + v24;
      do
      {
        v25 -= v30;
        dp[v34] = v14[v34];
        v34 += v30;
      }
      while ( v25 > v30 );
    }
  }
  else if ( (_DWORD)v26 == 2 )
  {
    while ( 1 )
    {
      dp[v24] = row_buf[v24 + 1];
      dp[v24 + 1] = row_buf[v24 + 2];
      v33 = v25 <= v30;
      v25 -= v30;
      if ( v33 )
        break;
      v24 += v30;
      if ( v25 <= 1 )
      {
        dp[v24] = row_buf[v24 + 1];
        return;
      }
    }
  }
  else
  {
    v31 = v30;
    if ( (_DWORD)v26 == 3 )
    {
      *v28 = *v29;
      v28[1] = v29[1];
      v28[2] = v29[2];
      if ( v25 > v30 )
      {
        v32 = v30 + v24;
        do
        {
          v25 -= v30;
          dp[v32] = row_buf[v32 + 1];
          dp[v32 + 1] = row_buf[v32 + 2];
          dp[v32 + 2] = row_buf[v32 + 3];
          v32 += v30;
        }
        while ( v25 > v30 );
      }
      return;
    }
    if ( (unsigned int)v26 <= 0xF
      && ((unsigned __int8)v28 & 1) == 0
      && ((unsigned __int8)v29 & 1) == 0
      && (v26 & 1) == 0
      && (v30 & 1) == 0 )
    {
      v35 = v30 - v26;
      if ( (((unsigned __int8)(v31 | (unsigned __int8)v29) | (unsigned __int8)((unsigned __int8)v28 | v26)) & 3) != 0 )
      {
        v36 = v35 >> 1;
        v37 = v23 - v31 - v24;
        do
        {
          v38 = v37;
          v39 = v28;
          v40 = v29;
          v41 = (unsigned int)v26;
          do
          {
            v42 = *(_WORD *)v40;
            v40 += 2;
            *v39++ = v42;
            v41 -= 2LL;
          }
          while ( v41 );
          v33 = v25 <= v31;
          v25 -= v31;
          if ( v33 )
            return;
          v28 = (png_byte *)&v39[v36];
          v29 = &v40[2 * v36];
          v37 = v38 - v31;
        }
        while ( v25 >= (unsigned int)v26 );
        if ( v25 < 0x20 || &v29[v25] > v28 && &v28[v25] > v29 )
        {
LABEL_106:
          v75 = v25 - 1;
          if ( (v25 & 7) != 0 )
          {
            v76 = 0LL;
            do
            {
              v28[v76] = v29[v76];
              ++v76;
            }
            while ( (v25 & 7) != v76 );
            v25 -= v76;
            v29 += v76;
            v28 += v76;
          }
          if ( v75 >= 7 )
          {
            v77 = 0LL;
            do
            {
              v28[v77] = v29[v77];
              v28[v77 + 1] = v29[v77 + 1];
              v28[v77 + 2] = v29[v77 + 2];
              v28[v77 + 3] = v29[v77 + 3];
              v28[v77 + 4] = v29[v77 + 4];
              v28[v77 + 5] = v29[v77 + 5];
              v28[v77 + 6] = v29[v77 + 6];
              v28[v77 + 7] = v29[v77 + 7];
              v77 += 8LL;
            }
            while ( v25 != v77 );
          }
          return;
        }
        v43 = v25 & 0xFFFFFFFFFFFFFFE0LL;
        if ( (v25 & 0xFFFFFFFFFFFFFFE0LL) - 32 >= 0x60 )
        {
          v66 = (((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5)
              + 1
              - (((unsigned __int8)(((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1) & 3);
          v67 = 2 * v36 + 112;
          v44 = 0LL;
          do
          {
            v68 = *(_OWORD *)&v40[v67 - 96];
            *(_OWORD *)((char *)v39 + v67 - 112) = *(_OWORD *)&v40[v67 - 112];
            *(_OWORD *)((char *)v39 + v67 - 96) = v68;
            v69 = *(_OWORD *)&v40[v67 - 64];
            *(_OWORD *)((char *)v39 + v67 - 80) = *(_OWORD *)&v40[v67 - 80];
            *(_OWORD *)((char *)v39 + v67 - 64) = v69;
            v70 = *(_OWORD *)&v40[v67 - 32];
            *(_OWORD *)((char *)v39 + v67 - 48) = *(_OWORD *)&v40[v67 - 48];
            *(_OWORD *)((char *)v39 + v67 - 32) = v70;
            v71 = *(_OWORD *)&v40[v67];
            *(_OWORD *)((char *)v39 + v67 - 16) = *(_OWORD *)&v40[v67 - 16];
            *(_OWORD *)((char *)v39 + v67) = v71;
            v44 += 128LL;
            v67 += 128LL;
            v66 -= 4LL;
          }
          while ( v66 );
          if ( (((unsigned __int8)(((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1) & 3) == 0 )
            goto LABEL_104;
        }
        else
        {
          v44 = 0LL;
          if ( (((unsigned __int8)(((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1) & 3) == 0 )
          {
LABEL_104:
            if ( v25 == v43 )
              return;
            v25 -= v43;
            v29 += v43;
            v28 += v43;
            goto LABEL_106;
          }
        }
        v72 = v44 + 2 * v36 + 16;
        v73 = -(__int64)((((unsigned __int8)((v38 & 0x60) - 32) >> 5) + 1) & 3);
        do
        {
          v74 = *(_OWORD *)&v40[v72];
          *(_OWORD *)((char *)v39 + v72 - 16) = *(_OWORD *)&v40[v72 - 16];
          *(_OWORD *)((char *)v39 + v72) = v74;
          v72 += 32LL;
          ++v73;
        }
        while ( v73 );
        goto LABEL_104;
      }
      v57 = v35 >> 2;
      v58 = v23 - v31 - v24;
      do
      {
        v59 = v58;
        v60 = v28;
        v61 = v29;
        v62 = (unsigned int)v26;
        do
        {
          v63 = *(_DWORD *)v61;
          v61 += 4;
          *v60++ = v63;
          v62 -= 4LL;
        }
        while ( v62 );
        v33 = v25 <= v31;
        v25 -= v31;
        if ( v33 )
          return;
        v28 = (png_byte *)&v60[v57];
        v29 = &v61[4 * v57];
        v58 = v59 - v31;
      }
      while ( v25 >= (unsigned int)v26 );
      if ( v25 < 0x20 || &v29[v25] > v28 && &v28[v25] > v29 )
      {
LABEL_121:
        v87 = v25 - 1;
        if ( (v25 & 7) != 0 )
        {
          v88 = 0LL;
          do
          {
            v28[v88] = v29[v88];
            ++v88;
          }
          while ( (v25 & 7) != v88 );
          v25 -= v88;
          v29 += v88;
          v28 += v88;
        }
        if ( v87 >= 7 )
        {
          v89 = 0LL;
          do
          {
            v28[v89] = v29[v89];
            v28[v89 + 1] = v29[v89 + 1];
            v28[v89 + 2] = v29[v89 + 2];
            v28[v89 + 3] = v29[v89 + 3];
            v28[v89 + 4] = v29[v89 + 4];
            v28[v89 + 5] = v29[v89 + 5];
            v28[v89 + 6] = v29[v89 + 6];
            v28[v89 + 7] = v29[v89 + 7];
            v89 += 8LL;
          }
          while ( v25 != v89 );
        }
        return;
      }
      v64 = v25 & 0xFFFFFFFFFFFFFFE0LL;
      if ( (v25 & 0xFFFFFFFFFFFFFFE0LL) - 32 >= 0x60 )
      {
        v78 = (((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5)
            + 1
            - (((unsigned __int8)(((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1) & 3);
        v79 = 4 * v57 + 112;
        v65 = 0LL;
        do
        {
          v80 = *(_OWORD *)&v61[v79 - 96];
          *(_OWORD *)((char *)v60 + v79 - 112) = *(_OWORD *)&v61[v79 - 112];
          *(_OWORD *)((char *)v60 + v79 - 96) = v80;
          v81 = *(_OWORD *)&v61[v79 - 64];
          *(_OWORD *)((char *)v60 + v79 - 80) = *(_OWORD *)&v61[v79 - 80];
          *(_OWORD *)((char *)v60 + v79 - 64) = v81;
          v82 = *(_OWORD *)&v61[v79 - 32];
          *(_OWORD *)((char *)v60 + v79 - 48) = *(_OWORD *)&v61[v79 - 48];
          *(_OWORD *)((char *)v60 + v79 - 32) = v82;
          v83 = *(_OWORD *)&v61[v79];
          *(_OWORD *)((char *)v60 + v79 - 16) = *(_OWORD *)&v61[v79 - 16];
          *(_OWORD *)((char *)v60 + v79) = v83;
          v65 += 128LL;
          v79 += 128LL;
          v78 -= 4LL;
        }
        while ( v78 );
        if ( (((unsigned __int8)(((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1) & 3) == 0 )
          goto LABEL_119;
      }
      else
      {
        v65 = 0LL;
        if ( (((unsigned __int8)(((v25 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1) & 3) == 0 )
        {
LABEL_119:
          if ( v25 == v64 )
            return;
          v25 -= v64;
          v29 += v64;
          v28 += v64;
          goto LABEL_121;
        }
      }
      v84 = v65 + 4 * v57 + 16;
      v85 = -(__int64)((((unsigned __int8)((v59 & 0x60) - 32) >> 5) + 1) & 3);
      do
      {
        v86 = *(_OWORD *)&v61[v84];
        *(_OWORD *)((char *)v60 + v84 - 16) = *(_OWORD *)&v61[v84 - 16];
        *(_OWORD *)((char *)v60 + v84) = v86;
        v84 += 32LL;
        ++v85;
      }
      while ( v85 );
      goto LABEL_119;
    }
    v91 = dp;
    v94 = v30;
    v93 = row_buf + 1;
    v92 = v30;
    memcpy(v28, v29, (unsigned int)v26);
    v45 = v92;
    v46 = v93;
    v47 = v91;
    if ( v25 > v92 )
    {
      v48 = (unsigned int)v26;
      v49 = v92 + v24;
      v50 = width * v22 - v24 - v94;
      do
      {
        v51 = &v46[v49];
        v52 = &v47[v49];
        v53 = v25 - v92;
        v25 -= v45;
        if ( v53 < v48 )
          v26 = v50;
        memcpy(v52, v51, v26);
        v45 = v92;
        v46 = v93;
        v47 = v91;
        v49 += v92;
        v50 -= v94;
        v48 = v26;
      }
      while ( v25 > v92 );
    }
  }
}
