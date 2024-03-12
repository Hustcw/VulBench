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
