static int paf_read_header(SF_PRIVATE *psf) {
  PAF_FMT paf_fmt;
  int marker;

  if (psf->filelength < PAF_HEADER_LENGTH)
    return SFE_PAF_SHORT_HEADER;

  memset(&paf_fmt, 0, sizeof(paf_fmt));
  psf_binheader_readf(psf, "pm", 0, &marker);

  psf_log_printf(psf, "Signature   : '%M'\n", marker);

  if (marker == PAF_MARKER) {
    psf_binheader_readf(psf, "E444444", &(paf_fmt.version),
                        &(paf_fmt.endianness), &(paf_fmt.samplerate),
                        &(paf_fmt.format), &(paf_fmt.channels),
                        &(paf_fmt.source));
  } else if (marker == FAP_MARKER) {
    psf_binheader_readf(psf, "e444444", &(paf_fmt.version),
                        &(paf_fmt.endianness), &(paf_fmt.samplerate),
                        &(paf_fmt.format), &(paf_fmt.channels),
                        &(paf_fmt.source));
  } else
    return SFE_PAF_NO_MARKER;

  psf_log_printf(psf, "Version     : %d\n", paf_fmt.version);

  if (paf_fmt.version != 0) {
    psf_log_printf(psf, "*** Bad version number. should be zero.\n");
    return SFE_PAF_VERSION;
  };

  psf_log_printf(psf, "Sample Rate : %d\n", paf_fmt.samplerate);
  psf_log_printf(psf, "Channels    : %d\n", paf_fmt.channels);

  psf_log_printf(psf, "Endianness  : %d => ", paf_fmt.endianness);
  if (paf_fmt.endianness) {
    psf_log_printf(psf, "Little\n", paf_fmt.endianness);
    psf->endian = SF_ENDIAN_LITTLE;
  } else {
    psf_log_printf(psf, "Big\n", paf_fmt.endianness);
    psf->endian = SF_ENDIAN_BIG;
  };

  if (paf_fmt.channels < 1 || paf_fmt.channels > SF_MAX_CHANNELS)
    return SFE_PAF_BAD_CHANNELS;

  psf->datalength = psf->filelength - psf->dataoffset;

  psf_binheader_readf(psf, "p", (int)psf->dataoffset);

  psf->sf.samplerate = paf_fmt.samplerate;
  psf->sf.channels = paf_fmt.channels;

  /* Only fill in type major. */
  psf->sf.format = SF_FORMAT_PAF;

  psf_log_printf(psf, "Format      : %d => ", paf_fmt.format);

  /* PAF is by default big endian. */
  psf->sf.format |= paf_fmt.endianness ? SF_ENDIAN_LITTLE : SF_ENDIAN_BIG;

  switch (paf_fmt.format) {
  case PAF_PCM_S8:
    psf_log_printf(psf, "8 bit linear PCM\n");
    psf->bytewidth = 1;

    psf->sf.format |= SF_FORMAT_PCM_S8;

    psf->blockwidth = psf->bytewidth * psf->sf.channels;
    psf->sf.frames = psf->datalength / psf->blockwidth;
    break;

  case PAF_PCM_16:
    psf_log_printf(psf, "16 bit linear PCM\n");
    psf->bytewidth = 2;

    psf->sf.format |= SF_FORMAT_PCM_16;

    psf->blockwidth = psf->bytewidth * psf->sf.channels;
    psf->sf.frames = psf->datalength / psf->blockwidth;
    break;

  case PAF_PCM_24:
    psf_log_printf(psf, "24 bit linear PCM\n");
    psf->bytewidth = 3;

    psf->sf.format |= SF_FORMAT_PCM_24;

    psf->blockwidth = 0;
    psf->sf.frames = PAF24_SAMPLES_PER_BLOCK * psf->datalength /
                     (PAF24_BLOCK_SIZE * psf->sf.channels);
    break;

  default:
    psf_log_printf(psf, "Unknown\n");
    return SFE_PAF_UNKNOWN_FORMAT;
    break;
  };

  psf_log_printf(psf, "Source      : %d => ", paf_fmt.source);

  switch (paf_fmt.source) {
  case 1:
    psf_log_printf(psf, "Analog Recording\n");
    break;
  case 2:
    psf_log_printf(psf, "Digital Transfer\n");
    break;
  case 3:
    psf_log_printf(psf, "Multi-track Mixdown\n");
    break;
  case 5:
    psf_log_printf(psf, "Audio Resulting From DSP Processing\n");
    break;
  default:
    psf_log_printf(psf, "Unknown\n");
    break;
  };

  return 0;
} /* paf_read_header */
