void __fastcall MAGMA_png_combine_row(png_const_structrp png_ptr, png_bytep dp, int display)
{
  unsigned __int64 transformed_pixel_depth;
  png_bytep row_buf;
  __int64 width;
  __int64 pass;
  size_t info_rowbytes;
  char v9;
  unsigned __int64 v10;
  unsigned int v11;
  png_byte *v12;
  png_bytep v13;
  png_uint_32 transformations;
  unsigned int v15;
  unsigned __int64 v16;
  unsigned __int64 v17;
  unsigned __int8 v18;
  __int64 v19;
  int *v20;
  unsigned __int64 v21;
  unsigned __int64 v22;
  unsigned int v23;
  size_t v24;
  unsigned __int64 v25;
  unsigned __int64 v26;
  unsigned int v27;
  unsigned __int64 v28;
  bool v29;
  unsigned __int64 v30;
  unsigned int v31;
  __int64 v32;
  unsigned int v33;
  unsigned int v34;
  _WORD *v35;
  __int16 *v36;
  __int64 v37;
  __int16 v38;
  __int64 v39;
  __int64 v40;
  unsigned __int64 v41;
  unsigned __int64 v42;
  __int64 v43;
  png_bytep v44;
  unsigned __int64 v45;
  int v46;
  __int64 v47;
  png_byte v48;
  __int64 v49;
  unsigned int v50;
  unsigned int v51;
  _DWORD *v52;
  int *v53;
  __int64 v54;
  int v55;
  __int64 v56;
  __int64 v57;
  unsigned __int64 v58;
  unsigned __int64 v59;
  __int64 v60;
  __int64 v61;
  unsigned __int64 v62;
  unsigned __int64 v63;
  __int128 v64;
  __int128 v65;
  __int128 v66;
  __int128 v67;
  __int64 v68;
  __int64 v69;
  __int128 v70;
  unsigned int v71;
  __int64 v72;
  __int64 v73;
  __int64 v74;
  unsigned __int64 v75;
  unsigned __int64 v76;
  __int128 v77;
  __int128 v78;
  __int128 v79;
  __int128 v80;
  __int64 v81;
  __int64 v82;
  __int128 v83;
  unsigned int v84;
  __int64 v85;
  __int64 v86;
  png_byte v87;
  png_bytep v88;

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
        goto LABEL_133;
    }
    else if ( info_rowbytes != width * (transformed_pixel_depth >> 3) )
    {
LABEL_133:
      MAGMA_png_error(png_ptr, "internal row size calculation error");
    }
  }
  if ( !(_DWORD)width )
    MAGMA_png_error(png_ptr, "internal row width error");
  v9 = (transformed_pixel_depth * width) & 7;
  if ( v9 )
  {
    if ( (unsigned __int8)transformed_pixel_depth < 8u )
      v10 = (transformed_pixel_depth * width + 7) >> 3;
    else
      v10 = width * (transformed_pixel_depth >> 3);
    v12 = &dp[v10 - 1];
    v87 = *v12;
    if ( (png_ptr->transformations & 0x10000) != 0 )
      v11 = 255 << v9;
    else
      v11 = 0xFFu >> v9;
  }
  else
  {
    v87 = 0;
    LOBYTE(v11) = 0;
    v12 = 0LL;
  }
  v13 = row_buf + 1;
  if ( !png_ptr->interlaced )
    goto LABEL_23;
  if ( (unsigned __int8)pass > 5u )
    goto LABEL_23;
  transformations = png_ptr->transformations;
  if ( (transformations & 2) == 0 )
    goto LABEL_23;
  if ( display != 1 )
  {
    if ( !display )
    {
      v15 = pass & 1;
      goto LABEL_30;
    }
LABEL_23:
    if ( (unsigned __int8)transformed_pixel_depth < 8u )
      v16 = (transformed_pixel_depth * width + 7) >> 3;
    else
      v16 = width * (transformed_pixel_depth >> 3);
    memcpy(dp, row_buf + 1, v16);
LABEL_27:
    if ( v12 )
      *v12 = v11 & v87 | *v12 & ~(_BYTE)v11;
    return;
  }
  v15 = 1;
  if ( (pass & 1) == 0 )
    goto LABEL_23;
