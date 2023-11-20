int double64_init(SF_PRIVATE *psf) {
  static int double64_caps;

  if (psf->sf.channels < 1 || psf->sf.channels > SF_MAX_CHANNELS)
  {
    psf_log_printf(psf, "double64_init : internal error : channels = %d\n",
                   psf->sf.channels);
    return SFE_INTERNAL;
  };

  double64_caps = double64_get_capability(psf);

  psf->blockwidth = sizeof(double) * psf->sf.channels;

  if (psf->file.mode == SFM_READ || psf->file.mode == SFM_RDWR) {
    switch (psf->endian + double64_caps) {
    case (SF_ENDIAN_BIG + DOUBLE_CAN_RW_BE):
      psf->data_endswap = SF_FALSE;
      psf->read_short = host_read_d2s;
      psf->read_int = host_read_d2i;
      psf->read_float = host_read_d2f;
      psf->read_double = host_read_d;
      break;

    case (SF_ENDIAN_LITTLE + DOUBLE_CAN_RW_LE):
      psf->data_endswap = SF_FALSE;
      psf->read_short = host_read_d2s;
      psf->read_int = host_read_d2i;
      psf->read_float = host_read_d2f;
      psf->read_double = host_read_d;
      break;

    case (SF_ENDIAN_BIG + DOUBLE_CAN_RW_LE):
      psf->data_endswap = SF_TRUE;
      psf->read_short = host_read_d2s;
      psf->read_int = host_read_d2i;
      psf->read_float = host_read_d2f;
      psf->read_double = host_read_d;
      break;

    case (SF_ENDIAN_LITTLE + DOUBLE_CAN_RW_BE):
      psf->data_endswap = SF_TRUE;
      psf->read_short = host_read_d2s;
      psf->read_int = host_read_d2i;
      psf->read_float = host_read_d2f;
      psf->read_double = host_read_d;
      break;

    /* When the CPU is not IEEE compatible. */
    case (SF_ENDIAN_BIG + DOUBLE_BROKEN_BE):
      psf->data_endswap = SF_FALSE;
      psf->read_short = replace_read_d2s;
      psf->read_int = replace_read_d2i;
      psf->read_float = replace_read_d2f;
      psf->read_double = replace_read_d;
      break;

    case (SF_ENDIAN_LITTLE + DOUBLE_BROKEN_LE):
      psf->data_endswap = SF_FALSE;
      psf->read_short = replace_read_d2s;
      psf->read_int = replace_read_d2i;
      psf->read_float = replace_read_d2f;
      psf->read_double = replace_read_d;
      break;

    case (SF_ENDIAN_BIG + DOUBLE_BROKEN_LE):
      psf->data_endswap = SF_TRUE;
      psf->read_short = replace_read_d2s;
      psf->read_int = replace_read_d2i;
      psf->read_float = replace_read_d2f;
      psf->read_double = replace_read_d;
      break;

    case (SF_ENDIAN_LITTLE + DOUBLE_BROKEN_BE):
      psf->data_endswap = SF_TRUE;
      psf->read_short = replace_read_d2s;
      psf->read_int = replace_read_d2i;
      psf->read_float = replace_read_d2f;
      psf->read_double = replace_read_d;
      break;

    default:
      break;
    };
  };

  if (psf->file.mode == SFM_WRITE || psf->file.mode == SFM_RDWR) {
    switch (psf->endian + double64_caps) {
    case (SF_ENDIAN_LITTLE + DOUBLE_CAN_RW_LE):
      psf->data_endswap = SF_FALSE;
      psf->write_short = host_write_s2d;
      psf->write_int = host_write_i2d;
      psf->write_float = host_write_f2d;
      psf->write_double = host_write_d;
      break;

    case (SF_ENDIAN_BIG + DOUBLE_CAN_RW_BE):
      psf->data_endswap = SF_FALSE;
      psf->write_short = host_write_s2d;
      psf->write_int = host_write_i2d;
      psf->write_float = host_write_f2d;
      psf->write_double = host_write_d;
      break;

    case (SF_ENDIAN_BIG + DOUBLE_CAN_RW_LE):
      psf->data_endswap = SF_TRUE;
      psf->write_short = host_write_s2d;
      psf->write_int = host_write_i2d;
      psf->write_float = host_write_f2d;
      psf->write_double = host_write_d;
      break;

    case (SF_ENDIAN_LITTLE + DOUBLE_CAN_RW_BE):
      psf->data_endswap = SF_TRUE;
      psf->write_short = host_write_s2d;
      psf->write_int = host_write_i2d;
      psf->write_float = host_write_f2d;
      psf->write_double = host_write_d;
      break;

    /* When the CPU is not IEEE compatible. */
    case (SF_ENDIAN_LITTLE + DOUBLE_BROKEN_LE):
      psf->data_endswap = SF_FALSE;
      psf->write_short = replace_write_s2d;
      psf->write_int = replace_write_i2d;
      psf->write_float = replace_write_f2d;
      psf->write_double = replace_write_d;
      break;

    case (SF_ENDIAN_BIG + DOUBLE_BROKEN_BE):
      psf->data_endswap = SF_FALSE;
      psf->write_short = replace_write_s2d;
      psf->write_int = replace_write_i2d;
      psf->write_float = replace_write_f2d;
      psf->write_double = replace_write_d;
      break;

    case (SF_ENDIAN_BIG + DOUBLE_BROKEN_LE):
      psf->data_endswap = SF_TRUE;
      psf->write_short = replace_write_s2d;
      psf->write_int = replace_write_i2d;
      psf->write_float = replace_write_f2d;
      psf->write_double = replace_write_d;
      break;

    case (SF_ENDIAN_LITTLE + DOUBLE_BROKEN_BE):
      psf->data_endswap = SF_TRUE;
      psf->write_short = replace_write_s2d;
      psf->write_int = replace_write_i2d;
      psf->write_float = replace_write_f2d;
      psf->write_double = replace_write_d;
      break;

    default:
      break;
    };
  };

  if (psf->filelength > psf->dataoffset) {
    psf->datalength = (psf->dataend > 0) ? psf->dataend - psf->dataoffset
                                         : psf->filelength - psf->dataoffset;
  } else
    psf->datalength = 0;

  psf->sf.frames = psf->datalength / psf->blockwidth;

  return 0;
} /* double64_init */
