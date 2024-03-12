void __fastcall MAGMA_png_set_PLTE(
        png_structrp png_ptr,
        png_inforp info_ptr,
        png_const_colorp palette,
        int num_palette)
{
  png_color *v6;

  if ( png_ptr && info_ptr )
  {
    if ( (unsigned int)num_palette < 0x101 )
    {
      if ( (palette || !num_palette) && (num_palette || (png_ptr->mng_features_permitted & 1) != 0) )
      {
        MAGMA_png_free_data(png_ptr, info_ptr, 0x1000u, 0);
        v6 = (png_color *)MAGMA_png_calloc(png_ptr, 0x300uLL);
        png_ptr->palette = v6;
        if ( num_palette )
          memcpy(v6, palette, 3LL * (unsigned int)num_palette);
        info_ptr->palette = v6;
        info_ptr->num_palette = num_palette;
        BYTE1(info_ptr->free_me) |= 0x10u;
        png_ptr->num_palette = num_palette;
        LOBYTE(info_ptr->valid) |= 8u;
      }
      else
      {
        MAGMA_png_chunk_report(png_ptr, "Invalid palette", 2);
      }
    }
    else if ( info_ptr->color_type == 3 )
    {
      MAGMA_png_error(png_ptr, "Invalid palette length");
    }
  }
}