LABEL_30:
  v17 = ((unsigned __int64)v15 << (3 - (unsigned __int8)((unsigned int)(pass + 1) >> 1))) & 7;
  if ( (unsigned int)width <= (unsigned int)v17 )
    return;
  if ( (unsigned __int8)transformed_pixel_depth <= 7u )
  {
    v18 = 8u / (unsigned __int8)transformed_pixel_depth;
    v19 = 0LL;
    if ( (_BYTE)transformed_pixel_depth != 1 )
      v19 = 2LL - ((_BYTE)transformed_pixel_depth == 2);
    if ( (transformations & 0x10000) != 0 )
    {
      if ( display )
        v20 = (int *)(((2 * (_DWORD)pass) & 0xFFFFFFFC) + 12 * v19 + 4335120);
      else
        v20 = (int *)(4LL * png_ptr->pass + 24 * v19 + 4334976);
    }
    else if ( display )
    {
      v20 = (int *)(((2 * (_DWORD)pass) & 0xFFFFFFFC) + 12 * v19 + 4335156);
    }
    else
    {
      v20 = (int *)(4 * pass + 24 * v19 + 4335048);
    }
    v46 = *v20;
    v47 = 0LL;
    if ( (_BYTE)v46 == 0xFF )
      goto LABEL_85;
LABEL_83:
    if ( (_BYTE)v46 )
    {
      v48 = dp[v47] & ~(_BYTE)v46 | v46 & v13[v47];
      goto LABEL_86;
    }
    while ( 1 )
    {
      v29 = (unsigned int)width <= v18;
      LODWORD(width) = width - v18;
      if ( v29 )
        goto LABEL_27;
      v46 = __ROL4__(v46, 24);
      ++v47;
      if ( (_BYTE)v46 != 0xFF )
        goto LABEL_83;
LABEL_85:
      v48 = v13[v47];
LABEL_86:
      dp[v47] = v48;
    }
  }
  if ( (transformed_pixel_depth & 7) != 0 )
    MAGMA_png_error(png_ptr, "invalid user transform pixel depth");
  v21 = transformed_pixel_depth >> 3;
  v22 = v21 * v17;
  v23 = v21 * width - v22;
  v24 = (unsigned int)v21;
  if ( display )
  {
    v24 = (unsigned int)((_DWORD)v21 << ((unsigned int)(6 - pass) >> 1));
    if ( (unsigned int)v24 > v23 )
      v24 = v23;
  }
  v25 = (unsigned __int64)&dp[v22];
  v26 = (unsigned __int64)&v13[v22];
  v27 = (_DWORD)v21 << ((unsigned int)(7 - pass) >> 1);
  switch ( (_DWORD)v24 )
  {
    case 1:
      *(_BYTE *)v25 = *(_BYTE *)v26;
      if ( v23 > v27 )
      {
        v30 = v27 + v22;
        do
        {
          v23 -= v27;
          dp[v30] = v13[v30];
          v30 += v27;
        }
        while ( v23 > v27 );
      }
      break;
    case 2:
      while ( 1 )
      {
        dp[v22] = row_buf[v22 + 1];
        dp[v22 + 1] = row_buf[v22 + 2];
        v29 = v23 <= v27;
        v23 -= v27;
        if ( v29 )
          break;
        v22 += v27;
        if ( v23 <= 1 )
        {
          dp[v22] = row_buf[v22 + 1];
          return;
        }
      }
      break;
    case 3:
      *(_BYTE *)v25 = *(_BYTE *)v26;
      *(_BYTE *)(v25 + 1) = *(_BYTE *)(v26 + 1);
      *(_BYTE *)(v25 + 2) = *(_BYTE *)(v26 + 2);
      if ( v23 > v27 )
      {
        v28 = v27 + v22;
        do
        {
          v23 -= v27;
          dp[v28] = row_buf[v28 + 1];
          dp[v28 + 1] = row_buf[v28 + 2];
          dp[v28 + 2] = row_buf[v28 + 3];
          v28 += v27;
        }
        while ( v23 > v27 );
      }
      return;
    default:
      if ( (unsigned int)v24 <= 0xF && (v25 & 1) == 0 && (v26 & 1) == 0 && (v24 & 1) == 0 && (v27 & 1) == 0 )
      {
        v31 = v27 - v24;
        if ( (((unsigned __int8)(v26 | v27) | (unsigned __int8)(v25 | v24)) & 3) != 0 )
        {
          v32 = v31 >> 1;
          v33 = v23 + ~v27;
          do
          {
            v34 = v33;
            v35 = (_WORD *)v25;
            v36 = (__int16 *)v26;
            v37 = (unsigned int)v24;
            do
            {
              v38 = *v36++;
              *v35++ = v38;
              v37 -= 2LL;
            }
            while ( v37 );
            v29 = v23 <= v27;
            v23 -= v27;
            if ( v29 )
              return;
            v25 = (unsigned __int64)&v35[v32];
            v26 = (unsigned __int64)&v36[v32];
            v33 -= v27;
          }
          while ( (unsigned int)v24 <= v23 );
          v39 = v23 - 1;
          v40 = v39 + 1;
          if ( (unsigned __int64)(v39 + 1) < 0x20 || v26 + v39 + 1 > v25 && v25 + v39 + 1 > v26 )
          {
LABEL_108:
            v71 = v23 - 1;
            if ( (v23 & 7) != 0 )
            {
              v72 = 0LL;
              do
              {
                *(_BYTE *)(v25 + v72) = *(_BYTE *)(v26 + v72);
                ++v72;
              }
              while ( (v23 & 7) != (_DWORD)v72 );
              v23 -= v72;
              v26 += v72;
              v25 += v72;
            }
            if ( v71 >= 7 )
            {
              v73 = 0LL;
              do
              {
                *(_BYTE *)(v25 + v73) = *(_BYTE *)(v26 + v73);
                *(_BYTE *)(v25 + v73 + 1) = *(_BYTE *)(v26 + v73 + 1);
                *(_BYTE *)(v25 + v73 + 2) = *(_BYTE *)(v26 + v73 + 2);
                *(_BYTE *)(v25 + v73 + 3) = *(_BYTE *)(v26 + v73 + 3);
                *(_BYTE *)(v25 + v73 + 4) = *(_BYTE *)(v26 + v73 + 4);
                *(_BYTE *)(v25 + v73 + 5) = *(_BYTE *)(v26 + v73 + 5);
                *(_BYTE *)(v25 + v73 + 6) = *(_BYTE *)(v26 + v73 + 6);
                *(_BYTE *)(v25 + v73 + 7) = *(_BYTE *)(v26 + v73 + 7);
                v73 += 8LL;
              }
              while ( v23 != (_DWORD)v73 );
            }
            return;
          }
          v41 = v40 & 0xFFFFFFFFFFFFFFE0LL;
          v42 = (((v40 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1;
          if ( (v40 & 0xFFFFFFFFFFFFFFE0LL) - 32 >= 0x60 )
          {
            v61 = 2 * v32 + 112;
            v62 = (((v34 + 1LL) & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5;
            v63 = (((_BYTE)v62 + 1) & 3) + ~v62;
            v43 = 0LL;
            do
            {
              v64 = *(_OWORD *)((char *)v36 + v61 - 96);
              *(_OWORD *)((char *)v35 + v61 - 112) = *(_OWORD *)((char *)v36 + v61 - 112);
              *(_OWORD *)((char *)v35 + v61 - 96) = v64;
              v65 = *(_OWORD *)((char *)v36 + v61 - 64);
              *(_OWORD *)((char *)v35 + v61 - 80) = *(_OWORD *)((char *)v36 + v61 - 80);
              *(_OWORD *)((char *)v35 + v61 - 64) = v65;
              v66 = *(_OWORD *)((char *)v36 + v61 - 32);
              *(_OWORD *)((char *)v35 + v61 - 48) = *(_OWORD *)((char *)v36 + v61 - 48);
              *(_OWORD *)((char *)v35 + v61 - 32) = v66;
              v67 = *(_OWORD *)((char *)v36 + v61);
              *(_OWORD *)((char *)v35 + v61 - 16) = *(_OWORD *)((char *)v36 + v61 - 16);
              *(_OWORD *)((char *)v35 + v61) = v67;
              v43 += 128LL;
              v61 += 128LL;
              v63 += 4LL;
            }
            while ( v63 );
            if ( (v42 & 3) == 0 )
              goto LABEL_106;
          }
          else
          {
            v43 = 0LL;
            if ( (v42 & 3) == 0 )
            {
LABEL_106:
              if ( v40 == v41 )
                return;
              v23 -= v41;
              v26 += v41;
              v25 += v41;
              goto LABEL_108;
            }
          }
          v68 = v43 + 2 * v32 + 16;
          v69 = -(__int64)((((unsigned __int8)(((v34 + 1) & 0x60) - 32) >> 5) + 1) & 3);
          do
          {
            v70 = *(_OWORD *)((char *)v36 + v68);
            *(_OWORD *)((char *)v35 + v68 - 16) = *(_OWORD *)((char *)v36 + v68 - 16);
            *(_OWORD *)((char *)v35 + v68) = v70;
            v68 += 32LL;
            ++v69;
          }
          while ( v69 );
          goto LABEL_106;
        }
        v49 = v31 >> 2;
        v50 = v23 + ~v27;
        do
        {
          v51 = v50;
          v52 = (_DWORD *)v25;
          v53 = (int *)v26;
          v54 = (unsigned int)v24;
          do
          {
            v55 = *v53++;
            *v52++ = v55;
            v54 -= 4LL;
          }
          while ( v54 );
          v29 = v23 <= v27;
          v23 -= v27;
          if ( v29 )
            return;
          v25 = (unsigned __int64)&v52[v49];
          v26 = (unsigned __int64)&v53[v49];
          v50 -= v27;
        }
        while ( (unsigned int)v24 <= v23 );
        v56 = v23 - 1;
        v57 = v56 + 1;
        if ( (unsigned __int64)(v56 + 1) < 0x20 || v26 + v56 + 1 > v25 && v25 + v56 + 1 > v26 )
        {
LABEL_123:
          v84 = v23 - 1;
          if ( (v23 & 7) != 0 )
          {
            v85 = 0LL;
            do
            {
              *(_BYTE *)(v25 + v85) = *(_BYTE *)(v26 + v85);
              ++v85;
            }
            while ( (v23 & 7) != (_DWORD)v85 );
            v23 -= v85;
            v26 += v85;
            v25 += v85;
          }
          if ( v84 >= 7 )
          {
            v86 = 0LL;
            do
            {
              *(_BYTE *)(v25 + v86) = *(_BYTE *)(v26 + v86);
              *(_BYTE *)(v25 + v86 + 1) = *(_BYTE *)(v26 + v86 + 1);
              *(_BYTE *)(v25 + v86 + 2) = *(_BYTE *)(v26 + v86 + 2);
              *(_BYTE *)(v25 + v86 + 3) = *(_BYTE *)(v26 + v86 + 3);
              *(_BYTE *)(v25 + v86 + 4) = *(_BYTE *)(v26 + v86 + 4);
              *(_BYTE *)(v25 + v86 + 5) = *(_BYTE *)(v26 + v86 + 5);
              *(_BYTE *)(v25 + v86 + 6) = *(_BYTE *)(v26 + v86 + 6);
              *(_BYTE *)(v25 + v86 + 7) = *(_BYTE *)(v26 + v86 + 7);
              v86 += 8LL;
            }
            while ( v23 != (_DWORD)v86 );
          }
          return;
        }
        v58 = v57 & 0xFFFFFFFFFFFFFFE0LL;
        v59 = (((v57 & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5) + 1;
        if ( (v57 & 0xFFFFFFFFFFFFFFE0LL) - 32 >= 0x60 )
        {
          v74 = 4 * v49 + 112;
          v75 = (((v51 + 1LL) & 0xFFFFFFFFFFFFFFE0LL) - 32) >> 5;
          v76 = (((_BYTE)v75 + 1) & 3) + ~v75;
          v60 = 0LL;
          do
          {
            v77 = *(_OWORD *)((char *)v53 + v74 - 96);
            *(_OWORD *)((char *)v52 + v74 - 112) = *(_OWORD *)((char *)v53 + v74 - 112);
            *(_OWORD *)((char *)v52 + v74 - 96) = v77;
            v78 = *(_OWORD *)((char *)v53 + v74 - 64);
            *(_OWORD *)((char *)v52 + v74 - 80) = *(_OWORD *)((char *)v53 + v74 - 80);
            *(_OWORD *)((char *)v52 + v74 - 64) = v78;
            v79 = *(_OWORD *)((char *)v53 + v74 - 32);
            *(_OWORD *)((char *)v52 + v74 - 48) = *(_OWORD *)((char *)v53 + v74 - 48);
            *(_OWORD *)((char *)v52 + v74 - 32) = v79;
            v80 = *(_OWORD *)((char *)v53 + v74);
            *(_OWORD *)((char *)v52 + v74 - 16) = *(_OWORD *)((char *)v53 + v74 - 16);
            *(_OWORD *)((char *)v52 + v74) = v80;
            v60 += 128LL;
            v74 += 128LL;
            v76 += 4LL;
          }
          while ( v76 );
          if ( (v59 & 3) == 0 )
            goto LABEL_121;
        }
        else
        {
          v60 = 0LL;
          if ( (v59 & 3) == 0 )
          {
LABEL_121:
            if ( v57 == v58 )
              return;
            v23 -= v58;
            v26 += v58;
            v25 += v58;
            goto LABEL_123;
          }
        }
        v81 = v60 + 4 * v49 + 16;
        v82 = -(__int64)((((unsigned __int8)(((v51 + 1) & 0x60) - 32) >> 5) + 1) & 3);
        do
        {
          v83 = *(_OWORD *)((char *)v53 + v81);
          *(_OWORD *)((char *)v52 + v81 - 16) = *(_OWORD *)((char *)v53 + v81 - 16);
          *(_OWORD *)((char *)v52 + v81) = v83;
          v81 += 32LL;
          ++v82;
        }
        while ( v82 );
        goto LABEL_121;
      }
      v88 = row_buf + 1;
      memcpy((void *)v25, (const void *)v26, (unsigned int)v24);
      v44 = v88;
      if ( v23 > v27 )
      {
        v45 = v27 + v22;
        do
        {
          v23 -= v27;
          if ( (unsigned int)v24 > v23 )
            v24 = v23;
          memcpy(&dp[v45], &v44[v45], v24);
          v44 = v88;
          v45 += v27;
        }
        while ( v23 > v27 );
      }
      break;
  }
}
