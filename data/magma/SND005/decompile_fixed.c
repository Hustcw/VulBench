const AIFF_CAF_CHANNEL_MAP *__fastcall aiff_caf_of_channel_layout_tag(int tag)
{
  const AIFF_CAF_CHANNEL_MAP *result;
  unsigned __int64 v2;

  if ( (unsigned __int16)tag > 8u )
    return 0LL;
  result = map[(unsigned __int16)tag].map;
  v2 = 0LL;
  while ( result->channel_layout_tag != tag )
  {
    ++v2;
    ++result;
    if ( v2 >= (unsigned int)map[(unsigned __int16)tag].len )
      return 0LL;
  }
  return result;
}


int __fastcall aiff_read_chanmap(SF_PRIVATE *psf, unsigned int dword)
{
  int v2;
  unsigned int v3;
  const AIFF_CAF_CHANNEL_MAP *v4;
  const AIFF_CAF_CHANNEL_MAP *v5;
  int channels;
  size_t v7;
  int *v8;
  int tag;
  char v11[4];
  char v12[52];

  v2 = 0;
  v3 = psf_binheader_readf(psf, "444", &tag, v12, v11);
  v4 = aiff_caf_of_channel_layout_tag(tag);
  if ( v4 )
  {
    v5 = v4;
    v2 = 0;
    psf_log_printf(psf, "  Tag    : %x\n", (unsigned int)tag);
    psf_log_printf(psf, "  Layout : %s\n", v5->name);
    if ( v3 < dword )
      psf_binheader_readf(psf, "j", dword - v3);
    if ( v5->channel_map )
    {
      channels = (unsigned __int16)tag;
      if ( psf->sf.channels <= (unsigned __int16)tag )
        channels = psf->sf.channels;
      v7 = 4LL * channels;
      free(psf->channel_map);
      v8 = (int *)malloc(v7);
      psf->channel_map = v8;
      if ( v8 )
        memcpy(v8, v5->channel_map, v7);
      else
        return 17;
    }
  }
  return v2;
}
