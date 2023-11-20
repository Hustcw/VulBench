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
  size_t v6;
  int *v7;
  int tag;
  char v10[4];
  char v11[44];

  v2 = 0;
  v3 = psf_binheader_readf(psf, "444", &tag, v11, v10);
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
      v6 = 4LL * psf->sf.channels;
      free(psf->channel_map);
      v7 = (int *)malloc(v6);
      psf->channel_map = v7;
      if ( v7 )
        memcpy(v7, v5->channel_map, v6);
      else
        return 17;
    }
  }
  return v2;
}
