sf_count_t __fastcall psf_fwrite(const void *ptr, sf_count_t bytes, sf_count_t items, SF_PRIVATE *psf)
{
  sf_count_t result;
  sf_count_t v7;
  sf_count_t v8;
  sf_count_t v9;
  size_t v10;
  char *v11;
  ssize_t v12;
  int v13;
  sf_count_t v14;

  result = 0LL;
  if ( bytes && items )
  {
    if ( psf->virtual_io )
    {
      v7 = psf->vio.write(ptr, bytes * items, psf->vio_user_data);
    }
    else
    {
      v8 = bytes * items;
      if ( bytes * items <= 0 )
        return 0LL;
      v9 = 0LL;
LABEL_9:
      v10 = 0x40000000LL;
      if ( v8 < 1073741825 )
        v10 = v8;
      v14 = v9;
      v11 = (char *)ptr + v9;
      while ( v8 > 0 )
      {
        v12 = write(psf->file.filedes, v11, v10);
        if ( v12 != -1 )
        {
          if ( !v12 )
            break;
          v9 = v12 + v14;
          v8 -= v12;
          goto LABEL_9;
        }
        v13 = *__errno_location();
        if ( v13 != 4 )
        {
          psf_log_syserr(psf, v13);
          break;
        }
      }
      v7 = v14;
      if ( psf->is_pipe )
        psf->pipeoffset += v14;
    }
    return v7 / bytes;
  }
  return result;
}
