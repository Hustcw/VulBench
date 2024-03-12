void __fastcall MAGMA_png_handle_PLTE(png_structrp png_ptr, png_inforp info_ptr, png_uint_32 length)
{
  png_uint_32 mode;
  const char *v5;
  unsigned int v6;
  unsigned int v7;
  png_color *v8;
  png_inforp v9;
  png_uint_32 valid;
  png_byte v11[3];
  png_inforp v12;
  png_color v13;

  mode = png_ptr->mode;
  if ( (mode & 1) == 0 )
    MAGMA_png_chunk_error(png_ptr, "missing IHDR");
  if ( (mode & 2) != 0 )
    MAGMA_png_chunk_error(png_ptr, "duplicate");
  if ( (mode & 4) != 0 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v5 = "out of place";
    goto LABEL_7;
  }
  png_ptr->mode = mode | 2;
  if ( (png_ptr->color_type & 2) == 0 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v5 = "ignored in grayscale PNG";
LABEL_7:
    MAGMA_png_chunk_benign_error(png_ptr, v5);
    return;
  }
  if ( length > 0x300 || length % 3 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    if ( png_ptr->color_type == 3 )
      MAGMA_png_chunk_error(png_ptr, "invalid");
    v5 = "invalid";
    goto LABEL_7;
  }
  v12 = info_ptr;
  v6 = (unsigned __int16)length / 3u;
  if ( (unsigned __int16)length >= 3u )
  {
    v7 = 0;
    v8 = &v13;
    do
    {
      MAGMA_png_crc_read(png_ptr, v11, 3u);
      v8->red = v11[0];
      v8->green = v11[1];
      v8->blue = v11[2];
      ++v7;
      ++v8;
    }
    while ( v7 < v6 );
  }
  MAGMA_png_crc_finish(png_ptr, length - 3 * v6);
  v9 = v12;
  MAGMA_png_set_PLTE(png_ptr, v12, &v13, v6);
  if ( png_ptr->num_trans )
  {
    png_ptr->num_trans = 0;
    if ( !v9 )
    {
      v5 = "tRNS must be after";
      goto LABEL_7;
    }
  }
  else
  {
    if ( !v9 )
      return;
    valid = v9->valid;
    if ( (valid & 0x10) == 0 )
    {
      if ( (valid & 0x40) != 0 )
        goto LABEL_26;
LABEL_22:
      if ( (v9->valid & 0x20) != 0 )
        goto LABEL_27;
      return;
    }
    png_ptr->num_trans = 0;
  }
  v9->num_trans = 0;
  MAGMA_png_chunk_benign_error(png_ptr, "tRNS must be after");
  if ( (v9->valid & 0x40) == 0 )
    goto LABEL_22;
LABEL_26:
  MAGMA_png_chunk_benign_error(png_ptr, "hIST must be after");
  if ( (v9->valid & 0x20) != 0 )
  {
LABEL_27:
    v5 = "bKGD must be after";
    goto LABEL_7;
  }
}
