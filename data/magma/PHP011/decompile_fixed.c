char *__fastcall exif_offset_info_try_get(const exif_offset_info *info, size_t offset, size_t length)
{
  char *v3;
  char *result;

  if ( ~(__int64)info->offset_base < offset )
    return 0LL;
  v3 = &info->offset_base[offset];
  if ( ~(unsigned __int64)v3 < length || v3 < info->valid_start )
    return 0LL;
  result = 0LL;
  if ( &v3[length] <= info->valid_end )
    return &info->offset_base[offset];
  return result;
}
