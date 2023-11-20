bool __fastcall exif_scan_thumbnail(image_info_type *ImageInfo)
{
  __int64 v1;
  char *data;
  size_t size;
  __int64 v4;
  __int64 v5;
  __int64 i;
  char v7;
  size_t v8;
  unsigned __int8 v9;
  __int64 v10;
  __int64 v11;
  uchar *v13;
  int v14;
  __int128 v15;

  data = ImageInfo->Thumbnail.data;
  if ( data )
  {
    LOWORD(v1) = *(_WORD *)data ^ 0xD8FF;
    if ( (unsigned __int16)v1 | (unsigned __int8)data[2] ^ 0xFF )
    {
      if ( !ImageInfo->Thumbnail.width && !ImageInfo->Thumbnail.height )
        exif_error_docref(0LL, ImageInfo, 2, "Thumbnail is not a JPEG image");
    }
    else
    {
      size = ImageInfo->Thumbnail.size;
      v1 = 2LL;
      v4 = 0LL;
      while ( 1 )
      {
        v5 = v4 + v1;
        if ( v4 + v1 >= size )
          break;
        LOBYTE(v1) = v5 + 1;
        if ( v5 + 1 >= size || data[v5] != -1 )
          break;
        v1 = (__int64)&data[v5];
        for ( i = 0LL; ; ++i )
        {
          v7 = *(_BYTE *)(v1 + i + 1);
          if ( (_DWORD)i == 8 || v7 != -1 )
            break;
          v8 = v5 + i + 5;
          if ( v8 >= size )
            return v1;
        }
        if ( v7 == -1 )
          break;
        v13 = (uchar *)(v1 + i + 2);
        v1 = php_jpg_get16(v13);
        if ( i + (int)v1 + v5 + 2 >= size )
          break;
        v4 = v5 + i + 2;
        v9 = v7 + 64;
        if ( v9 <= 0x1Au )
        {
          v10 = 61167LL;
          if ( _bittest64(&v10, v9) )
          {
            exif_process_SOFn(v13, (__int64)&v14, (jpeg_sof_info *)v9);
            *(_OWORD *)&ImageInfo->Thumbnail.width = v15;
            return v1;
          }
          v11 = 100663296LL;
          if ( _bittest64(&v11, v9) )
          {
            exif_error_docref(0LL, ImageInfo, 2, "Could not compute size of thumbnail");
            return v1;
          }
        }
      }
    }
  }
  return v1;
}
