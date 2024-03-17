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