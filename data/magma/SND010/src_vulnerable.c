int psf_binheader_writef(SF_PRIVATE *psf, const char *format, ...) {
  va_list argptr;
  sf_count_t countdata;
  unsigned long longdata;
  unsigned int data;
  float floatdata;
  double doubledata;
  void *bindata;
  size_t size;
  char c, *strptr;
  int count = 0, trunc_8to4 = SF_FALSE;

  if (!format)
    return psf_ftell(psf);

  va_start(argptr, format);

  while ((c = *format++)) {
    if (psf->header.indx + 16 >= psf->header.len &&
        psf_bump_header_allocation(psf, 16))
      break;

    switch (c) {
    case ' ': /* Do nothing. Just used to space out format string. */
      break;

    case 'e': /* All conversions are now from LE to host. */
      psf->rwf_endian = SF_ENDIAN_LITTLE;
      break;

    case 'E': /* All conversions are now from BE to host. */
      psf->rwf_endian = SF_ENDIAN_BIG;
      break;

    case 't': /* All 8 byte values now get written as 4 bytes. */
      trunc_8to4 = SF_TRUE;
      break;

    case 'T': /* All 8 byte values now get written as 8 bytes. */
      trunc_8to4 = SF_FALSE;
      break;

    case 'm':
      data = va_arg(argptr, unsigned int);
      header_put_marker(psf, data);
      count += 4;
      break;

    case '1':
      data = va_arg(argptr, unsigned int);
      header_put_byte(psf, data);
      count += 1;
      break;

    case '2':
      data = va_arg(argptr, unsigned int);
      if (psf->rwf_endian == SF_ENDIAN_BIG) {
        header_put_be_short(psf, data);
      } else {
        header_put_le_short(psf, data);
      };
      count += 2;
      break;

    case '3': /* tribyte */
      data = va_arg(argptr, unsigned int);
      if (psf->rwf_endian == SF_ENDIAN_BIG) {
        header_put_be_3byte(psf, data);
      } else {
        header_put_le_3byte(psf, data);
      };
      count += 3;
      break;

    case '4':
      data = va_arg(argptr, unsigned int);
      if (psf->rwf_endian == SF_ENDIAN_BIG) {
        header_put_be_int(psf, data);
      } else {
        header_put_le_int(psf, data);
      };
      count += 4;
      break;

    case '8':
      countdata = va_arg(argptr, sf_count_t);
      if (psf->rwf_endian == SF_ENDIAN_BIG && trunc_8to4 == SF_FALSE) {
        header_put_be_8byte(psf, countdata);
        count += 8;
      } else if (psf->rwf_endian == SF_ENDIAN_LITTLE &&
                 trunc_8to4 == SF_FALSE) {
        header_put_le_8byte(psf, countdata);
        count += 8;
      } else if (psf->rwf_endian == SF_ENDIAN_BIG && trunc_8to4 == SF_TRUE) {
        longdata = countdata & 0xFFFFFFFF;
        header_put_be_int(psf, longdata);
        count += 4;
      } else if (psf->rwf_endian == SF_ENDIAN_LITTLE && trunc_8to4 == SF_TRUE) {
        longdata = countdata & 0xFFFFFFFF;
        header_put_le_int(psf, longdata);
        count += 4;
      }
      break;

    case 'f':
      /* Floats are passed as doubles. Is this always true? */
      floatdata = (float)va_arg(argptr, double);
      if (psf->rwf_endian == SF_ENDIAN_BIG)
        float32_be_write(floatdata, psf->header.ptr + psf->header.indx);
      else
        float32_le_write(floatdata, psf->header.ptr + psf->header.indx);
      psf->header.indx += 4;
      count += 4;
      break;

    case 'd':
      doubledata = va_arg(argptr, double);
      if (psf->rwf_endian == SF_ENDIAN_BIG)
        double64_be_write(doubledata, psf->header.ptr + psf->header.indx);
      else
        double64_le_write(doubledata, psf->header.ptr + psf->header.indx);
      psf->header.indx += 8;
      count += 8;
      break;

    case 's':
      /* Write a C string (guaranteed to have a zero terminator). */
      strptr = va_arg(argptr, char *);
      size = strlen(strptr) + 1;

      int padding = size & 1;
      size += (size & 1);

      if (psf->header.indx + (sf_count_t)size >= psf->header.len &&
          psf_bump_header_allocation(psf, 16))
        return count;

      if (psf->rwf_endian == SF_ENDIAN_BIG)
        header_put_be_int(psf, size);
      else
        header_put_le_int(psf, size);
      memcpy(&(psf->header.ptr[psf->header.indx]), strptr, size);
      psf->header.indx += size;
      psf->header.ptr[psf->header.indx - 1] = 0;
      count += 4 + size;
      break;

    case 'S':
      /*
      **	Write an AIFF style string (no zero terminator but possibly
      **	an extra pad byte if the string length is odd).
      */
      strptr = va_arg(argptr, char *);
      size = strlen(strptr);
      if (psf->header.indx + 4 + (sf_count_t)size + (sf_count_t)(size & 1) >
              psf->header.len &&
          psf_bump_header_allocation(psf, 4 + size + (size & 1)))
        break;
      if (psf->rwf_endian == SF_ENDIAN_BIG)
        header_put_be_int(psf, size);
      else
        header_put_le_int(psf, size);
      memcpy(&(psf->header.ptr[psf->header.indx]), strptr, size + (size & 1));
      size += (size & 1);
      psf->header.indx += size;
      count += 4 + size;
      break;

    case 'p':
      /* Write a PASCAL string (as used by AIFF files).
       */
      strptr = va_arg(argptr, char *);
      size = strlen(strptr);
      size = (size & 1) ? size : size + 1;
      size = (size > 254) ? 254 : size;

      if (psf->header.indx + 1 + (sf_count_t)size > psf->header.len &&
          psf_bump_header_allocation(psf, 1 + size))
        break;

      header_put_byte(psf, size);
      memcpy(&(psf->header.ptr[psf->header.indx]), strptr, size);
      psf->header.indx += size;
      count += 1 + size;
      break;

    case 'b':
      bindata = va_arg(argptr, void *);
      size = va_arg(argptr, size_t);

      if (psf->header.indx + (sf_count_t)size > psf->header.len &&
          psf_bump_header_allocation(psf, size))
        break;

      memcpy(&(psf->header.ptr[psf->header.indx]), bindata, size);
      psf->header.indx += size;
      count += size;
      break;

    case 'z':
      size = va_arg(argptr, size_t);

      if (psf->header.indx + (sf_count_t)size > psf->header.len &&
          psf_bump_header_allocation(psf, size))
        break;

      count += size;
      while (size) {
        psf->header.ptr[psf->header.indx] = 0;
        psf->header.indx++;
        size--;
      };
      break;

    case 'h':
      bindata = va_arg(argptr, void *);
      memcpy(&(psf->header.ptr[psf->header.indx]), bindata, 16);
      psf->header.indx += 16;
      count += 16;
      break;

    case 'j': /* Jump forwards/backwards by specified amount. */
      size = va_arg(argptr, size_t);

      if (psf->header.indx + (sf_count_t)size > psf->header.len &&
          psf_bump_header_allocation(psf, size))
        break;

      psf->header.indx += size;
      count += size;
      break;

    case 'o': /* Jump to specified offset. */
      size = va_arg(argptr, size_t);

      if ((sf_count_t)size >= psf->header.len &&
          psf_bump_header_allocation(psf, size))
        break;

      psf->header.indx = size;
      break;

    default:
      psf_log_printf(psf, "*** Invalid format specifier `%c'\n", c);
      psf->error = SFE_INTERNAL;
      break;
    };
  };

  va_end(argptr);
  return count;
} /* psf_binheader_writef */

