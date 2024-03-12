
void PNGAPI png_set_PLTE(png_structrp png_ptr, png_inforp info_ptr,
                         png_const_colorp palette, int num_palette) {

  png_uint_32 max_palette_length;

  png_debug1(1, "in %s storage function", "PLTE");

  if (png_ptr == NULL || info_ptr == NULL)
    return;

  max_palette_length = (info_ptr->color_type == PNG_COLOR_TYPE_PALETTE)
                           ? (1 << info_ptr->bit_depth)
                           : PNG_MAX_PALETTE_LENGTH;

  if (num_palette < 0 || num_palette > (int)max_palette_length)
  {
    if (info_ptr->color_type == PNG_COLOR_TYPE_PALETTE)
      png_error(png_ptr, "Invalid palette length");

    else {
      png_warning(png_ptr, "Invalid palette length");

      return;
    }
  }

  if ((num_palette > 0 && palette == NULL) ||
      (num_palette == 0
#ifdef PNG_MNG_FEATURES_SUPPORTED
       && (png_ptr->mng_features_permitted & PNG_FLAG_MNG_EMPTY_PLTE) == 0
#endif
       )) {
    png_error(png_ptr, "Invalid palette");
  }

  /* It may not actually be necessary to set png_ptr->palette here;
   * we do it for backward compatibility with the way the png_handle_tRNS
   * function used to do the allocation.
   *
   * 1.6.0: the above statement appears to be incorrect; something has to set
   * the palette inside png_struct on read.
   */
  png_free_data(png_ptr, info_ptr, PNG_FREE_PLTE, 0);

  /* Changed in libpng-1.2.1 to allocate PNG_MAX_PALETTE_LENGTH instead
   * of num_palette entries, in case of an invalid PNG file or incorrect
   * call to png_set_PLTE() with too-large sample values.
   */
  png_ptr->palette =
      png_voidcast(png_colorp, png_calloc(png_ptr, PNG_MAX_PALETTE_LENGTH *
                                                       (sizeof(png_color))));

  if (num_palette > 0)
    memcpy(png_ptr->palette, palette,
           (unsigned int)num_palette * (sizeof(png_color)));
  info_ptr->palette = png_ptr->palette;
  info_ptr->num_palette = png_ptr->num_palette = (png_uint_16)num_palette;

  info_ptr->free_me |= PNG_FREE_PLTE;

  info_ptr->valid |= PNG_INFO_PLTE;
}