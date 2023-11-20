int __fastcall wav_write_header(SF_PRIVATE *psf, int calc_length)
{
  __int64 indx;
  sf_count_t dataoffset;
  sf_count_t filelen;
  sf_count_t v5;
  sf_count_t dataend;
  sf_count_t filelength;
  __int64 v8;
  int v9;
  int result;
  PEAK_INFO *peak_info;
  SF_CUES *cues;
  SF_CUES *v13;
  __int64 v14;
  unsigned __int64 v15;
  SF_INSTRUMENT *instrument;
  SF_INSTRUMENT *v17;
  int loop_count;
  __int64 bytewidth;
  __int64 v20;
  __int64 v21;
  __int64 v22;
  int mode;
  sf_count_t v24;
  sf_count_t v25;
  bool v26;
  sf_count_t v27;

  indx = psf_ftell(psf);
  dataoffset = psf->dataoffset;
  if ( calc_length )
  {
    filelen = psf_get_filelen(psf);
    psf->filelength = filelen;
    v5 = psf->dataoffset;
    dataend = psf->dataend;
    psf->datalength = filelen - v5;
    if ( dataend )
    {
      psf->datalength = dataend - v5;
    }
    else
    {
      bytewidth = psf->bytewidth;
      if ( bytewidth > 0 && psf->sf.seekable == 1 )
        psf->datalength = psf->sf.frames * bytewidth * psf->sf.channels;
    }
  }
  *psf->header.ptr = 0;
  psf->header.indx = 0LL;
  psf_fseek(psf, 0LL, 0);
  filelength = psf->filelength;
  v8 = filelength - 8;
  if ( filelength < 8 )
    v8 = 8LL;
  if ( psf->endian == 0x10000000 )
    psf_binheader_writef(psf, "etm8", 1179011410LL, v8);
  else
    psf_binheader_writef(psf, "Etm8", 1481001298LL, v8);
  psf_binheader_writef(psf, "mm", 1163280727LL, 544501094LL);
  v9 = psf->sf.format & 0xFFF0000;
  if ( v9 == 1245184 )
  {
    result = wavex_write_fmt_chunk(psf);
    if ( result )
      return result;
  }
  else
  {
    result = 18;
    if ( v9 != 0x10000 )
      return result;
    result = wav_write_fmt_chunk(psf);
    if ( result )
      return result;
  }
  if ( (psf->strings.flags & 0x400) != 0 )
    wavlike_write_strings(psf, 1024);
  peak_info = psf->peak_info;
  if ( peak_info && peak_info->peak_loc == 42 )
    wavlike_write_peak_chunk(psf);
  if ( psf->broadcast_16k )
    wavlike_write_bext_chunk(psf);
  if ( psf->cart_16k )
    wavlike_write_cart_chunk(psf);
  cues = psf->cues;
  if ( cues )
  {
    psf_binheader_writef(psf, "em44", 543520099LL, (24 * cues->cue_count) | 4);
    v13 = psf->cues;
    if ( v13->cue_count )
    {
      v14 = 24LL;
      v15 = 0LL;
      do
      {
        psf_binheader_writef(
          psf,
          "e44m444",
          *(unsigned int *)((char *)v13 + v14 - 20),
          *(unsigned int *)((char *)v13 + v14 - 16),
          *(unsigned int *)((char *)v13 + v14 - 12),
          *(unsigned int *)((char *)v13 + v14 - 8),
          *(unsigned int *)((char *)v13 + v14 - 4),
          *(unsigned int *)((char *)&v13->cue_count + v14));
        ++v15;
        v13 = psf->cues;
        v14 += 280LL;
      }
      while ( v15 < v13->cue_count );
    }
  }
  instrument = psf->instrument;
  if ( instrument )
  {
    psf_binheader_writef(psf, "m4", 1819307379LL, (unsigned int)(24 * instrument->loop_count + 36));
    psf_binheader_writef(psf, "44", 0LL, 0LL);
    psf_binheader_writef(
      psf,
      "44",
      (unsigned int)(int)(1000000000.0 / (double)psf->sf.samplerate),
      (unsigned int)psf->instrument->basenote);
    psf_binheader_writef(psf, "4", (unsigned int)(int)((double)psf->instrument->detune * 42949672.96 + 0.5));
    psf_binheader_writef(psf, "44", 0LL, 0LL);
    psf_binheader_writef(psf, "44", (unsigned int)psf->instrument->loop_count, 0LL);
    v17 = psf->instrument;
    loop_count = v17->loop_count;
    if ( loop_count < 17 )
    {
      if ( loop_count <= 0 )
        goto LABEL_41;
    }
    else
    {
      v17->loop_count = 16;
    }
    v20 = 0LL;
    v21 = 0LL;
    do
    {
      mode = v17->loops[v20].mode;
      v22 = 0LL;
      if ( mode != 801 )
      {
        if ( mode == 802 )
        {
          v22 = 2LL;
        }
        else
        {
          v22 = 1LL;
          if ( mode != 803 )
            v22 = 32LL;
        }
      }
      psf_binheader_writef(psf, "44", (unsigned int)v21, v22);
      psf_binheader_writef(psf, "44", psf->instrument->loops[v20].start, psf->instrument->loops[v20].end - 1);
      psf_binheader_writef(psf, "44", 0LL, psf->instrument->loops[v20].count);
      ++v21;
      v17 = psf->instrument;
      ++v20;
    }
    while ( v21 < v17->loop_count );
  }
LABEL_41:
  if ( psf->wchunks.used )
    wavlike_write_custom_chunks(psf);
  v24 = psf->header.indx + 16;
  v25 = psf->dataoffset;
  v26 = v25 <= v24;
  v27 = v25 - v24;
  if ( !v26 )
    psf_binheader_writef(psf, "m4z", 541344080LL, v27, v27);
  psf_binheader_writef(psf, "tm8", 1635017060LL, psf->datalength);
  psf_fwrite(psf->header.ptr, psf->header.indx, 1LL, psf);
  result = psf->error;
  if ( !result )
  {
    if ( indx <= dataoffset )
    {
      indx = psf->header.indx;
      psf->dataoffset = indx;
LABEL_51:
      psf_fseek(psf, indx, 0);
      return psf->error;
    }
    if ( psf->dataoffset == psf->header.indx )
    {
      if ( indx <= 0 )
        return psf->error;
      goto LABEL_51;
    }
    psf_log_printf(psf, "Oooops : has_data && psf->dataoffset != psf->header.indx\n");
    psf->error = 29;
    return 29;
  }
  return result;
}
