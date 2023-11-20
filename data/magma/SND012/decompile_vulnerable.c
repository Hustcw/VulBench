int psf_binheader_writef(SF_PRIVATE *psf, const char *format, ...)
{
  double v2;
  const char *v3;
  char v5;
  int v6;
  char *v7;
  __int64 *v8;
  const char **v9;
  int *v10;
  int *v11;
  int *v12;
  sf_count_t *v13;
  const char **v14;
  __int64 gp_offset;
  const void *v16;
  size_t *v17;
  sf_count_t *v18;
  int *v19;
  sf_count_t *v20;
  const char **v21;
  sf_count_t *v22;
  unsigned __int8 *v23;
  __int64 v24;
  __int64 v25;
  const char *v26;
  size_t v27;
  __int64 v28;
  __int64 v29;
  __int64 v30;
  int v31;
  __int64 v32;
  int v33;
  __int64 v34;
  int v35;
  __int64 v36;
  sf_count_t v37;
  int rwf_endian;
  __int64 v39;
  const char *v40;
  size_t v41;
  const void *v42;
  __int64 v43;
  size_t v44;
  sf_count_t indx;
  unsigned __int8 *v46;
  __int64 v47;
  sf_count_t v48;
  sf_count_t v49;
  __int64 v50;
  __int64 v51;
  sf_count_t v52;
  __int64 v53;
  const char *v54;
  size_t v55;
  size_t v56;
  __int64 v57;
  sf_count_t v58;
  sf_count_t v59;
  sf_count_t v60;
  sf_count_t v61;
  size_t v62;
  sf_count_t v63;
  unsigned __int8 *ptr;
  sf_count_t v65;
  va_list va;
  int v68;
  __int128 v69;
  __int128 v70;

  va_start(va, format);
  *(double *)&v69 = va_arg(va, double);
  *(double *)&v70 = va_arg(va, double);
  v2 = *(double *)&v70;
  va_end(va);
  v3 = format;
  if ( !format )
    return psf_ftell(psf);
  va_start(va, format);
  v5 = *format;
  if ( *format )
  {
    v68 = 0;
    v6 = 0;
    while ( 1 )
    {
      if ( psf->header.indx + 16 >= psf->header.len && psf_bump_header_allocation(psf, 16LL) )
        return v6;
      switch ( v5 )
      {
        case ' ':
          goto LABEL_6;
        case '1':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v29 = va_arg(va, _QWORD);
            v7 = (char *)&v29;
          }
          else
          {
            v7 = (char *)va[0].reg_save_area + (int)va[0].gp_offset;
            va[0].gp_offset += 8;
          }
          header_put_byte(psf, *v7);
          ++v6;
          goto LABEL_6;
        case '2':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v30 = va_arg(va, _QWORD);
            v10 = (int *)&v30;
          }
          else
          {
            v10 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v31 = *v10;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_short(psf, v31);
          else
            header_put_le_short(psf, v31);
          v6 += 2;
          goto LABEL_6;
        case '3':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v32 = va_arg(va, _QWORD);
            v11 = (int *)&v32;
          }
          else
          {
            v11 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v33 = *v11;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_3byte(psf, v33);
          else
            header_put_le_3byte(psf, v33);
          v6 += 3;
          goto LABEL_6;
        case '4':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v34 = va_arg(va, _QWORD);
            v12 = (int *)&v34;
          }
          else
          {
            v12 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v35 = *v12;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_int(psf, v35);
          else
            header_put_le_int(psf, v35);
          v6 += 4;
          goto LABEL_6;
        case '8':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v36 = va_arg(va, _QWORD);
            v13 = &v36;
          }
          else
          {
            v13 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v37 = *v13;
          rwf_endian = psf->rwf_endian;
          if ( !v68 && rwf_endian == 0x20000000 )
          {
            header_put_be_8byte(psf, v37);
LABEL_123:
            v6 += 8;
            v68 = 0;
            goto LABEL_6;
          }
          if ( !v68 && rwf_endian == 0x10000000 )
          {
            header_put_le_8byte(psf, v37);
            goto LABEL_123;
          }
          if ( v68 == 1 && rwf_endian == 0x20000000 )
          {
            header_put_be_int(psf, v37);
          }
          else
          {
            if ( v68 != 1 || rwf_endian != 0x10000000 )
              goto LABEL_6;
            header_put_le_int(psf, v37);
          }
          v6 += 4;
          v68 = 1;
LABEL_6:
          v5 = *++v3;
          if ( !*v3 )
            return v6;
          break;
        case 'E':
          psf->rwf_endian = 0x20000000;
          goto LABEL_6;
        case 'S':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v39 = va_arg(va, _QWORD);
            v14 = (const char **)&v39;
          }
          else
          {
            v14 = (const char **)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v40 = *v14;
          v41 = strlen(*v14);
          if ( (signed __int64)(v41 + psf->header.indx) <= psf->header.len || !psf_bump_header_allocation(psf, v41) )
          {
            if ( psf->rwf_endian == 0x20000000 )
              header_put_be_int(psf, v41);
            else
              header_put_le_int(psf, v41);
            memcpy(&psf->header.ptr[psf->header.indx], v40, v41 + 1);
            v62 = v41 + (v41 & 1);
            v63 = v62 + psf->header.indx;
            psf->header.indx = v63;
            psf->header.ptr[v63] = 0;
            v6 += v62 + 4;
          }
          goto LABEL_6;
        case 'T':
          v68 = 0;
          goto LABEL_6;
        case 'b':
          gp_offset = (int)va[0].gp_offset;
          if ( (unsigned __int64)(int)va[0].gp_offset >= 0x29 )
          {
            v42 = va_arg(va, const void *);
            v16 = v42;
          }
          else
          {
            va[0].gp_offset += 8;
            v16 = *(const void **)((char *)va[0].reg_save_area + gp_offset);
            if ( (unsigned int)(gp_offset + 8) <= 0x28 )
            {
              v17 = (size_t *)((char *)va[0].reg_save_area + gp_offset + 8);
              va[0].gp_offset = gp_offset + 16;
              goto LABEL_84;
            }
          }
          v43 = va_arg(va, _QWORD);
          v17 = (size_t *)&v43;
LABEL_84:
          v44 = *v17;
          indx = psf->header.indx;
          if ( (signed __int64)(indx + *v17) <= psf->header.len )
            goto LABEL_87;
          if ( !psf_bump_header_allocation(psf, v44) )
          {
            indx = psf->header.indx;
LABEL_87:
            memcpy(&psf->header.ptr[indx], v16, v44);
            psf->header.indx += v44;
            v6 += v44;
          }
          goto LABEL_6;
        case 'd':
          if ( (unsigned __int64)(int)va[0].fp_offset > 0xA0 )
            va_arg(va, _QWORD);
          else
            va[0].fp_offset += 16;
          v23 = &psf->header.ptr[psf->header.indx];
          if ( psf->rwf_endian == 0x20000000 )
            double64_be_write(v2, v23);
          else
            double64_le_write(v2, v23);
          psf->header.indx += 8LL;
          v6 += 8;
          goto LABEL_6;
        case 'e':
          psf->rwf_endian = 0x10000000;
          goto LABEL_6;
        case 'f':
          if ( (unsigned __int64)(int)va[0].fp_offset > 0xA0 )
            va_arg(va, _QWORD);
          else
            va[0].fp_offset += 16;
          v46 = &psf->header.ptr[psf->header.indx];
          if ( psf->rwf_endian == 0x20000000 )
            float32_be_write(*(float *)&v2, v46);
          else
            float32_le_write(*(float *)&v2, v46);
          psf->header.indx += 4LL;
          v6 += 4;
          goto LABEL_6;
        case 'h':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v24 = va_arg(va, _QWORD);
            v8 = &v24;
          }
          else
          {
            v8 = (__int64 *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          *(_OWORD *)&psf->header.ptr[psf->header.indx] = *(_OWORD *)*v8;
          psf->header.indx += 16LL;
          v6 += 16;
          goto LABEL_6;
        case 'j':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v47 = va_arg(va, _QWORD);
            v18 = &v47;
          }
          else
          {
            v18 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v48 = *v18;
          v49 = *v18 + psf->header.indx;
          if ( v49 <= psf->header.len )
            goto LABEL_95;
          if ( !psf_bump_header_allocation(psf, v48) )
          {
            v49 = v48 + psf->header.indx;
LABEL_95:
            psf->header.indx = v49;
            v6 += v48;
          }
          goto LABEL_6;
        case 'm':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v50 = va_arg(va, _QWORD);
            v19 = (int *)&v50;
          }
          else
          {
            v19 = (int *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          header_put_marker(psf, *v19);
          v6 += 4;
          goto LABEL_6;
        case 'o':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v51 = va_arg(va, _QWORD);
            v20 = &v51;
          }
          else
          {
            v20 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v52 = *v20;
          if ( *v20 < psf->header.len || !psf_bump_header_allocation(psf, *v20) )
            psf->header.indx = v52;
          goto LABEL_6;
        case 'p':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v53 = va_arg(va, _QWORD);
            v21 = (const char **)&v53;
          }
          else
          {
            v21 = (const char **)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v54 = *v21;
          v55 = strlen(*v21);
          v56 = v55 + ((v55 & 1) == 0);
          if ( v56 >= 0xFE )
            v56 = 254LL;
          if ( (signed __int64)(v56 + psf->header.indx) <= psf->header.len || !psf_bump_header_allocation(psf, v56) )
          {
            header_put_byte(psf, v56);
            memcpy(&psf->header.ptr[psf->header.indx], v54, v56);
            psf->header.indx += v56;
            v6 += v56 + 1;
          }
          goto LABEL_6;
        case 's':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v25 = va_arg(va, _QWORD);
            v9 = (const char **)&v25;
          }
          else
          {
            v9 = (const char **)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v26 = *v9;
          v27 = strlen(*v9);
          v28 = (((_BYTE)v27 + 1) & 1) + v27 + 1;
          if ( v28 + psf->header.indx >= psf->header.len && psf_bump_header_allocation(psf, 16LL) )
            return v6;
          if ( psf->rwf_endian == 0x20000000 )
            header_put_be_int(psf, v28);
          else
            header_put_le_int(psf, v28);
          memcpy(&psf->header.ptr[psf->header.indx], v26, v28);
          v61 = psf->header.indx + v28;
          psf->header.indx = v61;
          psf->header.ptr[v61 - 1] = 0;
          v6 += v28 + 4;
          goto LABEL_6;
        case 't':
          v68 = 1;
          goto LABEL_6;
        case 'z':
          if ( (unsigned __int64)(int)va[0].gp_offset > 0x28 )
          {
            v57 = va_arg(va, _QWORD);
            v22 = &v57;
          }
          else
          {
            v22 = (sf_count_t *)((char *)va[0].reg_save_area + (int)va[0].gp_offset);
            va[0].gp_offset += 8;
          }
          v58 = *v22;
          if ( *v22 + psf->header.indx > psf->header.len && psf_bump_header_allocation(psf, v58) )
            goto LABEL_6;
          v6 += v58;
          if ( !v58 )
            goto LABEL_6;
          v59 = psf->header.indx;
          if ( (v58 & 1) != 0 )
          {
            psf->header.ptr[v59] = 0;
            v59 = psf->header.indx + 1;
            psf->header.indx = v59;
            v60 = v58 - 1;
            if ( v58 == 1 )
              goto LABEL_6;
          }
          else
          {
            v60 = v58;
            if ( v58 == 1 )
              goto LABEL_6;
          }
          do
          {
            psf->header.ptr[v59] = 0;
            ptr = psf->header.ptr;
            v65 = psf->header.indx;
            psf->header.indx = v65 + 1;
            ptr[v65 + 1] = 0;
            v59 = psf->header.indx + 1;
            psf->header.indx = v59;
            v60 -= 2LL;
          }
          while ( v60 );
          goto LABEL_6;
        default:
          psf_log_printf(psf, "*** Invalid format specifier `%c'\n", (unsigned int)v5);
          psf->error = 29;
          goto LABEL_6;
      }
    }
  }
  return 0;
}
