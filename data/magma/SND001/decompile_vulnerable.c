int __fastcall paf_read_header(SF_PRIVATE *psf)
{
  int v1;
  const char *v2;
  int v3;
  int channels;
  sf_count_t datalength;
  __int128 v7;
  __int64 v8[2];
  int v9[5];

  v1 = 101;
  if ( psf->filelength < 2048 )
    return v1;
  v7 = 0LL;
  v8[0] = 0LL;
  psf_binheader_readf(psf, "pm", 0LL, v9);
  psf_log_printf(psf, "Signature   : '%M'\n", (unsigned int)v9[0]);
  if ( v9[0] == 1717661728 )
  {
    v2 = "E444444";
  }
  else
  {
    v1 = 98;
    if ( v9[0] != 544235878 )
      return v1;
    v2 = "e444444";
  }
  psf_binheader_readf(psf, v2, &v7, (char *)&v7 + 4, (char *)&v7 + 8, (char *)&v7 + 12, v8, (char *)v8 + 4);
  psf_log_printf(psf, "Version     : %d\n", (unsigned int)v7);
  if ( (_DWORD)v7 )
  {
    psf_log_printf(psf, "*** Bad version number. should be zero.\n");
    return 99;
  }
  psf_log_printf(psf, "Sample Rate : %d\n", DWORD2(v7));
  psf_log_printf(psf, "Channels    : %d\n", LODWORD(v8[0]));
  psf_log_printf(psf, "Endianness  : %d => ", DWORD1(v7));
  if ( DWORD1(v7) )
  {
    psf_log_printf(psf, "Little\n");
    v3 = 0x10000000;
  }
  else
  {
    psf_log_printf(psf, "Big\n", 0LL);
    v3 = 0x20000000;
  }
  psf->endian = v3;
  psf->datalength = psf->filelength - psf->dataoffset;
  psf_binheader_readf(psf, "p");
  psf->sf.samplerate = DWORD2(v7);
  psf->sf.channels = v8[0];
  psf->sf.format = 327680;
  psf_log_printf(psf, "Format      : %d => ", HIDWORD(v7));
  psf->sf.format |= ((DWORD1(v7) == 0) << 28) + 0x10000000;
  if ( !HIDWORD(v7) )
  {
    psf_log_printf(psf, "16 bit linear PCM\n");
    psf->bytewidth = 2;
    LOBYTE(psf->sf.format) |= 2u;
    channels = 2 * psf->sf.channels;
LABEL_16:
    psf->blockwidth = channels;
    datalength = psf->datalength;
    goto LABEL_18;
  }
  if ( HIDWORD(v7) != 1 )
  {
    if ( HIDWORD(v7) != 2 )
    {
      psf_log_printf(psf, "Unknown\n");
      return 100;
    }
    psf_log_printf(psf, "8 bit linear PCM\n");
    psf->bytewidth = 1;
    LOBYTE(psf->sf.format) |= 1u;
    channels = psf->sf.channels;
    goto LABEL_16;
  }
  psf_log_printf(psf, "24 bit linear PCM\n");
  LOBYTE(psf->sf.format) |= 3u;
  *(_QWORD *)&psf->blockwidth = 0x300000000LL;
  datalength = 10 * psf->datalength;
  channels = 32 * psf->sf.channels;
LABEL_18:
  psf->sf.frames = datalength / channels;
  v1 = 0;
  psf_log_printf(psf, "Source      : %d => ", HIDWORD(v8[0]));
  switch ( HIDWORD(v8[0]) )
  {
    case 1:
      v1 = 0;
      psf_log_printf(psf, "Analog Recording\n");
      break;
    case 2:
      v1 = 0;
      psf_log_printf(psf, "Digital Transfer\n");
      break;
    case 3:
      v1 = 0;
      psf_log_printf(psf, "Multi-track Mixdown\n");
      break;
    case 5:
      v1 = 0;
      psf_log_printf(psf, "Audio Resulting From DSP Processing\n");
      break;
    default:
      psf_log_printf(psf, "Unknown\n");
      break;
  }
  return v1;
}
