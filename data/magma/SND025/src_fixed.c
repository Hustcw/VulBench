static int wav_write_header(SF_PRIVATE *psf, int calc_length) {
  sf_count_t current;
  int error, has_data = SF_FALSE;

  current = psf_ftell(psf);

  if (current > psf->dataoffset)
    has_data = SF_TRUE;

  if (calc_length) {
    psf->filelength = psf_get_filelen(psf);

    psf->datalength = psf->filelength - psf->dataoffset;

    if (psf->dataend)
      psf->datalength -= psf->filelength - psf->dataend;
    else if (psf->bytewidth > 0 && psf->sf.seekable == SF_TRUE)
      psf->datalength = psf->sf.frames * psf->bytewidth * psf->sf.channels;
  };

  /* Reset the current header length to zero. */
  psf->header.ptr[0] = 0;
  psf->header.indx = 0;
  psf_fseek(psf, 0, SEEK_SET);

  /*
  ** RIFX signifies big-endian format for all header and data.
  ** To prevent lots of code copying here, we'll set the psf->rwf_endian flag
  ** once here, and never specify endian-ness for all other header operations.
  */

  /* RIFF/RIFX marker, length, WAVE and 'fmt ' markers. */

  if (psf->endian == SF_ENDIAN_LITTLE)
    psf_binheader_writef(psf, "etm8", BHWm(RIFF_MARKER),
                         BHW8((psf->filelength < 8) ? 8 : psf->filelength - 8));
  else
    psf_binheader_writef(psf, "Etm8", BHWm(RIFX_MARKER),
                         BHW8((psf->filelength < 8) ? 8 : psf->filelength - 8));

  /* WAVE and 'fmt ' markers. */
  psf_binheader_writef(psf, "mm", BHWm(WAVE_MARKER), BHWm(fmt_MARKER));

  /* Write the 'fmt ' chunk. */
  switch (SF_CONTAINER(psf->sf.format)) {
  case SF_FORMAT_WAV:
    if ((error = wav_write_fmt_chunk(psf)) != 0)
      return error;
    break;

  case SF_FORMAT_WAVEX:
    if ((error = wavex_write_fmt_chunk(psf)) != 0)
      return error;
    break;

  default:
    return SFE_UNIMPLEMENTED;
  };

  /* The LIST/INFO chunk. */
  if (psf->strings.flags & SF_STR_LOCATE_START)
    wavlike_write_strings(psf, SF_STR_LOCATE_START);

  if (psf->peak_info != NULL && psf->peak_info->peak_loc == SF_PEAK_START)
    wavlike_write_peak_chunk(psf);

  if (psf->broadcast_16k != NULL)
    wavlike_write_bext_chunk(psf);

  if (psf->cart_16k != NULL)
    wavlike_write_cart_chunk(psf);

  if (psf->cues != NULL) {
    uint32_t k;

    psf_binheader_writef(psf, "em44", BHWm(cue_MARKER),
                         BHW4(4 + psf->cues->cue_count * 6 * 4),
                         BHW4(psf->cues->cue_count));

    for (k = 0; k < psf->cues->cue_count; k++)
      psf_binheader_writef(psf, "e44m444", BHW4(psf->cues->cue_points[k].indx),
                           BHW4(psf->cues->cue_points[k].position),
                           BHWm(psf->cues->cue_points[k].fcc_chunk),
                           BHW4(psf->cues->cue_points[k].chunk_start),
                           BHW4(psf->cues->cue_points[k].block_start),
                           BHW4(psf->cues->cue_points[k].sample_offset));
  };

  if (psf->instrument != NULL) {
    int tmp;
    double dtune = (double)(0x40000000) / 25.0;

    psf_binheader_writef(psf, "m4", BHWm(smpl_MARKER),
                         BHW4(9 * 4 + psf->instrument->loop_count * 6 * 4));
    psf_binheader_writef(psf, "44", BHW4(0),
                         BHW4(0));           /* Manufacturer zero is everyone */
    tmp = (int)(1.0e9 / psf->sf.samplerate); /* Sample period in nano seconds */
    psf_binheader_writef(psf, "44", BHW4(tmp), BHW4(psf->instrument->basenote));
    tmp = (uint32_t)(psf->instrument->detune * dtune + 0.5);
    psf_binheader_writef(psf, "4", BHW4(tmp));
    psf_binheader_writef(psf, "44", BHW4(0), BHW4(0)); /* SMTPE format */
    psf_binheader_writef(psf, "44", BHW4(psf->instrument->loop_count), BHW4(0));

    /* Make sure we don't read past the loops array end. */
    if (psf->instrument->loop_count > ARRAY_LEN(psf->instrument->loops))
      psf->instrument->loop_count = ARRAY_LEN(psf->instrument->loops);

    for (tmp = 0; tmp < psf->instrument->loop_count; tmp++) {
      int type;

      type = psf->instrument->loops[tmp].mode;
      type = (type == SF_LOOP_FORWARD       ? 0
              : type == SF_LOOP_BACKWARD    ? 2
              : type == SF_LOOP_ALTERNATING ? 1
                                            : 32);

      psf_binheader_writef(psf, "44", BHW4(tmp), BHW4(type));
      psf_binheader_writef(psf, "44", BHW4(psf->instrument->loops[tmp].start),
                           BHW4(psf->instrument->loops[tmp].end - 1));
      psf_binheader_writef(psf, "44", BHW4(0),
                           BHW4(psf->instrument->loops[tmp].count));
    };
  };

  /* Write custom headers. */
  if (psf->wchunks.used > 0)
    wavlike_write_custom_chunks(psf);

  if (psf->header.indx + 16 <
      psf->dataoffset) { /* Add PAD data if necessary. */
    size_t k = psf->dataoffset - (psf->header.indx + 16);
    psf_binheader_writef(psf, "m4z", BHWm(PAD_MARKER), BHW4(k), BHWz(k));
  };

  psf_binheader_writef(psf, "tm8", BHWm(data_MARKER), BHW8(psf->datalength));
  psf_fwrite(psf->header.ptr, psf->header.indx, 1, psf);
  if (psf->error)
    return psf->error;

  if (has_data && psf->dataoffset != psf->header.indx) {
    psf_log_printf(
        psf, "Oooops : has_data && psf->dataoffset != psf->header.indx\n");
    return psf->error = SFE_INTERNAL;
  };

  psf->dataoffset = psf->header.indx;

  if (!has_data)
    psf_fseek(psf, psf->dataoffset, SEEK_SET);
  else if (current > 0)
    psf_fseek(psf, current, SEEK_SET);

  return psf->error;
} /* wav_write_header */
