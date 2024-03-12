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
