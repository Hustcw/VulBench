/* Base address for offset references, together with valid memory range.
 * The valid range does not necessarily include the offset base. */
typedef struct {
	char *offset_base;
	char *valid_start; /* inclusive */
	char *valid_end;   /* exclusive */
} exif_offset_info;

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
