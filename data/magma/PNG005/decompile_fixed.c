void __fastcall MAGMA_png_check_IHDR(
        png_const_structrp png_ptr,
        png_uint_32 width,
        png_uint_32 height,
        int bit_depth,
        int color_type,
        int interlace_type,
        int compression_type,
        int filter_type)
{
  int v10;
  int v11;
  int v12;
  bool v13;
  int v14;
  bool v15;
  bool v16;
  int v17;
  int v18;
  bool v19;
  bool v20;
  bool v21;
  int v22;

  v10 = filter_type;
  v11 = compression_type;
  v12 = color_type | 4;
  if ( bit_depth >= 9 && color_type == 3 )
  {
LABEL_5:
    v18 = 1;
    goto LABEL_6;
  }
  v22 = interlace_type;
  v13 = (unsigned int)color_type > 6 || v12 == 5;
  v14 = v12;
  v15 = (unsigned int)(bit_depth - 1) > 1 && bit_depth != 4 && bit_depth != 8 && bit_depth != 16;
  v16 = png_ptr->user_height_max < height;
  v21 = (int)height <= 0;
  v20 = png_ptr->user_width_max < width;
  v17 = png_gt((width + 7) & 0xFFFFFFF8, (width + 7) & 0xFFFFFFF8);
  v12 = v14;
  v18 = v13 || v20 || v21 || (int)width <= 0 || v17 != 0 || v15 || v16;
  v19 = v14 == 6;
  if ( bit_depth <= 7 )
  {
    v10 = filter_type;
    interlace_type = v22;
    v11 = compression_type;
    if ( !v19 && color_type != 4 )
      goto LABEL_6;
    goto LABEL_5;
  }
  v10 = filter_type;
  interlace_type = v22;
  v11 = compression_type;
LABEL_6:
  if ( interlace_type > 1 )
    v18 = 1;
  if ( v11 )
    v18 = 1;
  if ( !v10 )
  {
    if ( !v18 )
      return;
LABEL_18:
    MAGMA_png_error(png_ptr, "Invalid IHDR data");
  }
  if ( v10 != 64 || (png_ptr->mng_features_permitted & 4) == 0 || v18 || v12 != 6 || (png_ptr->mode & 0x1000) != 0 )
    goto LABEL_18;
}


