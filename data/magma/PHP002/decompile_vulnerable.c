bool __fastcall exif_process_IFD_in_TIFF_impl(image_info_type *ImageInfo, size_t dir_offset, int section_index)
{
  uchar *v4;
  bool v5;
  int v6;
  __int64 v7;
  int v8;
  __int64 v9;
  size_t FileSize;
  bool v11;
  size_t v12;
  const char *v13;
  image_info_type *v14;
  file_section *list;
  uchar *data;
  int motorola_intel;
  size_t v19;
  int v20;
  __int64 v21;
  __int64 v22;
  int v23;
  int v24;
  char *tagname_debug;
  image_info_type *v26;
  unsigned int v27;
  unsigned __int64 v28;
  __int64 v29;
  unsigned int v30;
  size_t v31;
  size_t v32;
  size_t v33;
  unsigned int v34;
  __int64 v35;
  __int64 v36;
  __int64 v37;
  image_info_type *v38;
  size_t v39;
  size_t v40;
  __int64 v41;
  int v42;
  char *v43;
  image_info_type *v44;
  char *v45;
  int v46;
  int v47;
  int v48;
  int v49;
  void *v50;
  unsigned int v51;
  size_t v52;
  size_t v53;
  tag_table_type v54;
  __int64 v55;
  int v57;
  int v58;
  size_t valid_length;
  size_t valid_lengtha;
  int v61;
  size_t size;
  unsigned __int64 v63;
  unsigned int v64;
  tag_info_type *tag_table;
  __int64 v66;
  exif_offset_info info;

  tag_table = exif_get_tag_table(section_index);
  if ( ImageInfo->FileSize < dir_offset + 2 )
  {
    v5 = 0;
    exif_error_docref(0LL, ImageInfo, 2, "Error in TIFF: filesize(x%04X) less than start of IFD dir(x%04X)");
    return v5;
  }
  v6 = exif_file_sections_add(ImageInfo, 291, 2uLL, v4);
  php_stream_seek(ImageInfo->infile, dir_offset, 0);
  v61 = v6;
  v66 = v6;
  v7 = v6;
  php_stream_read(ImageInfo->infile, (char *)ImageInfo->file.list[v7].data, 2uLL);
  v8 = php_ifd_get16u(ImageInfo->file.list[v7].data, ImageInfo->motorola_intel);
  v9 = (12LL * v8) | 2;
  FileSize = ImageInfo->FileSize;
  v11 = FileSize < v9 + 4;
  v12 = FileSize - (v9 + 4);
  if ( v11 || v12 < dir_offset )
  {
    v13 = "Error in TIFF: filesize(x%04X) less than size of IFD dir(x%04X)";
    v5 = 0;
    v14 = ImageInfo;
LABEL_8:
    exif_error_docref(0LL, v14, 2, v13);
    return v5;
  }
  v57 = v8;
  v58 = section_index;
  size = v9 + 4;
  if ( exif_file_sections_realloc(ImageInfo, v6, v9 + 4) )
    return 0;
  php_stream_read(ImageInfo->infile, (char *)ImageInfo->file.list[v7].data + 2, v9 + 2);
  list = ImageInfo->file.list;
  data = list[v7].data;
  motorola_intel = ImageInfo->motorola_intel;
  v64 = php_ifd_get32u(&data[v9], motorola_intel);
  v19 = v9 + 4;
  if ( v57 > 0 )
  {
    v55 = (unsigned int)v57 - 1LL;
    v20 = 0;
    v63 = 0LL;
    valid_length = size;
    while ( 1 )
    {
      v21 = v20 & 0xFFFFFFFC;
      v22 = (__int64)&data[v21 + 2];
      v23 = php_ifd_get16u((void *)v22, motorola_intel);
      v24 = php_ifd_get16u(&data[v21 + 4], motorola_intel);
      if ( v24 < 14 )
      {
        v26 = ImageInfo;
      }
      else
      {
        tagname_debug = exif_get_tagname_debug(v23, tag_table);
        LODWORD(v54) = v24;
        v26 = ImageInfo;
        exif_error_docref(
          0LL,
          ImageInfo,
          8,
          "Read from TIFF: tag(0x%04X,%12s): Illegal format code 0x%04X, switching to BYTE",
          (unsigned int)v23,
          tagname_debug,
          v54);
        motorola_intel = ImageInfo->motorola_intel;
        v24 = 1;
      }
      v27 = php_tiff_bytes_per_format[v24] * php_ifd_get32u((void *)(v22 + 4), motorola_intel);
      if ( v27 > 4 )
      {
        v29 = v27;
        v30 = php_ifd_get32u((void *)(v22 + 8), motorola_intel);
        v31 = v30 + v29;
        v32 = valid_length;
        v33 = v31 - dir_offset;
        if ( v31 <= valid_length + dir_offset )
          v33 = valid_length;
        if ( valid_length + dir_offset == v30 )
          v32 = v33;
        valid_length = v32;
        goto LABEL_36;
      }
      v28 = v63;
      switch ( v24 )
      {
        case 3:
          v28 = php_ifd_get16u((void *)(v22 + 8), motorola_intel);
          break;
        case 4:
          v34 = php_ifd_get32u((void *)(v22 + 8), motorola_intel);
          goto LABEL_26;
        case 5:
        case 6:
        case 7:
          break;
        case 8:
          v28 = php_ifd_get16s((void *)(v22 + 8), motorola_intel);
          break;
        case 9:
          v34 = php_ifd_get32s((void *)(v22 + 8), motorola_intel);
LABEL_26:
          v28 = v34;
          break;
        default:
          v28 = v63;
          break;
      }
      v63 = v28;
      if ( v23 <= 261 )
        break;
      if ( v23 != 262 )
      {
        if ( v23 == 40963 )
          goto LABEL_34;
        if ( v23 != 40962 )
          goto LABEL_36;
        goto LABEL_35;
      }
      v35 = v55;
      if ( v28 <= 8 )
      {
        v36 = 364LL;
        if ( _bittest64(&v36, v28) )
        {
          v26->IsColor = 1;
        }
        else
        {
          v37 = 19LL;
          if ( _bittest64(&v37, v28) )
            v26->IsColor = 0;
        }
      }
LABEL_37:
      list = v26->file.list;
      if ( !v35 )
      {
        v19 = valid_length;
        goto LABEL_46;
      }
      data = list[v66].data;
      v20 += 12;
      v55 = v35 - 1;
    }
    if ( v23 != 256 )
    {
      if ( v23 == 257 )
LABEL_34:
        v26->Height = v28;
LABEL_36:
      v35 = v55;
      goto LABEL_37;
    }
LABEL_35:
    v26->Width = v28;
    goto LABEL_36;
  }
LABEL_46:
  v38 = ImageInfo;
  v39 = ImageInfo->FileSize;
  v40 = list[v66].size;
  if ( v39 < v40 || v39 - v40 < dir_offset )
  {
    v13 = "Error in TIFF: filesize(x%04X) less than size of IFD(x%04X)";
LABEL_86:
    v5 = 0;
    v14 = ImageInfo;
    goto LABEL_8;
  }
  if ( v19 <= size )
    goto LABEL_53;
  if ( v39 < v19 || v39 - v19 < dir_offset )
  {
    v13 = "Error in TIFF: filesize(x%04X) less than size of IFD(x%04X + x%04X)";
    goto LABEL_86;
  }
  if ( exif_file_sections_realloc(ImageInfo, v61, v19) )
    return 0;
  php_stream_read(ImageInfo->infile, (char *)&ImageInfo->file.list[v66].data[size], v19 - size);
LABEL_53:
  valid_lengtha = v19;
  if ( v57 > 0 )
  {
    v41 = (unsigned int)v57;
    v42 = 0;
    do
    {
      v43 = (char *)v38->file.list[v66].data;
      v44 = v38;
      v45 = &v43[(v42 & 0xFFFFFFFC) + 2];
      v46 = v44->motorola_intel;
      v47 = php_ifd_get16u(v45, v46);
      if ( v47 > 34852 )
      {
        if ( v47 == 40965 )
        {
          v48 = 10;
          v49 = 1024;
        }
        else
        {
          if ( v47 != 34853 )
          {
LABEL_55:
            exif_offset_info_init(&info, &v43[-dir_offset], v43, valid_lengtha);
            v5 = 0;
            v38 = ImageInfo;
            if ( !exif_process_IFD_TAG(ImageInfo, &v43[(v42 & 0xFFFFFFFC) + 2], &info, 0LL, v58, 0, tag_table) )
              return v5;
            goto LABEL_56;
          }
          v48 = 9;
          v49 = 512;
        }
      }
      else if ( v47 == 330 )
      {
        v48 = 4;
        v49 = 16;
      }
      else
      {
        if ( v47 != 34665 )
          goto LABEL_55;
        v48 = 7;
        v49 = 128;
      }
      ImageInfo->sections_found |= v49;
      v50 = v45 + 8;
      v38 = ImageInfo;
      v51 = php_ifd_get32u(v50, v46);
      exif_process_IFD_in_TIFF(ImageInfo, v51, v48);
      if ( v58 != 4 && v47 == 330 )
      {
        if ( ImageInfo->Thumbnail.filetype )
        {
          v52 = ImageInfo->Thumbnail.size;
          if ( v52 )
          {
            if ( ImageInfo->Thumbnail.offset && ImageInfo->read_thumbnail && !ImageInfo->Thumbnail.data )
            {
              ImageInfo->Thumbnail.data = (char *)safe_emalloc(v52, 1uLL, 0LL);
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
LABEL_56:
      v42 += 12;
      --v41;
    }
    while ( v41 );
  }
  v5 = 1;
  if ( v58 != 4 )
  {
    if ( v64 )
    {
      exif_process_IFD_in_TIFF(v38, v64, 4);
      if ( !v38->Thumbnail.data )
      {
        if ( v38->Thumbnail.offset )
        {
          v53 = v38->Thumbnail.size;
          if ( v53 )
          {
            if ( v38->read_thumbnail )
            {
              v38->Thumbnail.data = (char *)safe_emalloc(v53, 1uLL, 0LL);
              php_stream_seek(v38->infile, v38->Thumbnail.offset, 0);
              if ( php_stream_read(v38->infile, v38->Thumbnail.data, v38->Thumbnail.size) == v38->Thumbnail.size )
              {
                exif_thumbnail_build(v38);
              }
              else
              {
                exif_error_docref(0LL, v38, 2, "%s", "Thumbnail goes IFD boundary or end of file reached");
                efree(v38->Thumbnail.data);
                v38->Thumbnail.data = 0LL;
              }
            }
          }
        }
      }
    }
  }
  return v5;
}
