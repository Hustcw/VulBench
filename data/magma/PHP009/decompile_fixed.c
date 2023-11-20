int __fastcall php_ifd_get16u(void *value, int motorola_intel)
{
  return (*((unsigned __int8 *)value + (motorola_intel == 0)) << 8) | *((unsigned __int8 *)value + (motorola_intel != 0));
}


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
  int v12;
  int motorola_intel;
  __int64 v14;
  unsigned int v15;
  __int64 v16;
  __int64 v17;
  int v18;
  unsigned int v19;
  bool v20;
  size_t v22;
  int v23;
  tag_info_type *tag_table;
  __int64 v25;
  int v26;
  char *value;
  int v28;
  exif_offset_info v31;

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
  if ( value_len < 2 || v12 >= value_len - 1 )
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
  value = &value_ptr[v12];
  motorola_intel = ImageInfo->motorola_intel;
  v14 = 196615LL;
  v28 = motorola_intel;
  if ( _bittest64(&v14, v9) )
  {
    motorola_intel = *p_byte_order;
    ImageInfo->motorola_intel = *p_byte_order;
  }
  v15 = php_ifd_get16u(value, motorola_intel);
  v16 = v15;
  v17 = (12 * v15) | 2;
  if ( (int)v17 > value_len )
  {
    exif_error_docref(
      0LL,
      ImageInfo,
      8,
      "Potentially invalid endianess, trying again with different endianness before imminent failure.",
      v15);
    v18 = ImageInfo->motorola_intel == 0;
    ImageInfo->motorola_intel = v18;
    v19 = php_ifd_get16u(value, v18);
    v16 = v19;
    v17 = (12 * v19) | 2;
  }
  if ( (int)v17 > value_len )
  {
    v20 = 0;
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "Illegal IFD size: 2 + 0x%04X*12 = 0x%04X > 0x%04X",
      v16,
      v17,
      value_len);
    return v20;
  }
  if ( v12 > value_len - (int)v17 )
  {
    v20 = 0;
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "Illegal IFD size: 0x%04X > 0x%04X",
      v12 + (__int64)(int)v17,
      (unsigned int)value_len);
    return v20;
  }
  if ( v9 == 15 || v9 == 2 )
  {
    v22 = value_len;
    info = &v31;
    v23 = v16;
    exif_offset_info_init(&v31, value_ptr, value_ptr, v22);
    LODWORD(v16) = v23;
  }
  if ( (int)v16 <= 0 )
  {
LABEL_28:
    ImageInfo->motorola_intel = v28;
    return 1;
  }
  tag_table = (tag_info_type *)*((_QWORD *)p_byte_order - 4);
  v25 = (unsigned int)v16;
  v26 = 0;
  v20 = 0;
  while ( exif_process_IFD_TAG(ImageInfo, &value[(v26 & 0xFFFFFFFC) + 2], info, displacement, 13, 0, tag_table) )
  {
    v26 += 12;
    if ( !--v25 )
      goto LABEL_28;
  }
  return v20;
}