void __fastcall MAGMA_png_read_start_row(png_structrp png_ptr)
{
  png_uint_32 transformations;
  png_uint_32 width;
  png_uint_32 height;
  unsigned int v5;
  png_byte color_type;
  png_uint_32 v7;
  png_byte v8;
  int v9;
  png_byte v10;
  unsigned int v11;
  __int64 v12;
  unsigned __int64 v13;
  unsigned __int64 v14;
  size_t v15;
  png_byte *v16;
  png_byte *v17;
  size_t rowbytes;
  png_bytep read_buffer;
  int v20;

  MAGMA_png_init_read_transformations(png_ptr);
  if ( png_ptr->interlaced )
  {
    transformations = png_ptr->transformations;
    width = png_ptr->width;
    height = (png_ptr->height + 7) >> 3;
    if ( (transformations & 2) != 0 )
      height = png_ptr->height;
    png_ptr->num_rows = height;
    png_ptr->iwidth = (width
                     + MAGMA_png_read_start_row_png_pass_inc[png_ptr->pass]
                     + ~MAGMA_png_read_start_row_png_pass_start[png_ptr->pass])
                    / MAGMA_png_read_start_row_png_pass_inc[png_ptr->pass];
  }
  else
  {
    png_ptr->num_rows = png_ptr->height;
    transformations = png_ptr->transformations;
    width = png_ptr->width;
    png_ptr->iwidth = width;
  }
  LOBYTE(v5) = png_ptr->pixel_depth;
  if ( (transformations & 4) != 0 )
  {
    LOBYTE(v5) = 8;
    if ( png_ptr->bit_depth >= 8u )
      LOBYTE(v5) = png_ptr->pixel_depth;
  }
  v5 = (unsigned __int8)v5;
  if ( (transformations & 0x1000) == 0 )
  {
LABEL_10:
    if ( (transformations & 0x200) == 0 )
      goto LABEL_19;
    goto LABEL_11;
  }
  color_type = png_ptr->color_type;
  if ( color_type )
  {
    if ( color_type == 2 )
    {
      if ( png_ptr->num_trans )
      {
        v5 = (174764 * (unsigned int)(unsigned __int8)v5) >> 17;
        if ( (transformations & 0x200) == 0 )
          goto LABEL_19;
        goto LABEL_11;
      }
    }
    else if ( color_type == 3 )
    {
      v5 = 8 * (png_ptr->num_trans != 0) + 24;
      if ( (transformations & 0x200) == 0 )
        goto LABEL_19;
      goto LABEL_11;
    }
    goto LABEL_10;
  }
  v20 = 8;
  if ( (unsigned __int8)v5 > 8u )
    v20 = (unsigned __int8)v5;
  v5 = v20 << (png_ptr->num_trans != 0);
  if ( (transformations & 0x200) != 0 )
  {
LABEL_11:
    if ( (transformations & 0x1000) != 0 )
      v5 <<= png_ptr->bit_depth < 0x10u;
    else
      png_ptr->transformations = transformations & 0xFFFFFDFF;
  }
LABEL_19:
  v7 = png_ptr->transformations;
  if ( (v7 & 0x8000u) == 0 )
    goto LABEL_25;
  v8 = png_ptr->color_type;
  if ( (unsigned __int8)(v8 - 2) >= 2u )
  {
    if ( v8 )
      goto LABEL_25;
    v9 = 16 * (v5 > 8) + 16;
  }
  else
  {
    v9 = 32 * (v5 > 0x20) + 32;
  }
  v5 = v9;
LABEL_25:
  if ( (v7 & 0x4000) == 0 )
    goto LABEL_30;
  if ( (v7 & 0x8000u) != 0
    || ((png_ptr->num_trans != 0) & (unsigned __int8)(v7 >> 12)) != 0
    || (v10 = png_ptr->color_type, v10 == 4) )
  {
    v5 = 32 * (v5 > 0x10) + 32;
LABEL_30:
    if ( (v7 & 0x100000) == 0 )
      goto LABEL_34;
    goto LABEL_31;
  }
  if ( v5 > 8 )
  {
    v5 = 16 * (v10 == 6) + 48;
    if ( (v7 & 0x100000) == 0 )
      goto LABEL_34;
  }
  else
  {
    v5 = 8 * (v10 == 6) + 24;
    if ( (v7 & 0x100000) == 0 )
      goto LABEL_34;
  }
LABEL_31:
  v11 = png_ptr->user_transform_depth * png_ptr->user_transform_channels;
  if ( v11 <= v5 )
    v11 = v5;
  v5 = v11;
LABEL_34:
  png_ptr->maximum_pixel_depth = v5;
  png_ptr->transformed_pixel_depth = 0;
  v12 = (width + 7) & 0xFFFFFFF8;
  v13 = v12 * ((unsigned __int64)v5 >> 3);
  v14 = ((unsigned __int64)v5 * v12) >> 3;
  if ( v5 > 7 )
    v14 = v13;
  v15 = ((v5 + 7) >> 3) + v14 + 49;
  if ( v15 > png_ptr->old_big_row_buf_size )
  {
    MAGMA_png_free(png_ptr, png_ptr->big_row_buf);
    MAGMA_png_free(png_ptr, png_ptr->big_prev_row);
    if ( png_ptr->interlaced )
      v16 = (png_byte *)MAGMA_png_calloc(png_ptr, v15);
    else
      v16 = (png_byte *)MAGMA_png_malloc(png_ptr, v15);
    png_ptr->big_row_buf = v16;
    v17 = (png_byte *)MAGMA_png_malloc(png_ptr, v15);
    png_ptr->big_prev_row = v17;
    png_ptr->row_buf = &png_ptr->big_row_buf[(~((unsigned __int8)png_ptr->big_row_buf + 32) | 0xFFFFFFFFFFFFFFF0LL) + 32];
    png_ptr->prev_row = &v17[(~((unsigned __int8)v17 + 32) | 0xFFFFFFFFFFFFFFF0LL) + 32];
    png_ptr->old_big_row_buf_size = v15;
  }
  rowbytes = png_ptr->rowbytes;
  if ( rowbytes == -1LL )
    MAGMA_png_error(png_ptr, "Row has too many bytes to allocate in memory");
  memset(png_ptr->prev_row, 0, rowbytes + 1);
  read_buffer = png_ptr->read_buffer;
  if ( read_buffer )
  {
    *(_OWORD *)&png_ptr->read_buffer = 0LL;
    MAGMA_png_free(png_ptr, read_buffer);
  }
  if ( png_inflate_claim(png_ptr, 0x49444154u) )
    MAGMA_png_error(png_ptr, png_ptr->zstream.msg);
  LOBYTE(png_ptr->flags) |= 0x40u;
}
