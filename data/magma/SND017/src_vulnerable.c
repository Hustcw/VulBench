int wavlike_read_fmt_chunk(SF_PRIVATE *psf, int fmtsize) {
  WAVLIKE_PRIVATE *wpriv;
  WAV_FMT *wav_fmt;
  int bytesread, k, bytespersec = 0;

  if ((wpriv = psf->container_data) == NULL)
    return SFE_INTERNAL;
  wav_fmt = &wpriv->wav_fmt;

  memset(wav_fmt, 0, sizeof(WAV_FMT));

  if (fmtsize < 16)
    return SFE_WAV_FMT_SHORT;

  /* assume psf->rwf_endian is already properly set */

  /* Read the minimal WAV file header here. */
  bytesread = psf_binheader_readf(
      psf, "224422", &(wav_fmt->format), &(wav_fmt->min.channels),
      &(wav_fmt->min.samplerate), &(wav_fmt->min.bytespersec),
      &(wav_fmt->min.blockalign), &(wav_fmt->min.bitwidth));

  psf_log_printf(psf, "  Format        : 0x%X => %s\n", wav_fmt->format,
                 wavlike_format_str(wav_fmt->format));
  psf_log_printf(psf, "  Channels      : %d\n", wav_fmt->min.channels);
  psf_log_printf(psf, "  Sample Rate   : %d\n", wav_fmt->min.samplerate);

  if (wav_fmt->format == WAVE_FORMAT_PCM && wav_fmt->min.blockalign == 0 &&
      wav_fmt->min.bitwidth > 0 && wav_fmt->min.channels > 0) {
    wav_fmt->min.blockalign =
        wav_fmt->min.bitwidth / 8 + (wav_fmt->min.bitwidth % 8 > 0 ? 1 : 0);
    wav_fmt->min.blockalign *= wav_fmt->min.channels;
    psf_log_printf(psf, "  Block Align   : 0 (should be %d)\n",
                   wav_fmt->min.blockalign);
  } else
    psf_log_printf(psf, "  Block Align   : %d\n", wav_fmt->min.blockalign);

  if (wav_fmt->format == WAVE_FORMAT_PCM && wav_fmt->min.bitwidth == 24 &&
      wav_fmt->min.blockalign == 4 * wav_fmt->min.channels) {
    psf_log_printf(psf, "  Bit Width     : 24\n");

    psf_log_printf(
        psf,
        "\n"
        "  Ambiguous information in 'fmt ' chunk. Possibile file types:\n"
        "    0) Invalid IEEE float file generated by Syntrillium's Cooledit!\n"
        "    1) File generated by ALSA's arecord containing 24 bit samples in "
        "32 bit containers.\n"
        "    2) 24 bit file with incorrect Block Align value.\n"
        "\n");

    wpriv->fmt_is_broken = 1;
  } else if (wav_fmt->min.bitwidth == 0) {
    switch (wav_fmt->format) {
    case WAVE_FORMAT_GSM610:
    case WAVE_FORMAT_IPP_ITU_G_723_1:
      psf_log_printf(psf, "  Bit Width     : %d\n", wav_fmt->min.bitwidth);
      break;
    default:
      psf_log_printf(psf, "  Bit Width     : %d (should not be 0)\n",
                     wav_fmt->min.bitwidth);
    }
  } else {
    switch (wav_fmt->format) {
    case WAVE_FORMAT_GSM610:
    case WAVE_FORMAT_IPP_ITU_G_723_1:
      psf_log_printf(psf, "  Bit Width     : %d (should be 0)\n",
                     wav_fmt->min.bitwidth);
      break;
    default:
      psf_log_printf(psf, "  Bit Width     : %d\n", wav_fmt->min.bitwidth);
    }
  };

  psf->sf.samplerate = wav_fmt->min.samplerate;
  psf->sf.frames = 0; /* Correct this when reading data chunk. */
  psf->sf.channels = wav_fmt->min.channels;

  switch (wav_fmt->format) {
  case WAVE_FORMAT_PCM:
  case WAVE_FORMAT_IEEE_FLOAT:
    bytespersec = wav_fmt->min.samplerate * wav_fmt->min.blockalign;
    if (wav_fmt->min.bytespersec != (unsigned)bytespersec)
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->min.bytespersec, bytespersec);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->min.bytespersec);

    psf->bytewidth = BITWIDTH2BYTES(wav_fmt->min.bitwidth);
    break;

  case WAVE_FORMAT_ALAW:
  case WAVE_FORMAT_MULAW:
    if (wav_fmt->min.bytespersec !=
        wav_fmt->min.samplerate * wav_fmt->min.blockalign)
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->min.bytespersec,
                     wav_fmt->min.samplerate * wav_fmt->min.blockalign);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->min.bytespersec);

    psf->bytewidth = 1;
    if (fmtsize >= 18) {
      bytesread += psf_binheader_readf(psf, "2", &(wav_fmt->size20.extrabytes));
      psf_log_printf(psf, "  Extra Bytes   : %d\n", wav_fmt->size20.extrabytes);
    };
    break;

  case WAVE_FORMAT_IMA_ADPCM:
    if (wav_fmt->min.bitwidth != 4)
      return SFE_WAV_ADPCM_NOT4BIT;
    if (wav_fmt->min.channels < 1 || wav_fmt->min.channels > 2)
      return SFE_WAV_ADPCM_CHANNELS;

    bytesread += psf_binheader_readf(psf, "22", &(wav_fmt->ima.extrabytes),
                                     &(wav_fmt->ima.samplesperblock));
    psf_log_printf(psf, "  Extra Bytes   : %d\n", wav_fmt->ima.extrabytes);
    if (wav_fmt->ima.samplesperblock < 1) {
      psf_log_printf(psf, "  Samples/Block : %d (should be > 0)\n",
                     wav_fmt->ima.samplesperblock);
      return SFE_WAV_ADPCM_SAMPLES;
    } else
      psf_log_printf(psf, "  Samples/Block : %d\n",
                     wav_fmt->ima.samplesperblock);

    bytespersec = (wav_fmt->ima.samplerate * wav_fmt->ima.blockalign) /
                  wav_fmt->ima.samplesperblock;
    if (wav_fmt->ima.bytespersec != (unsigned)bytespersec)
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->ima.bytespersec, bytespersec);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->ima.bytespersec);

    break;

  case WAVE_FORMAT_MS_ADPCM:
    if (wav_fmt->msadpcm.bitwidth != 4)
      return SFE_WAV_ADPCM_NOT4BIT;
    if (wav_fmt->msadpcm.channels < 1 || wav_fmt->msadpcm.channels > 2)
      return SFE_WAV_ADPCM_CHANNELS;

    bytesread += psf_binheader_readf(psf, "222", &(wav_fmt->msadpcm.extrabytes),
                                     &(wav_fmt->msadpcm.samplesperblock),
                                     &(wav_fmt->msadpcm.numcoeffs));

    psf_log_printf(psf, "  Extra Bytes   : %d\n", wav_fmt->msadpcm.extrabytes);
    if (wav_fmt->ima.samplesperblock < 1) {
      psf_log_printf(psf, "  Samples/Block : %d (should be > 0)\n",
                     wav_fmt->ima.samplesperblock);
      return SFE_WAV_ADPCM_SAMPLES;
    } else
      psf_log_printf(psf, "  Samples/Block : %d\n",
                     wav_fmt->ima.samplesperblock);

    bytespersec = (wav_fmt->min.samplerate * wav_fmt->min.blockalign) /
                  wav_fmt->msadpcm.samplesperblock;
    if (wav_fmt->min.bytespersec == (unsigned)bytespersec)
      psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->min.bytespersec);
    else if (wav_fmt->min.bytespersec ==
             (wav_fmt->min.samplerate / wav_fmt->msadpcm.samplesperblock) *
                 wav_fmt->min.blockalign)
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d (MS BUG!))\n",
                     wav_fmt->min.bytespersec, bytespersec);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->min.bytespersec, bytespersec);

    if (wav_fmt->msadpcm.numcoeffs > ARRAY_LEN(wav_fmt->msadpcm.coeffs)) {
      psf_log_printf(psf, "  No. of Coeffs : %d (should be <= %d)\n",
                     wav_fmt->msadpcm.numcoeffs,
                     ARRAY_LEN(wav_fmt->msadpcm.coeffs));
      wav_fmt->msadpcm.numcoeffs = ARRAY_LEN(wav_fmt->msadpcm.coeffs);
    } else
      psf_log_printf(psf, "  No. of Coeffs : %d\n", wav_fmt->msadpcm.numcoeffs);

    psf_log_printf(psf, "    Index   Coeffs1   Coeffs2\n");
    for (k = 0; k < wav_fmt->msadpcm.numcoeffs; k++) {
      char buffer[128];

      bytesread +=
          psf_binheader_readf(psf, "22", &(wav_fmt->msadpcm.coeffs[k].coeff1),
                              &(wav_fmt->msadpcm.coeffs[k].coeff2));
      snprintf(buffer, sizeof(buffer), "     %2d     %7d   %7d\n", k,
               wav_fmt->msadpcm.coeffs[k].coeff1,
               wav_fmt->msadpcm.coeffs[k].coeff2);
      psf_log_printf(psf, buffer);
    };
    break;

  case WAVE_FORMAT_GSM610:
    if (wav_fmt->gsm610.channels != 1 || wav_fmt->gsm610.blockalign != 65)
      return SFE_WAV_GSM610_FORMAT;

    bytesread += psf_binheader_readf(psf, "22", &(wav_fmt->gsm610.extrabytes),
                                     &(wav_fmt->gsm610.samplesperblock));

    if (wav_fmt->gsm610.samplesperblock != 320)
      return SFE_WAV_GSM610_FORMAT;

    bytespersec = (wav_fmt->gsm610.samplerate * wav_fmt->gsm610.blockalign) /
                  wav_fmt->gsm610.samplesperblock;
    if (wav_fmt->gsm610.bytespersec != (unsigned)bytespersec)
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->gsm610.bytespersec, bytespersec);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d\n",
                     wav_fmt->gsm610.bytespersec);

    psf_log_printf(psf, "  Extra Bytes   : %d\n", wav_fmt->gsm610.extrabytes);
    psf_log_printf(psf, "  Samples/Block : %d\n",
                   wav_fmt->gsm610.samplesperblock);
    break;

  case WAVE_FORMAT_EXTENSIBLE:
    if (wav_fmt->ext.bytespersec !=
        wav_fmt->ext.samplerate * wav_fmt->ext.blockalign)
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->ext.bytespersec,
                     wav_fmt->ext.samplerate * wav_fmt->ext.blockalign);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->ext.bytespersec);

    bytesread += psf_binheader_readf(psf, "224", &(wav_fmt->ext.extrabytes),
                                     &(wav_fmt->ext.validbits),
                                     &(wav_fmt->ext.channelmask));

    psf_log_printf(psf, "  Valid Bits    : %d\n", wav_fmt->ext.validbits);

    if (wav_fmt->ext.channelmask == 0)
      psf_log_printf(psf, "  Channel Mask  : 0x0 (should not be zero)\n");
    else {
      char buffer[512];
      unsigned bit;

      wpriv->wavex_channelmask = wav_fmt->ext.channelmask;

      /* It's probably wise to ignore the channel mask if it is all zero */
      free(psf->channel_map);

      if ((psf->channel_map =
               calloc(psf->sf.channels, sizeof(psf->channel_map[0]))) == NULL)
        return SFE_MALLOC_FAILED;

      /* Terminate the buffer we're going to append_snprintf into. */
      buffer[0] = 0;

      for (bit = k = 0; bit < ARRAY_LEN(channel_mask_bits); bit++)
      {
        if (wav_fmt->ext.channelmask & (1 << bit)) {
          if (k > psf->sf.channels) {
            psf_log_printf(
                psf, "*** More channel map bits than there are channels.\n");
            break;
          };

          psf->channel_map[k++] = channel_mask_bits[bit].id;
          append_snprintf(buffer, sizeof(buffer), "%s, ",
                          channel_mask_bits[bit].name);
        };
      };

      /* Remove trailing ", ". */
      bit = strlen(buffer);
      if (bit >= 2) {
        buffer[--bit] = 0;
        buffer[--bit] = 0;
      };

      if (k != psf->sf.channels) {
        psf_log_printf(psf, "  Channel Mask  : 0x%X\n",
                       wav_fmt->ext.channelmask);
        psf_log_printf(psf,
                       "*** Less channel map bits than there are channels.\n");
      } else
        psf_log_printf(psf, "  Channel Mask  : 0x%X (%s)\n",
                       wav_fmt->ext.channelmask, buffer);
    };

    bytesread += psf_binheader_readf(psf, "422", &(wav_fmt->ext.esf.esf_field1),
                                     &(wav_fmt->ext.esf.esf_field2),
                                     &(wav_fmt->ext.esf.esf_field3));

    /* compare the esf_fields with each known GUID? and print? */
    psf_log_printf(psf, "  Subformat\n");
    psf_log_printf(psf, "    esf_field1 : 0x%X\n", wav_fmt->ext.esf.esf_field1);
    psf_log_printf(psf, "    esf_field2 : 0x%X\n", wav_fmt->ext.esf.esf_field2);
    psf_log_printf(psf, "    esf_field3 : 0x%X\n", wav_fmt->ext.esf.esf_field3);
    psf_log_printf(psf, "    esf_field4 : ");
    for (k = 0; k < 8; k++) {
      bytesread +=
          psf_binheader_readf(psf, "1", &(wav_fmt->ext.esf.esf_field4[k]));
      psf_log_printf(psf, "0x%X ", wav_fmt->ext.esf.esf_field4[k] & 0xFF);
    };
    psf_log_printf(psf, "\n");
    psf->bytewidth = BITWIDTH2BYTES(wav_fmt->ext.bitwidth);

    /* Compare GUIDs for known ones. */
    if (wavex_guid_equal(&wav_fmt->ext.esf, &MSGUID_SUBTYPE_PCM)) {
      psf->sf.format =
          SF_FORMAT_WAVEX | u_bitwidth_to_subformat(psf->bytewidth * 8);
      psf_log_printf(psf, "    format : pcm\n");
    } else if (wavex_guid_equal(&wav_fmt->ext.esf, &MSGUID_SUBTYPE_MS_ADPCM)) {
      psf->sf.format = (SF_FORMAT_WAVEX | SF_FORMAT_MS_ADPCM);
      psf_log_printf(psf, "    format : ms adpcm\n");
    } else if (wavex_guid_equal(&wav_fmt->ext.esf,
                                &MSGUID_SUBTYPE_IEEE_FLOAT)) {
      psf->sf.format =
          SF_FORMAT_WAVEX |
          ((psf->bytewidth == 8) ? SF_FORMAT_DOUBLE : SF_FORMAT_FLOAT);
      psf_log_printf(psf, "    format : IEEE float\n");
    } else if (wavex_guid_equal(&wav_fmt->ext.esf, &MSGUID_SUBTYPE_ALAW)) {
      psf->sf.format = (SF_FORMAT_WAVEX | SF_FORMAT_ALAW);
      psf_log_printf(psf, "    format : A-law\n");
    } else if (wavex_guid_equal(&wav_fmt->ext.esf, &MSGUID_SUBTYPE_MULAW)) {
      psf->sf.format = (SF_FORMAT_WAVEX | SF_FORMAT_ULAW);
      psf_log_printf(psf, "    format : u-law\n");
    } else if (wavex_guid_equal(&wav_fmt->ext.esf,
                                &MSGUID_SUBTYPE_AMBISONIC_B_FORMAT_PCM)) {
      psf->sf.format =
          SF_FORMAT_WAVEX | u_bitwidth_to_subformat(psf->bytewidth * 8);
      psf_log_printf(psf, "    format : pcm (Ambisonic B)\n");
      wpriv->wavex_ambisonic = SF_AMBISONIC_B_FORMAT;
    } else if (wavex_guid_equal(
                   &wav_fmt->ext.esf,
                   &MSGUID_SUBTYPE_AMBISONIC_B_FORMAT_IEEE_FLOAT)) {
      psf->sf.format =
          SF_FORMAT_WAVEX |
          ((psf->bytewidth == 8) ? SF_FORMAT_DOUBLE : SF_FORMAT_FLOAT);
      psf_log_printf(psf, "    format : IEEE float (Ambisonic B)\n");
      wpriv->wavex_ambisonic = SF_AMBISONIC_B_FORMAT;
    } else
      return SFE_UNIMPLEMENTED;

    break;

  case WAVE_FORMAT_G721_ADPCM:
    psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->g72x.bytespersec);
    if (fmtsize >= 20) {
      bytesread += psf_binheader_readf(psf, "22", &(wav_fmt->g72x.extrabytes),
                                       &(wav_fmt->g72x.auxblocksize));
      if (wav_fmt->g72x.extrabytes == 0)
        psf_log_printf(psf, "  Extra Bytes   : %d (should be 2)\n",
                       wav_fmt->g72x.extrabytes);
      else
        psf_log_printf(psf, "  Extra Bytes   : %d\n", wav_fmt->g72x.extrabytes);
      psf_log_printf(psf, "  Aux Blk Size  : %d\n", wav_fmt->g72x.auxblocksize);
    } else if (fmtsize == 18) {
      bytesread += psf_binheader_readf(psf, "2", &(wav_fmt->g72x.extrabytes));
      psf_log_printf(psf, "  Extra Bytes   : %d%s\n", wav_fmt->g72x.extrabytes,
                     wav_fmt->g72x.extrabytes != 0 ? " (should be 0)" : "");
    } else
      psf_log_printf(psf, "*** 'fmt ' chunk should be bigger than this!\n");
    break;

  case WAVE_FORMAT_NMS_VBXADPCM:
    if (wav_fmt->min.channels != 1 || wav_fmt->min.bitwidth < 2 ||
        wav_fmt->min.bitwidth * 20 + 2 != wav_fmt->min.blockalign)
      return SFE_WAV_NMS_FORMAT;

    bytespersec = (wav_fmt->min.samplerate * wav_fmt->min.blockalign) / 160;
    if (wav_fmt->min.bytespersec == (unsigned)bytespersec)
      psf_log_printf(psf, "  Bytes/sec     : %d\n", wav_fmt->min.bytespersec);
    else
      psf_log_printf(psf, "  Bytes/sec     : %d (should be %d)\n",
                     wav_fmt->min.bytespersec, bytespersec);
    if (fmtsize >= 18) {
      bytesread += psf_binheader_readf(psf, "2", &(wav_fmt->size20.extrabytes));
      psf_log_printf(psf, "  Extra Bytes   : %d\n", wav_fmt->size20.extrabytes);
    };
    break;

  default:
    psf_log_printf(psf, "*** No 'fmt ' chunk dumper for this format!\n");
    return SFE_WAV_BAD_FMT;
  };

  if (bytesread > fmtsize) {
    psf_log_printf(psf, "*** wavlike_read_fmt_chunk (bytesread > fmtsize)\n");
    return SFE_WAV_BAD_FMT;
  } else
    psf_binheader_readf(psf, "j", fmtsize - bytesread);

  psf->blockwidth = wav_fmt->min.channels * psf->bytewidth;

  return 0;
} /* wavlike_read_fmt_chunk */

