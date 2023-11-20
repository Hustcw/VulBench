int __fastcall double64_init(SF_PRIVATE *psf)
{
  __int64 channels;
  int capability;
  int v4;
  int mode;
  int endian;
  int v7;
  int v8;
  sf_count_t (*v9)(sf_private_tag *, double *, sf_count_t);
  sf_count_t (*v10)(sf_private_tag *, float *, sf_count_t);
  sf_count_t (*v11)(sf_private_tag *, int *, sf_count_t);
  sf_count_t (*v12)(sf_private_tag *, short *, sf_count_t);
  int v13;
  int v14;
  sf_count_t filelength;
  sf_count_t dataoffset;
  sf_count_t v17;

  channels = (unsigned int)psf->sf.channels;
  if ( (int)channels <= 0 )
  {
    psf_log_printf(psf, "double64_init : internal error : channels = %d\n", channels);
    return 29;
  }
  capability = double64_get_capability(psf);
  v4 = 8 * psf->sf.channels;
  psf->blockwidth = v4;
  mode = psf->file.mode;
  if ( mode == 16 || mode == 48 )
  {
    endian = psf->endian;
    v8 = endian + capability;
    v9 = host_read_d;
    v10 = host_read_d2f;
    v11 = host_read_d2i;
    v12 = host_read_d2s;
    v13 = 0;
    if ( endian + capability > 536870946 )
    {
      if ( v8 <= 536870980 )
      {
        if ( v8 != 536870947 )
        {
          if ( v8 == 536870964 )
            goto LABEL_24;
LABEL_25:
          if ( (mode | 0x10) != 48 )
            goto LABEL_45;
          goto LABEL_26;
        }
LABEL_23:
        v13 = 1;
        goto LABEL_24;
      }
      if ( v8 == 536870981 )
      {
LABEL_22:
        v9 = replace_read_d;
        v10 = replace_read_d2f;
        v11 = replace_read_d2i;
        v12 = replace_read_d2s;
        goto LABEL_23;
      }
      if ( v8 != 536870998 )
        goto LABEL_25;
    }
    else
    {
      if ( v8 <= 268435524 )
      {
        if ( v8 != 268435491 )
        {
          if ( v8 != 268435508 )
            goto LABEL_25;
          goto LABEL_23;
        }
LABEL_24:
        psf->data_endswap = v13;
        psf->read_short = v12;
        psf->read_int = v11;
        psf->read_float = v10;
        psf->read_double = v9;
        goto LABEL_25;
      }
      if ( v8 != 268435525 )
      {
        if ( v8 != 268435542 )
          goto LABEL_25;
        goto LABEL_22;
      }
    }
    v9 = replace_read_d;
    v10 = replace_read_d2f;
    v11 = replace_read_d2i;
    v12 = replace_read_d2s;
    goto LABEL_24;
  }
  if ( mode != 32 )
    goto LABEL_45;
  endian = psf->endian;
LABEL_26:
  v14 = capability + endian;
  if ( v14 <= 536870946 )
  {
    if ( v14 <= 268435524 )
    {
      if ( v14 != 268435491 )
      {
        if ( v14 != 268435508 )
          goto LABEL_45;
        goto LABEL_41;
      }
      goto LABEL_34;
    }
    if ( v14 != 268435525 )
    {
      if ( v14 != 268435542 )
        goto LABEL_45;
      goto LABEL_43;
    }
    goto LABEL_40;
  }
  if ( v14 > 536870980 )
  {
    if ( v14 == 536870981 )
    {
LABEL_43:
      psf->data_endswap = 1;
      goto LABEL_44;
    }
    if ( v14 == 536870998 )
    {
LABEL_40:
      psf->data_endswap = 0;
LABEL_44:
      psf->write_short = replace_write_s2d;
      psf->write_int = replace_write_i2d;
      psf->write_float = replace_write_f2d;
      psf->write_double = replace_write_d;
    }
  }
  else
  {
    if ( v14 == 536870947 )
    {
LABEL_41:
      psf->data_endswap = 1;
      goto LABEL_42;
    }
    if ( v14 == 536870964 )
    {
LABEL_34:
      psf->data_endswap = 0;
LABEL_42:
      psf->write_short = host_write_s2d;
      psf->write_int = host_write_i2d;
      psf->write_float = host_write_f2d;
      psf->write_double = host_write_d;
    }
  }
LABEL_45:
  filelength = psf->filelength;
  dataoffset = psf->dataoffset;
  v7 = 0;
  if ( filelength <= dataoffset )
  {
    v17 = 0LL;
  }
  else
  {
    if ( psf->dataend > 0 )
      filelength = psf->dataend;
    v17 = filelength - dataoffset;
  }
  psf->datalength = v17;
  psf->sf.frames = v17 / v4;
  return v7;
}
