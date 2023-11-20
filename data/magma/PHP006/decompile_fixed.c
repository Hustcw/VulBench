bool __fastcall exif_scan_thumbnail(image_info_type *ImageInfo)
{
  char *data;
  size_t size;
  bool v3;
  __int64 v4;
  unsigned __int64 v5;
  unsigned __int64 v6;
  char *v7;
  __int64 i;
  char v9;
  unsigned __int64 v10;
  int v11;
  unsigned __int8 v12;
  __int64 v13;
  __int64 v14;
  uchar *v17;
  int v18;
  __int128 v19;

  data = ImageInfo->Thumbnail.data;
  if ( data )
  {
    size = ImageInfo->Thumbnail.size;
    if ( size >= 4 )
    {
      if ( *(_WORD *)data ^ 0xD8FF | (unsigned __int8)data[2] ^ 0xFF )
      {
        if ( !ImageInfo->Thumbnail.width && !ImageInfo->Thumbnail.height )
        {
          v3 = 0;
          exif_error_docref(0LL, ImageInfo, 2, "Thumbnail is not a JPEG image");
          return v3;
        }
      }
      else
      {
        v4 = 2LL;
        v5 = 0LL;
        while ( 1 )
        {
          v6 = v5 + v4;
          if ( v5 + v4 >= size || v6 + 1 >= size || data[v6] != -1 )
            break;
          v7 = &data[v6];
          for ( i = 0LL; ; ++i )
          {
            v9 = v7[i + 1];
            if ( (_DWORD)i == 8 || v9 != -1 )
              break;
            v10 = i + v6 + 5;
            if ( v10 >= size )
              return 0;
          }
          v3 = 0;
          if ( i + v6 + 2 >= size )
            return v3;
          if ( v9 == -1 )
            return v3;
          v17 = (uchar *)&v7[i + 2];
          v11 = php_jpg_get16(v17);
          v4 = v11;
          v3 = 0;
          if ( size < v11 )
            return v3;
          v5 = i + v6 + 2;
          if ( v5 >= size - v11 )
            return v3;
          v12 = v9 + 64;
          if ( v12 <= 0x1Au )
          {
            v13 = 61167LL;
            if ( _bittest64(&v13, v12) )
            {
              v3 = 0;
              if ( size - 8 >= i + v6 + 2 && (unsigned int)v11 >= 8 )
              {
                exif_process_SOFn(v17, (__int64)&v18, (jpeg_sof_info *)v12);
                *(_OWORD *)&ImageInfo->Thumbnail.width = v19;
                return 1;
              }
              return v3;
            }
            v14 = 100663296LL;
            if ( _bittest64(&v14, v12) )
            {
              v3 = 0;
              exif_error_docref(0LL, ImageInfo, 2, "Could not compute size of thumbnail");
              return v3;
            }
          }
        }
      }
    }
  }
  return 0;
}
