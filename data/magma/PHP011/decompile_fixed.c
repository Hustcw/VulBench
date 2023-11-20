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


void __fastcall exif_thumbnail_extract(image_info_type *ImageInfo, const exif_offset_info *info)
{
  size_t size;
  char *v3;

  if ( ImageInfo->Thumbnail.data )
  {
    exif_error_docref("exif_read_data#error_mult_thumb", ImageInfo, 2, "Multiple possible thumbnails");
  }
  else if ( ImageInfo->read_thumbnail )
  {
    size = ImageInfo->Thumbnail.size;
    if ( size - 1 <= 0xFFFE && ImageInfo->Thumbnail.offset )
    {
      v3 = exif_offset_info_try_get(info, ImageInfo->Thumbnail.offset, ImageInfo->Thumbnail.size);
      if ( v3 )
      {
        ImageInfo->Thumbnail.data = estrndup(v3, size);
        exif_thumbnail_build(ImageInfo);
      }
      else
      {
        exif_error_docref(0LL, ImageInfo, 2, "%s", "Thumbnail goes IFD boundary or end of file reached");
      }
    }
    else
    {
      exif_error_docref(0LL, ImageInfo, 2, "Illegal thumbnail size/offset");
    }
  }
}
