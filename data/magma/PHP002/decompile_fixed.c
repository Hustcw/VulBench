bool __fastcall exif_process_IFD_in_TIFF_impl(image_info_type *ImageInfo, size_t dir_offset, int section_index)
{
  uchar *v5;
  size_t FileSize;
  bool v7;
  size_t v8;
  int v9;
  __int64 v10;
  __int64 v11;
  size_t v12;
  bool v13;
  const char *v14;
  image_info_type *v15;
  size_t v16;
  file_section *list;
  uchar *data;
  int motorola_intel;
  size_t v21;
  int v22;
  __int64 v23;
  __int64 v24;
  int v25;
  int v26;
  char *tagname_debug;
  image_info_type *v28;
  unsigned int v29;
  unsigned __int64 v30;
  __int64 v31;
  unsigned int v32;
  size_t v33;
  size_t v34;
  size_t v35;
  unsigned int v36;
  __int64 v37;
  __int64 v38;
  __int64 v39;
  image_info_type *v40;
  size_t size;
  __int64 v42;
  int v43;
  char *v44;
  image_info_type *v45;
  char *v46;
  int v47;
  int v48;
  int v49;
  int v50;
  void *v51;
  unsigned int v52;
  size_t v53;
  size_t v54;
  tag_table_type v55;
  __int64 v56;
  int v58;
  int v59;
  size_t valid_length;
  size_t valid_lengtha;
  int v62;
  size_t v63;
  unsigned __int64 v64;
  unsigned int v65;
  tag_info_type *tag_table;
  __int64 v67;
  exif_offset_info info;

  tag_table = exif_get_tag_table(section_index);
  FileSize = ImageInfo->FileSize;
  v7 = FileSize < 2;
  v8 = FileSize - 2;
  if ( v7 || v8 < dir_offset )
  {
    v13 = 0;
    exif_error_docref(
      0LL,
      ImageInfo,
      2,
      "Error in TIFF: filesize(x%04X) less than start of IFD dir(x%04X)",
      ImageInfo->FileSize,
      dir_offset + 2);
    return v13;
  }
  v9 = exif_file_sections_add(ImageInfo, 291, 2uLL, v5);
  php_stream_seek(ImageInfo->infile, dir_offset, 0);
  v62 = v9;
  v67 = v9;
  v10 = v9;
  php_stream_read(ImageInfo->infile, (char *)ImageInfo->file.list[v10].data, 2uLL);
  v58 = php_ifd_get16u(ImageInfo->file.list[v10].data, ImageInfo->motorola_intel);
  v11 = (12LL * v58) | 2;
  v12 = ImageInfo->FileSize;
  if ( v12 < v11 + 4 || v12 - (v11 + 4) < dir_offset )
  {
    v14 = "Error in TIFF: filesize(x%04X) less than size of IFD dir(x%04X)";
    v13 = 0;
    v15 = ImageInfo;
    v16 = dir_offset + v11 + 4;
LABEL_9:
    exif_error_docref(0LL, v15, 2, v14, v12, v16, v55);
    return v13;
  }
  v59 = section_index;
  if ( exif_file_sections_realloc(ImageInfo, v62, v11 + 4) )
    return 0;
  php_stream_read(ImageInfo->infile, (char *)ImageInfo->file.list[v10].data + 2, v11 + 2);
  list = ImageInfo->file.list;
  data = list[v10].data;
  motorola_intel = ImageInfo->motorola_intel;
  v65 = php_ifd_get32u(&data[v11], motorola_intel);
  v63 = v11 + 4;
  v21 = v11 + 4;
  if ( v58 > 0 )
  {
    v56 = (unsigned int)v58 - 1LL;
    v22 = 0;
    v64 = 0LL;
    valid_length = v63;
    while ( 1 )
    {
      v23 = v22 & 0xFFFFFFFC;
      v24 = (__int64)&data[v23 + 2];
      v25 = php_ifd_get16u((void *)v24, motorola_intel);
      v26 = php_ifd_get16u(&data[v23 + 4], motorola_intel);
      if ( v26 < 14 )
      {
        v28 = ImageInfo;
      }
      else
      {
        tagname_debug = exif_get_tagname_debug(v25, tag_table);
        LODWORD(v55) = v26;
        v28 = ImageInfo;
        exif_error_docref(
          0LL,
          ImageInfo,
          8,
          "Read from TIFF: tag(0x%04X,%12s): Illegal format code 0x%04X, switching to BYTE",
          (unsigned int)v25,
          tagname_debug,
          v55);
        motorola_intel = ImageInfo->motorola_intel;
        v26 = 1;
      }
      v29 = php_tiff_bytes_per_format[v26] * php_ifd_get32u((void *)(v24 + 4), motorola_intel);
      if ( v29 > 4 )
      {
        v31 = v29;
        v32 = php_ifd_get32u((void *)(v24 + 8), motorola_intel);
        v33 = v32 + v31;
        v34 = valid_length;
        v35 = v33 - dir_offset;
        if ( v33 <= valid_length + dir_offset )
          v35 = valid_length;
        if ( valid_length + dir_offset == v32 )
          v34 = v35;
        valid_length = v34;
        goto LABEL_37;
      }
      v30 = v64;
      switch ( v26 )
      {
        case 3:
          v30 = php_ifd_get16u((void *)(v24 + 8), motorola_intel);
          break;
        case 4:
          v36 = php_ifd_get32u((void *)(v24 + 8), motorola_intel);
          goto LABEL_27;
        case 5:
        case 6:
        case 7:
          break;
        case 8:
          v30 = php_ifd_get16s((void *)(v24 + 8), motorola_intel);
          break;
        case 9:
          v36 = php_ifd_get32s((void *)(v24 + 8), motorola_intel);
LABEL_27:
          v30 = v36;
          break;
        default:
          v30 = v64;
          break;
      }
      v64 = v30;
      if ( v25 <= 261 )
        break;
      if ( v25 != 262 )
      {
        if ( v25 == 40963 )
          goto LABEL_35;
        if ( v25 != 40962 )
          goto LABEL_37;
        goto LABEL_36;
      }
      v37 = v56;
      if ( v30 <= 8 )
      {
        v38 = 364LL;
        if ( _bittest64(&v38, v30) )
        {
          v28->IsColor = 1;
        }
        else
        {
          v39 = 19LL;
          if ( _bittest64(&v39, v30) )
            v28->IsColor = 0;
        }
      }
LABEL_38:
      list = v28->file.list;
      if ( !v37 )
      {
        v21 = valid_length;
        goto LABEL_47;
      }
      data = list[v67].data;
      v22 += 12;
      v56 = v37 - 1;
    }
    if ( v25 != 256 )
    {
      if ( v25 == 257 )
LABEL_35:
        v28->Height = v30;
LABEL_37:
      v37 = v56;
      goto LABEL_38;
    }
LABEL_36:
    v28->Width = v30;
    goto LABEL_37;
  }
LABEL_47:
  v40 = ImageInfo;
  v12 = ImageInfo->FileSize;
  size = list[v67].size;
  if ( v12 < size || v12 - size < dir_offset )
  {
    v16 = dir_offset + size;
    v14 = "Error in TIFF: filesize(x%04X) less than size of IFD(x%04X)";
LABEL_87:
    v13 = 0;
    v15 = ImageInfo;
    goto LABEL_9;
  }
  if ( v21 <= v63 )
    goto LABEL_54;
  if ( v12 < v21 || v12 - v21 < dir_offset )
  {
    v55 = (tag_table_type)v21;
    v14 = "Error in TIFF: filesize(x%04X) less than size of IFD(x%04X + x%04X)";
    v16 = dir_offset;
    goto LABEL_87;
  }
  if ( exif_file_sections_realloc(ImageInfo, v62, v21) )
    return 0;
  php_stream_read(ImageInfo->infile, (char *)&ImageInfo->file.list[v67].data[v63], v21 - v63);
LABEL_54:
  valid_lengtha = v21;
  if ( v58 > 0 )
  {
    v42 = (unsigned int)v58;
    v43 = 0;
    do
    {
      v44 = (char *)v40->file.list[v67].data;
      v45 = v40;
      v46 = &v44[(v43 & 0xFFFFFFFC) + 2];
      v47 = v45->motorola_intel;
      v48 = php_ifd_get16u(v46, v47);
      if ( v48 > 34852 )
      {
        if ( v48 == 40965 )
        {
          v49 = 10;
          v50 = 1024;
        }
        else
        {
          if ( v48 != 34853 )
          {
LABEL_56:
            exif_offset_info_init(&info, &v44[-dir_offset], v44, valid_lengtha);
            v13 = 0;
            v40 = ImageInfo;
            if ( !exif_process_IFD_TAG(ImageInfo, &v44[(v43 & 0xFFFFFFFC) + 2], &info, 0LL, v59, 0, tag_table) )
              return v13;
            goto LABEL_57;
          }
          v49 = 9;
          v50 = 512;
        }
      }
      else if ( v48 == 330 )
      {
        v49 = 4;
        v50 = 16;
      }
      else
      {
        if ( v48 != 34665 )
          goto LABEL_56;
        v49 = 7;
        v50 = 128;
      }
      ImageInfo->sections_found |= v50;
      v51 = v46 + 8;
      v40 = ImageInfo;
      v52 = php_ifd_get32u(v51, v47);
      exif_process_IFD_in_TIFF(ImageInfo, v52, v49);
      if ( v59 != 4 && v48 == 330 )
      {
        if ( ImageInfo->Thumbnail.filetype )
        {
          v53 = ImageInfo->Thumbnail.size;
          if ( v53 )
          {
            if ( ImageInfo->Thumbnail.offset && ImageInfo->read_thumbnail && !ImageInfo->Thumbnail.data )
            {
              ImageInfo->Thumbnail.data = (char *)safe_emalloc(v53, 1uLL, 0LL);
              php_stream_seek(ImageInfo->infile, ImageInfo->Thumbnail.offset, 0);
              if ( php_stream_read(ImageInfo->infile, ImageInfo->Thumbnail.data, ImageInfo->Thumbnail.size) == ImageInfo->Thumbnail.size )
              {
                exif_thumbnail_build(ImageInfo);
              }
              else
              {
                exif_error_docref(0LL, ImageInfo, 2, "%s", "Thumbnail goes IFD boundary or end of file reached");
                efree(ImageInfo->Thumbnail.data);
                ImageInfo->Thumbnail.data = 0LL;
              }
            }
          }
        }
      }
LABEL_57:
      v43 += 12;
      --v42;
    }
    while ( v42 );
  }
  v13 = 1;
  if ( v59 != 4 )
  {
    if ( v65 )
    {
      exif_process_IFD_in_TIFF(v40, v65, 4);
      if ( !v40->Thumbnail.data )
      {
        if ( v40->Thumbnail.offset )
        {
          v54 = v40->Thumbnail.size;
          if ( v54 )
          {
            if ( v40->read_thumbnail )
            {
              v40->Thumbnail.data = (char *)safe_emalloc(v54, 1uLL, 0LL);
              php_stream_seek(v40->infile, v40->Thumbnail.offset, 0);
              if ( php_stream_read(v40->infile, v40->Thumbnail.data, v40->Thumbnail.size) == v40->Thumbnail.size )
              {
                exif_thumbnail_build(v40);
              }
              else
              {
                exif_error_docref(0LL, v40, 2, "%s", "Thumbnail goes IFD boundary or end of file reached");
                efree(v40->Thumbnail.data);
                v40->Thumbnail.data = 0LL;
              }
            }
          }
        }
      }
    }
  }
  return v13;
}
