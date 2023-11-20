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


__int64 __fastcall exif_process_IFD_TAG_impl(
        image_info_type *ImageInfo,
        char *dir_entry,
        const exif_offset_info *info,
        size_t displacement,
        int section_index,
        int ReadNextIFD,
        tag_table_type tag_table)
{
  int motorola_intel;
  __int64 v8;
  unsigned int v9;
  char *tagname_debug;
  image_info_type *v11;
  unsigned int v12;
  size_t v13;
  unsigned __int64 v14;
  int v15;
  char *v16;
  const char *v17;
  char *v18;
  image_info_type *v19;
  image_info_type *v20;
  size_t v21;
  char *v22;
  void *v23;
  int sections_found;
  unsigned __int64 v25;
  int v26;
  unsigned __int64 FileSize;
  bool v28;
  size_t v29;
  unsigned int FileType;
  int v31;
  char *v32;
  char *v33;
  xp_field_type *v34;
  __int64 count;
  float v36;
  int v37;
  zend_off_t v38;
  zend_off_t v39;
  ssize_t v40;
  char *v41;
  zend_off_t v42;
  float v43;
  int v44;
  int v45;
  int v46;
  int v47;
  char *UserComment;
  char *UserCommentEncoding;
  const exif_offset_info *v50;
  int v51;
  int v52;
  __int64 v53;
  float v54;
  float v55;
  char *make;
  char *model;
  int v58;
  size_t v59;
  size_t v60;
  char *CopyrightPhotographer;
  char *CopyrightEditor;
  char *v63;
  char *v64;
  char *v65;
  char *v66;
  char *v67;
  char *v68;
  char *v69;
  unsigned int v70;
  char *v71;
  bool v72;
  char *v73;
  char *Copyright;
  char *tagname_key;
  int v77;
  zend_off_t offset;
  zend_off_t offseta;
  int v83;
  size_t v85;
  __int128 v86[2];
  char buf[120];

  motorola_intel = ImageInfo->motorola_intel;
  v83 = php_ifd_get16u(dir_entry, motorola_intel);
  v8 = (unsigned int)php_ifd_get16u(dir_entry + 2, motorola_intel);
  v9 = php_ifd_get32u(dir_entry + 4, motorola_intel);
  if ( (unsigned int)(v8 - 1) < 0xD )
  {
    v11 = ImageInfo;
  }
  else
  {
    tagname_debug = exif_get_tagname_debug(v83, tag_table);
    v11 = ImageInfo;
    exif_error_docref(
      "exif_read_data#error_ifd",
      ImageInfo,
      2,
      "Process tag(x%04X=%s): Illegal format code 0x%04X, suppose BYTE",
      (unsigned int)v83,
      tagname_debug,
      v8);
    LODWORD(v8) = 1;
  }
  v12 = v83;
  v13 = v9;
  v14 = v9 * (__int64)php_tiff_bytes_per_format[(unsigned int)v8];
  v15 = section_index;
  if ( (v14 & 0xFFFFFFFF80000000LL) != 0 )
  {
    v16 = exif_get_tagname_debug(v83, tag_table);
    v17 = "Process tag(x%04X=%s): Illegal byte_count";
    LODWORD(v18) = 0;
    v19 = v11;
LABEL_6:
    exif_error_docref("exif_read_data#error_ifd", v19, 2, v17, v12, v16);
    return (unsigned int)v18;
  }
  v85 = v13;
  v77 = v8;
  v18 = dir_entry + 8;
  v20 = v11;
  if ( v14 < 5 )
    goto LABEL_10;
  v21 = php_ifd_get32u(dir_entry + 8, v11->motorola_intel);
  v22 = exif_offset_info_try_get(info, v21, v14);
  if ( v22 )
  {
    v18 = v22;
    v15 = section_index;
LABEL_10:
    v23 = 0LL;
    goto LABEL_11;
  }
  FileSize = v11->FileSize;
  v28 = FileSize < v14;
  v29 = FileSize - v14;
  if ( v28 || v29 < v21 || (FileType = v11->FileType, FileType > 8) || (v31 = 388, !_bittest(&v31, FileType)) )
  {
    v33 = exif_get_tagname_debug(v83, tag_table);
    LODWORD(v18) = 0;
    exif_error_docref(
      "exif_read_data#error_ifd",
      v11,
      2,
      "Process tag(x%04X=%s): Illegal pointer offset(x%04X + x%04X = x%04X > x%04X)",
      (unsigned int)v83,
      v33,
      v21,
      v14,
      v21 + v14,
      v11->FileSize);
    return (unsigned int)v18;
  }
  if ( v14 < 0x21 )
  {
    v18 = (char *)v86;
    memset(v86, 0, sizeof(v86));
    v32 = 0LL;
  }
  else
  {
    v18 = (char *)safe_emalloc(v14, 1uLL, 0LL);
    v32 = v18;
  }
  offset = php_stream_tell(v11->infile);
  v38 = displacement + v21;
  php_stream_seek(v11->infile, v38, 0);
  v39 = php_stream_tell(v11->infile);
  if ( v39 != v38 )
  {
    if ( v32 )
    {
      v41 = v32;
      v42 = v39;
      efree(v41);
      v39 = v42;
    }
    LODWORD(v18) = 0;
    exif_error_docref(0LL, v11, 2, "Wrong file pointer: 0x%08X != 0x%08X", v39, v38);
    return (unsigned int)v18;
  }
  v40 = php_stream_read(v11->infile, v18, v14);
  php_stream_seek(v11->infile, offset, 0);
  if ( v40 != v14 )
  {
    if ( v32 )
      efree(v32);
    LODWORD(v18) = 0;
    exif_error_docref(0LL, v11, 2, "%s", "Unexpected end of file reached");
    return (unsigned int)v18;
  }
  v15 = section_index;
  v23 = v32;
LABEL_11:
  sections_found = v20->sections_found;
  v25 = sections_found | 4u;
  v20->sections_found = v25;
  if ( v15 == 4 )
  {
    if ( !v20->Thumbnail.data )
    {
      if ( v14 )
      {
        if ( v83 > 512 )
        {
          if ( v83 > 40961 )
          {
            if ( v83 == 40963 )
            {
LABEL_68:
              v46 = exif_rewrite_tag_format_to_unsigned(v77);
              v20->Thumbnail.height = exif_convert_any_to_int(v18, v46, v20->motorola_intel);
            }
            else if ( v83 == 40962 )
            {
LABEL_66:
              v44 = exif_rewrite_tag_format_to_unsigned(v77);
              v20->Thumbnail.width = exif_convert_any_to_int(v18, v44, v20->motorola_intel);
            }
          }
          else if ( v83 == 513 )
          {
LABEL_67:
            v45 = exif_rewrite_tag_format_to_unsigned(v77);
            v20->Thumbnail.offset = exif_convert_any_to_int(v18, v45, v20->motorola_intel);
          }
          else if ( v83 == 514 && v20->Thumbnail.filetype == IMAGE_FILETYPE_UNKNOWN )
          {
            v20->Thumbnail.filetype = IMAGE_FILETYPE_JPEG;
LABEL_47:
            v37 = exif_rewrite_tag_format_to_unsigned(v77);
            v20->Thumbnail.size = exif_convert_any_to_int(v18, v37, v20->motorola_intel);
          }
        }
        else
        {
          switch ( v83 )
          {
            case 256:
              goto LABEL_66;
            case 257:
              goto LABEL_68;
            case 273:
              goto LABEL_67;
            case 279:
              v26 = 8;
              if ( (unsigned int)(v20->FileType - 7) < 2 )
                v26 = v20->FileType;
              v20->Thumbnail.filetype = v26;
              goto LABEL_47;
            default:
              goto LABEL_143;
          }
        }
        goto LABEL_143;
      }
LABEL_84:
      v12 = v83;
      v16 = exif_get_tagname_debug(v83, tag_table);
      v17 = "Process tag(x%04X=%s): Cannot be empty";
      LODWORD(v18) = 0;
      v19 = v20;
      goto LABEL_6;
    }
LABEL_143:
    tagname_key = exif_get_tagname_key(v83, buf, (size_t)tag_table, (tag_table_type)v25);
    exif_iif_add_tag(v20, v15, tagname_key, v83, v77, v85, v18, v14);
    LOBYTE(v18) = 1;
    if ( v23 )
      efree(v23);
    return (unsigned int)v18;
  }
  v25 = v15 | 4u;
  if ( (_DWORD)v25 != 7 )
    goto LABEL_143;
  if ( v83 > 37499 )
  {
    if ( v83 <= 40961 )
    {
      if ( (unsigned int)(v83 - 40091) < 5 )
      {
        v34 = (xp_field_type *)safe_erealloc(v20->xp_fields.list, v20->xp_fields.count + 1LL, 0x18uLL, 0LL);
        BYTE1(v20->sections_found) |= 0x10u;
        v20->xp_fields.list = v34;
        count = v20->xp_fields.count;
        v20->xp_fields.count = count + 1;
        exif_process_unicode(v20, &v34[count], v83, v18, v14);
        goto LABEL_143;
      }
      if ( v83 != 37500 )
      {
        if ( v83 != 37510 )
          goto LABEL_143;
        offseta = (zend_off_t)v23;
        v47 = v15;
        UserComment = v20->UserComment;
        if ( UserComment )
          efree(UserComment);
        v20->UserComment = 0LL;
        UserCommentEncoding = v20->UserCommentEncoding;
        if ( UserCommentEncoding )
          efree(UserCommentEncoding);
        v20->UserCommentEncoding = 0LL;
        v20->UserCommentLength = exif_process_user_comment(v20, &v20->UserComment, &v20->UserCommentEncoding, v18, v14);
        goto LABEL_76;
      }
      if ( exif_process_IFD_in_MAKERNOTE(v20, v18, v14, info, displacement) )
        goto LABEL_143;
      goto LABEL_131;
    }
    if ( v83 > 41485 )
    {
      if ( v83 == 41486 )
      {
        if ( !v14 )
        {
          v69 = exif_get_tagname_debug(41486, tag_table);
          LODWORD(v18) = 0;
          exif_error_docref("exif_read_data#error_ifd", v20, 2, "Process tag(x%04X=%s): Cannot be empty", 41486LL, v69);
          return (unsigned int)v18;
        }
        v20->FocalplaneXRes = exif_convert_any_format(v18, v77, v20->motorola_intel);
      }
      else if ( v83 == 41488 )
      {
        if ( !v14 )
        {
          v67 = exif_get_tagname_debug(41488, tag_table);
          LODWORD(v18) = 0;
          exif_error_docref("exif_read_data#error_ifd", v20, 2, "Process tag(x%04X=%s): Cannot be empty", 41488LL, v67);
          return (unsigned int)v18;
        }
        switch ( exif_convert_any_to_int(v18, v77, v20->motorola_intel) )
        {
          case 1uLL:
          case 2uLL:
            v53 = 0x4039666666666666LL;
            goto LABEL_142;
          case 3uLL:
            v53 = 0x4024000000000000LL;
            goto LABEL_142;
          case 4uLL:
            v53 = 0x3FF0000000000000LL;
            goto LABEL_142;
          case 5uLL:
            v53 = 0x3F50624DD2F1A9FCLL;
LABEL_142:
            *(_QWORD *)&v20->FocalplaneUnits = v53;
            break;
          default:
            goto LABEL_143;
        }
      }
      goto LABEL_143;
    }
    if ( v83 == 40962 )
    {
      if ( !v14 )
      {
        v68 = exif_get_tagname_debug(40962, tag_table);
        LODWORD(v18) = 0;
        exif_error_docref("exif_read_data#error_ifd", v20, 2, "Process tag(x%04X=%s): Cannot be empty", 40962LL, v68);
        return (unsigned int)v18;
      }
      v58 = exif_rewrite_tag_format_to_unsigned(v77);
      v20->ExifImageWidth = exif_convert_any_to_int(v18, v58, v20->motorola_intel);
      goto LABEL_143;
    }
    if ( v83 != 40965 )
      goto LABEL_143;
LABEL_79:
    if ( !ReadNextIFD )
      goto LABEL_143;
    if ( !v14 )
      goto LABEL_84;
    if ( v83 == 34665 )
    {
      v51 = 7;
      v52 = 132;
    }
    else
    {
      if ( v83 != 40965 )
      {
        v50 = info;
        v51 = 9;
        v52 = 516;
LABEL_129:
        v20->sections_found = v52 | sections_found;
        v70 = php_ifd_get32u(v18, v20->motorola_intel);
        v71 = exif_offset_info_try_get(v50, v70, 0LL);
        if ( !v71 )
        {
          LODWORD(v18) = 0;
          exif_error_docref("exif_read_data#error_ifd", v20, 2, "Illegal IFD Pointer");
          if ( !v23 )
            return (unsigned int)v18;
          goto LABEL_134;
        }
        v72 = exif_process_IFD_in_JPEG(v20, v71, v50, displacement, v51, v83);
        v15 = section_index;
        if ( v72 )
          goto LABEL_143;
LABEL_131:
        if ( !v23 )
        {
          LODWORD(v18) = 0;
          return (unsigned int)v18;
        }
LABEL_134:
        efree(v23);
        LODWORD(v18) = 0;
        return (unsigned int)v18;
      }
      v51 = 10;
      v52 = 1028;
    }
    v50 = info;
    goto LABEL_129;
  }
  if ( v83 <= 34664 )
  {
    if ( v83 <= 33431 )
    {
      if ( v83 == 271 )
      {
        make = v20->make;
        if ( make )
          efree(make);
        v20->make = estrndup(v18, v14);
      }
      else if ( v83 == 272 )
      {
        model = v20->model;
        if ( model )
          efree(model);
        v20->model = estrndup(v18, v14);
      }
      else if ( v83 == 330 && v77 == 13 )
      {
        exif_error_docref(0LL, v20, 8, "Skip SUB IFD");
      }
      goto LABEL_143;
    }
    if ( v83 != 33432 )
    {
      if ( v83 == 33434 )
      {
        v20->ExposureTime = -1.0;
      }
      else if ( v83 == 33437 )
      {
        if ( !v14 )
        {
          v66 = exif_get_tagname_debug(33437, tag_table);
          LODWORD(v18) = 0;
          exif_error_docref("exif_read_data#error_ifd", v20, 2, "Process tag(x%04X=%s): Cannot be empty", 33437LL, v66);
          return (unsigned int)v18;
        }
        v43 = exif_convert_any_format(v18, v77, v20->motorola_intel);
        v20->ApertureFNumber = v43;
      }
      goto LABEL_143;
    }
    if ( v14 < 2 )
      goto LABEL_143;
    v59 = php_strnlen(v18, v14);
    if ( !v59 )
      goto LABEL_143;
    v60 = v59;
    if ( v59 >= v14 - 1 )
    {
      Copyright = v20->Copyright;
      if ( Copyright )
        efree(Copyright);
      v20->Copyright = estrndup(v18, v14);
      goto LABEL_143;
    }
    offseta = (zend_off_t)v23;
    CopyrightPhotographer = v20->CopyrightPhotographer;
    if ( CopyrightPhotographer )
      efree(CopyrightPhotographer);
    v47 = v15;
    CopyrightEditor = v20->CopyrightEditor;
    if ( CopyrightEditor )
      efree(CopyrightEditor);
    v63 = v20->Copyright;
    if ( v63 )
      efree(v63);
    v20->CopyrightPhotographer = estrdup(v18);
    v64 = estrndup(&v18[v60 + 1], v14 + ~v60);
    v20->CopyrightEditor = v64;
    zend_spprintf(&v20->Copyright, 0LL, "%s, %s", v20->CopyrightPhotographer, v64);
LABEL_76:
    v15 = v47;
    v23 = (void *)offseta;
    goto LABEL_143;
  }
  v25 = (unsigned int)(v83 - 37377);
  switch ( v83 )
  {
    case 37377:
      if ( v20->ExposureTime != 0.0 )
        goto LABEL_143;
      if ( v14 )
      {
        v54 = exif_convert_any_format(v18, v77, v20->motorola_intel) * -0.6931471824645996;
        v20->ExposureTime = expf(v54);
        goto LABEL_143;
      }
      v73 = exif_get_tagname_debug(37377, tag_table);
      LODWORD(v18) = 0;
      exif_error_docref("exif_read_data#error_ifd", v20, 2, "Process tag(x%04X=%s): Cannot be empty", 37377LL, v73);
      return (unsigned int)v18;
    case 37378:
    case 37381:
      if ( v20->ApertureFNumber != 0.0 )
        goto LABEL_143;
      if ( !v14 )
        goto LABEL_84;
      v36 = exif_convert_any_format(v18, v77, v20->motorola_intel) * 0.6931471824645996 * 0.5;
      v20->ApertureFNumber = expf(v36);
      goto LABEL_143;
    case 37379:
    case 37380:
      goto LABEL_143;
    case 37382:
      if ( v14 )
      {
        v55 = exif_convert_any_format(v18, v77, v20->motorola_intel);
        v20->Distance = v55;
        goto LABEL_143;
      }
      v65 = exif_get_tagname_debug(37382, tag_table);
      LODWORD(v18) = 0;
      exif_error_docref("exif_read_data#error_ifd", v20, 2, "Process tag(x%04X=%s): Cannot be empty", 37382LL, v65);
      break;
    default:
      if ( v83 == 34665 || v83 == 34853 )
        goto LABEL_79;
      goto LABEL_143;
  }
  return (unsigned int)v18;
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
