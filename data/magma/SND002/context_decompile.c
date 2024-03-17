int __fastcall read_rsrc_short(const SD2_RSRC *prsrc, int offset)
{
  int result;
  __int64 v3;

  result = 0;
  if ( offset >= 0 )
  {
    v3 = offset + 1LL;
    if ( (int)v3 < prsrc->rsrc_len )
      return (prsrc->rsrc_data[offset] << 8) | prsrc->rsrc_data[v3];
  }
  return result;
}