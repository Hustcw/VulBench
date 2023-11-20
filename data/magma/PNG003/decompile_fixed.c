void __fastcall MAGMA_png_handle_PLTE(png_structrp png_ptr, png_inforp info_ptr, png_uint_32 length)
{
  png_uint_32 mode;
  png_byte color_type;
  const char *v6;
  int v7;
  int v8;
  int v9;
  png_color *v10;
  png_inforp v11;
  png_uint_32 valid;
  png_byte v13[3];
  png_inforp v14;
  png_color v15;

  mode = png_ptr->mode;
  if ( (mode & 1) == 0 )
    MAGMA_png_chunk_error(png_ptr, "missing IHDR");
  if ( (mode & 2) != 0 )
    MAGMA_png_chunk_error(png_ptr, "duplicate");
  if ( (mode & 4) != 0 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v6 = "out of place";
    goto LABEL_7;
  }
  png_ptr->mode = mode | 2;
  color_type = png_ptr->color_type;
  if ( (color_type & 2) == 0 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v6 = "ignored in grayscale PNG";
LABEL_7:
    MAGMA_png_chunk_benign_error(png_ptr, v6);
    return;
  }
  if ( length > 0x300 || length % 3 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    if ( png_ptr->color_type == 3 )
      MAGMA_png_chunk_error(png_ptr, "invalid");
    v6 = "invalid";
    goto LABEL_7;
  }
  v14 = info_ptr;
  v7 = (unsigned __int16)length / 3u;
  v8 = 256;
  if ( color_type == 3 )
    v8 = 1 << png_ptr->bit_depth;
  if ( v8 <= v7 )
    v7 = v8;
  if ( v7 > 0 )
  {
    v9 = 0;
    v10 = &v15;
    do
    {
      MAGMA_png_crc_read(png_ptr, v13, 3u);
      v10->red = v13[0];
      v10->green = v13[1];
      v10->blue = v13[2];
      ++v9;
      ++v10;
    }
    while ( v9 < v7 );
  }
  MAGMA_png_crc_finish(png_ptr, length - 3 * v7);
  v11 = v14;
  MAGMA_png_set_PLTE(png_ptr, v14, &v15, v7);
  if ( png_ptr->num_trans )
  {
    png_ptr->num_trans = 0;
    if ( !v11 )
    {
      v6 = "tRNS must be after";
      goto LABEL_7;
    }
  }
  else
  {
    if ( !v11 )
      return;
    valid = v11->valid;
    if ( (valid & 0x10) == 0 )
    {
      if ( (valid & 0x40) != 0 )
        goto LABEL_30;
LABEL_26:
      if ( (v11->valid & 0x20) != 0 )
        goto LABEL_31;
      return;
    }
    png_ptr->num_trans = 0;
  }
  v11->num_trans = 0;
  MAGMA_png_chunk_benign_error(png_ptr, "tRNS must be after");
  if ( (v11->valid & 0x40) == 0 )
    goto LABEL_26;
LABEL_30:
  MAGMA_png_chunk_benign_error(png_ptr, "hIST must be after");
  if ( (v11->valid & 0x20) != 0 )
  {
LABEL_31:
    v6 = "bKGD must be after";
    goto LABEL_7;
  }
}


void __fastcall MAGMA_png_set_PLTE(
        png_structrp png_ptr,
        png_inforp info_ptr,
        png_const_colorp palette,
        int num_palette)
{
  png_byte color_type;
  int v7;
  png_color *v8;

  if ( png_ptr && info_ptr )
  {
    color_type = info_ptr->color_type;
    v7 = 256;
    if ( color_type == 3 )
      v7 = 1 << info_ptr->bit_depth;
    if ( num_palette < 0 || v7 < num_palette )
    {
      if ( color_type == 3 )
        MAGMA_png_error(png_ptr, "Invalid palette length");
    }
    else
    {
      if ( !palette && num_palette > 0 || !num_palette && (png_ptr->mng_features_permitted & 1) == 0 )
        MAGMA_png_error(png_ptr, "Invalid palette");
      MAGMA_png_free_data(png_ptr, info_ptr, 0x1000u, 0);
      v8 = (png_color *)MAGMA_png_calloc(png_ptr, 0x300uLL);
      png_ptr->palette = v8;
      if ( num_palette > 0 )
        memcpy(v8, palette, 3LL * (unsigned int)num_palette);
      info_ptr->palette = v8;
      info_ptr->num_palette = num_palette;
      BYTE1(info_ptr->free_me) |= 0x10u;
      png_ptr->num_palette = num_palette;
      LOBYTE(info_ptr->valid) |= 8u;
    }
  }
}
