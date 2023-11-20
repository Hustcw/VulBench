sf_count_t __fastcall psf_fwrite(const void *ptr, sf_count_t bytes, sf_count_t items, SF_PRIVATE *psf)
{
  sf_count_t v6;
  sf_count_t v8;
  size_t v9;
  ssize_t v10;
  int v11;
  const void *v12;

  if ( psf->virtual_io )
  {
    v6 = psf->vio.write(ptr, bytes * items, psf->vio_user_data);
    return v6 / bytes;
  }
  v8 = bytes * items;
  if ( bytes * items > 0 )
  {
    v6 = 0LL;
    v12 = ptr;
LABEL_6:
    v9 = 0x40000000LL;
    if ( v8 < 1073741825 )
      v9 = v8;
    while ( v8 > 0 )
    {
      v10 = write(psf->file.filedes, (char *)ptr + v6, v9);
      if ( v10 != -1 )
      {
        if ( !v10 )
          break;
        v6 += v10;
        v8 -= v10;
        ptr = v12;
        goto LABEL_6;
      }
      v11 = *__errno_location();
      if ( v11 != 4 )
      {
        psf_log_syserr(psf, v11);
        break;
      }
    }
    if ( psf->is_pipe )
      psf->pipeoffset += v6;
    return v6 / bytes;
  }
  return 0LL;
}
