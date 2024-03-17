int __fastcall php_ifd_get16u(void *value, int motorola_intel)
{
  return (*((unsigned __int8 *)value + (motorola_intel == 0)) << 8) | *((unsigned __int8 *)value + (motorola_intel != 0));
}

__int64 __fastcall exif_process_IFD_TAG_impl(
        image_info_type *ImageInfo,
        char *dir_entry,
        const exif_offset_info *info,
        size_t displacement,
        int section_index,
        int ReadNextIFD,
        tag_table_type tag_table)
{
  int v83;
  __int64 v8;
  unsigned int v9;

  motorola_intel = ImageInfo->motorola_intel;
  v83 = php_ifd_get16u(dir_entry, motorola_intel);
  v8 = (unsigned int)php_ifd_get16u(dir_entry + 2, motorola_intel);
  v9 = php_ifd_get32u(dir_entry + 4, motorola_intel);
}

bool __fastcall exif_process_IFD_TAG(
        image_info_type *ImageInfo,
        char *dir_entry,
        const exif_offset_info *info,
        size_t displacement,
        int section_index,
        int ReadNextIFD,
        tag_table_type tag_table)
{
  int ifd_count;
  int ifd_nesting_level;
  bool result;

  ifd_count = ImageInfo->ifd_count;
  ImageInfo->ifd_count = ifd_count + 1;
  if ( ifd_count >= 1001 )
  {
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "corrupt EXIF header: maximum IFD tag count reached",
      section_index,
      ReadNextIFD);
    return 0;
  }
  ifd_nesting_level = ImageInfo->ifd_nesting_level;
  if ( ifd_nesting_level >= 11 )
  {
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "corrupt EXIF header: maximum directory nesting level reached",
      section_index,
      ReadNextIFD);
    return 0;
  }
  ImageInfo->ifd_nesting_level = ifd_nesting_level + 1;
  result = exif_process_IFD_TAG_impl(ImageInfo, dir_entry, info, displacement, section_index, ReadNextIFD, tag_table);
  --ImageInfo->ifd_nesting_level;
  return result;
}
