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
  bool v8;
  bool v9;
  bool v10;
  bool v11;
  int v12;
  int v13;
  int v14;
  bool v15;

  v8 = (int)width <= 0;
  v9 = png_ptr->user_width_max < width;
  v10 = (int)height <= 0;
  v11 = png_ptr->user_height_max < height;
  v13 = (unsigned int)bit_depth > 0x10 || (v12 = 65814, !_bittest(&v12, bit_depth)) || v10 || v8 || v9 || v11;
  v14 = color_type | 4;
  if ( bit_depth >= 9 && color_type == 3 )
    goto LABEL_12;
  if ( v14 == 5 )
    v13 = 1;
  if ( (unsigned int)color_type > 6 )
    v13 = 1;
  v15 = color_type == 4;
  if ( bit_depth <= 7 && (v14 == 6 || v15) )
LABEL_12:
    v13 = 1;
  if ( interlace_type > 1 )
    v13 = 1;
  if ( compression_type )
    v13 = 1;
  if ( !filter_type )
  {
    if ( !v13 )
      return;
LABEL_25:
    MAGMA_png_error(png_ptr, "Invalid IHDR data");
  }
  if ( filter_type != 64
    || (png_ptr->mng_features_permitted & 4) == 0
    || v13
    || v14 != 6
    || (png_ptr->mode & 0x1000) != 0 )
  {
    goto LABEL_25;
  }
}
