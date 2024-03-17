bool __fastcall exif_process_IFD_in_MAKERNOTE(
        image_info_type *ImageInfo,
        char *value_ptr,
        int value_len,
        const exif_offset_info *info,
        size_t displacement)
{
  char *make;
  int *p_byte_order;
  unsigned __int64 v9;
  __int64 v10;
  size_t v11;
  __int64 v12;
  char *v13;
  int motorola_intel;
  __int64 v15;
  __int64 v16;
  __int64 v17;
  int v18;
  bool v19;
  tag_info_type *tag_table;
  int v21;
  int v23;
  exif_offset_info v26;

  make = ImageInfo->make;
  p_byte_order = (int *)&maker_note_array[0].byte_order;
  v9 = 0LL;
  v10 = 1043116LL;
  if ( make )
    goto LABEL_4;
  while ( 1 )
  {
    do
    {
      ++v9;
      p_byte_order += 10;
      if ( v9 == 20 )
        return 1;
    }
    while ( !make );
LABEL_4:
    if ( !strcmp(*((const char **)p_byte_order - 3), make) )
    {
      if ( !_bittest64(&v10, v9) )
        break;
      v11 = *(p_byte_order - 2);
      if ( (int)v11 > value_len || !strncmp(*((const char **)p_byte_order - 2), value_ptr, v11) )
        break;
    }
  }
  v12 = *(p_byte_order - 1);
  if ( (int)v12 >= value_len )
  {
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "IFD data too short: 0x%04X offset 0x%04X",
      (unsigned int)value_len,
      (unsigned int)v12);
    return 1;
  }
  BYTE1(ImageInfo->sections_found) |= 0x20u;
  v13 = &value_ptr[v12];
  motorola_intel = ImageInfo->motorola_intel;
  v15 = 196615LL;
  v23 = motorola_intel;
  if ( _bittest64(&v15, v9) )
  {
    motorola_intel = *p_byte_order;
    ImageInfo->motorola_intel = *p_byte_order;
  }
  LODWORD(v16) = php_ifd_get16u(v13, motorola_intel);
  v17 = (12 * (_DWORD)v16) | 2u;
  if ( (int)v17 > value_len )
  {
    exif_error_docref(
      0LL,
      ImageInfo,
      8,
      "Potentially invalid endianess, trying again with different endianness before imminent failure.");
    v18 = ImageInfo->motorola_intel == 0;
    ImageInfo->motorola_intel = v18;
    LODWORD(v16) = php_ifd_get16u(v13, v18);
    v17 = (12 * (_DWORD)v16) | 2u;
  }
  if ( (int)v17 > value_len )
  {
    v19 = 0;
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "Illegal IFD size: 2 + 0x%04X*12 = 0x%04X > 0x%04X",
      (unsigned int)v16,
      v17,
      value_len);
    return v19;
  }
  if ( v9 == 15 || v9 == 2 )
  {
    info = &v26;
    exif_offset_info_init(&v26, value_ptr, value_ptr, value_len);
  }
  if ( (int)v16 <= 0 )
  {
LABEL_23:
    ImageInfo->motorola_intel = v23;
    return 1;
  }
  tag_table = (tag_info_type *)*((_QWORD *)p_byte_order - 4);
  v16 = (unsigned int)v16;
  v21 = 0;
  v19 = 0;
  while ( exif_process_IFD_TAG(ImageInfo, &v13[(v21 & 0xFFFFFFFC) + 2], info, displacement, 13, 0, tag_table) )
  {
    v21 += 12;
    if ( !--v16 )
      goto LABEL_23;
  }
  return v19;
}
