int psf_binheader_writef(SF_PRIVATE *psf, const char *format, ...)
{
  double v2;
  const char *v3;
  char v5;
  int v6;
  int v7;
  char *v8;
  __int64 *v9;
  const char **v10;
  int *v11;
  int *v12;
  int *v13;
  sf_count_t *v14;
  const char **v15;
  __int64 gp_offset;
  const void *v17;
  size_t *v18;
  sf_count_t *v19;
  int *v20;
  sf_count_t *v21;
  const char **v22;
  sf_count_t *v23;
  unsigned __int8 *v24;
  __int64 v25;
  __int64 v26;
  const char *v27;
  size_t v28;
  size_t v29;
  __int64 v30;
  __int64 v31;
  __int64 v32;
  __int64 v33;
  int v34;
  __int64 v35;
  int v36;
  __int64 v37;
  int v38;
  __int64 v39;
  sf_count_t v40;
  int rwf_endian;
  __int64 v42;
  const char *v43;
  size_t v44;
  size_t v45;
  sf_count_t v46;
  size_t v47;
  const void *v48;
  __int64 v49;
  size_t v50;
  sf_count_t indx;
  unsigned __int8 *v52;
  __int64 v53;
  sf_count_t v54;
  sf_count_t v55;
  __int64 v56;
  __int64 v57;
  sf_count_t v58;
  __int64 v59;
  const char *v60;
  size_t v61;
  size_t v62;
  __int64 v63;
  sf_count_t v64;
  sf_count_t v65;
  sf_count_t v66;
  sf_count_t v67;
  unsigned __int8 *ptr;
  sf_count_t v69;
  va_list va;
  int v72;
  __int128 v73;
  __int128 v74;

  va_start(va, format);
  *(double *)&v73 = va_arg(va, double);
  *(double *)&v74 = va_arg(va, double);
  v2 = *(double *)&v74;
  va_end(va);
  v3 = format;
  if ( !format )
    return psf_ftell(psf);
  va_start(va, format);
  v5 = *format;
  if ( *format )
  {
    v6 = 0;
    v7 = 0;
    while ( 1 )
    {
      if ( psf->header.indx + 16 >= psf->header.len && psf_bump_header_allocation(psf, 16LL) )
        return v7;
      ++v3;
      switch ( v5 )
      {
        case ' ':
          goto LABEL_5;
        case '1':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v32 = va_arg(va, _QWORD);
            v8 = (char *)&v32;
          }
          else
          {
            v8 = (char *)va[0].reg_save_area + (int)va[0].gp_offset;
            va[0].gp_offset += 8;
          }
          header_put_byte(psf, *v8);
          ++v7;
          goto LABEL_5;
        case '2':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v33 = va_arg(va, _QWORD);
            v11 = (int *)&v33;
          }
          else
          {
            v11 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v34 = *v11;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_short(psf, v34);
          else
            header_put_le_short(psf, v34);
          v7 += 2;
          goto LABEL_5;
        case '3':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v35 = va_arg(va, _QWORD);
            v12 = (int *)&v35;
          }
          else
          {
            v12 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v36 = *v12;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_3byte(psf, v36);
          else
            header_put_le_3byte(psf, v36);
          v7 += 3;
          goto LABEL_5;
        case '4':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v37 = va_arg(va, _QWORD);
            v13 = (int *)&v37;
          }
          else
          {
            v13 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v38 = *v13;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_int(psf, v38);
          else
            header_put_le_int(psf, v38);
          v7 += 4;
          goto LABEL_5;
        case '8':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v39 = va_arg(va, _QWORD);
            v14 = &v39;
          }
          else
          {
            v14 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v40 = *v14;
          rwf_endian = psf->rwf_endian;
          if ( !v6 && rwf_endian == 0x20000000 )
          {
            header_put_be_8byte(psf, v40);
LABEL_121:
            v7 += 8;
            v6 = 0;
            goto LABEL_5;
          }
          if ( !v6 && rwf_endian == 0x10000000 )
          {
            header_put_le_8byte(psf, v40);
            goto LABEL_121;
          }
          if ( v6 == 1 && rwf_endian == 0x20000000 )
          {
            header_put_be_int(psf, v40);
          }
          else
          {
            if ( v6 != 1 || rwf_endian != 0x10000000 )
              goto LABEL_5;
            header_put_le_int(psf, v40);
          }
          v7 += 4;
          v6 = 1;
          goto LABEL_5;
        case 'E':
          psf->rwf_endian = 0x20000000;
          goto LABEL_5;
        case 'S':
          v72 = v6;
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v42 = va_arg(va, _QWORD);
            v15 = (const char **)&v42;
          }
          else
          {
            v15 = (const char **)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v43 = *v15;
          v44 = strlen(*v15);
          v45 = v44 & 1;
          v46 = v45 + v44 + 4;
          if ( v46 + psf->header.indx > psf->header.len && psf_bump_header_allocation(psf, v46) )
            goto LABEL_79;
          v47 = v44 + v45;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_int(psf, v44);
          else
            header_put_le_int(psf, v44);
          memcpy(&psf->header.ptr[psf->header.indx], v43, v47);
          psf->header.indx += v47;
          v7 += v47 + 4;
          v6 = v72;
          goto LABEL_5;
        case 'T':
          v6 = 0;
          goto LABEL_5;
        case 'b':
          gp_offset = (int)va[0].gp_offset;
          if ( (unsigned __int64)(int)va[0].gp_offset >= 0x29 )
          {
            v48 = va_arg(va, const void *);
            v17 = v48;
          }
          else
          {
            va[0].gp_offset += 8;
            v17 = *(const void **)((char *)va[0].reg_save_area + gp_offset);
            if ( (unsigned int)(gp_offset + 8) <= 0x28 )
            {
              v18 = (size_t *)((char *)va[0].reg_save_area + gp_offset + 8);
              va[0].gp_offset = gp_offset + 16;
              goto LABEL_84;
            }
          }
          v49 = va_arg(va, _QWORD);
          v18 = (size_t *)&v49;
LABEL_84:
          v50 = *v18;
          indx = psf->header.indx;
          if ( (signed __int64)(indx + *v18) <= psf->header.len )
            goto LABEL_87;
          if ( !psf_bump_header_allocation(psf, v50) )
          {
            indx = psf->header.indx;
LABEL_87:
            memcpy(&psf->header.ptr[indx], v17, v50);
            psf->header.indx += v50;
            v7 += v50;
          }
LABEL_5:
          v5 = *v3;
          if ( !*v3 )
            return v7;
          break;
        case 'd':
          if ( (unsigned __int64)(int)va[0].fp_offset > 0xA0 )
            va_arg(va, _QWORD);
          else
            va[0].fp_offset += 16;
          v24 = &psf->header.ptr[psf->header.indx];
          if ( psf->rwf_endian == 0x20000000 )
            double64_be_write(v2, v24);
          else
            double64_le_write(v2, v24);
          psf->header.indx += 8LL;
          v7 += 8;
          goto LABEL_5;
        case 'e':
          psf->rwf_endian = 0x10000000;
          goto LABEL_5;
        case 'f':
          if ( (unsigned __int64)(int)va[0].fp_offset > 0xA0 )
            va_arg(va, _QWORD);
          else
            va[0].fp_offset += 16;
          v52 = &psf->header.ptr[psf->header.indx];
          if ( psf->rwf_endian == 0x20000000 )
            float32_be_write(*(float *)&v2, v52);
          else
            float32_le_write(*(float *)&v2, v52);
          psf->header.indx += 4LL;
          v7 += 4;
          goto LABEL_5;
        case 'h':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v25 = va_arg(va, _QWORD);
            v9 = &v25;
          }
          else
          {
            v9 = (__int64 *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          *(_OWORD *)&psf->header.ptr[psf->header.indx] = *(_OWORD *)*v9;
          psf->header.indx += 16LL;
          v7 += 16;
          goto LABEL_5;
        case 'j':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v53 = va_arg(va, _QWORD);
            v19 = &v53;
          }
          else
          {
            v19 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v54 = *v19;
          v55 = *v19 + psf->header.indx;
          if ( v55 <= psf->header.len )
            goto LABEL_95;
          if ( !psf_bump_header_allocation(psf, v54) )
          {
            v55 = v54 + psf->header.indx;
LABEL_95:
            psf->header.indx = v55;
            v7 += v54;
          }
          goto LABEL_5;
        case 'm':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v56 = va_arg(va, _QWORD);
            v20 = (int *)&v56;
          }
          else
          {
            v20 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          header_put_marker(psf, *v20);
          v7 += 4;
          goto LABEL_5;
        case 'o':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v57 = va_arg(va, _QWORD);
            v21 = &v57;
          }
          else
          {
            v21 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v58 = *v21;
          if ( *v21 < psf->header.len || !psf_bump_header_allocation(psf, *v21) )
            psf->header.indx = v58;
          goto LABEL_5;
        case 'p':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v59 = va_arg(va, _QWORD);
            v22 = (const char **)&v59;
          }
          else
          {
            v22 = (const char **)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v60 = *v22;
          v61 = strlen(*v22);
          v62 = v61 + ((v61 & 1) == 0);
          if ( v62 >= 0xFE )
            v62 = 254LL;
          if ( (signed __int64)(v62 + 1 + psf->header.indx) <= psf->header.len
            || !psf_bump_header_allocation(psf, v62 + 1) )
          {
            header_put_byte(psf, v62);
            memcpy(&psf->header.ptr[psf->header.indx], v60, v62);
            psf->header.indx += v62;
            v7 += v62 + 1;
          }
          goto LABEL_5;
        case 's':
          v72 = v6;
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v26 = va_arg(va, _QWORD);
            v10 = (const char **)&v26;
          }
          else
          {
            v10 = (const char **)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v27 = *v10;
          v28 = strlen(*v10);
          v29 = v28 + 1;
          v30 = ((_BYTE)v28 + 1) & 1;
          v31 = v30 + v28 + 1;
          if ( v31 + psf->header.indx + 4 > psf->header.len && psf_bump_header_allocation(psf, v28 + v30 + 5) )
          {
LABEL_79:
            v6 = v72;
          }
          else
          {
            if ( psf->rwf_endian == 0x20000000 )
              header_put_be_int(psf, v31);
            else
              header_put_le_int(psf, v31);
            memcpy(&psf->header.ptr[psf->header.indx], v27, v29);
            v67 = psf->header.indx + v31;
            psf->header.indx = v67;
            psf->header.ptr[v67 - 1] = 0;
            v7 += v31 + 4;
            v6 = v72;
          }
          goto LABEL_5;
        case 't':
          v6 = 1;
          goto LABEL_5;
        case 'z':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v63 = va_arg(va, _QWORD);
            v23 = &v63;
          }
          else
          {
            v23 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v64 = *v23;
          if ( *v23 + psf->header.indx > psf->header.len && psf_bump_header_allocation(psf, v64) )
            goto LABEL_5;
          v7 += v64;
          if ( !v64 )
            goto LABEL_5;
          v65 = psf->header.indx;
          if ( (v64 & 1) != 0 )
          {
            psf->header.ptr[v65] = 0;
            v65 = psf->header.indx + 1;
            psf->header.indx = v65;
            v66 = v64 - 1;
            if ( v64 != 1 )
            {
              do
              {
LABEL_132:
                psf->header.ptr[v65] = 0;
                ptr = psf->header.ptr;
                v69 = psf->header.indx;
                psf->header.indx = v69 + 1;
                ptr[v69 + 1] = 0;
                v65 = psf->header.indx + 1;
                psf->header.indx = v65;
                v66 -= 2LL;
              }
              while ( v66 );
              goto LABEL_5;
            }
          }
          else
          {
            v66 = v64;
            if ( v64 != 1 )
              goto LABEL_132;
          }
          goto LABEL_5;
        default:
          psf_log_printf(psf, "*** Invalid format specifier `%c'\n", (unsigned int)v5);
          psf->error = 29;
          goto LABEL_5;
      }
    }
  }
  return 0;
}