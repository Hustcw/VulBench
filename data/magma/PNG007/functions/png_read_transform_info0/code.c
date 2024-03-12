void /* PRIVATE */
png_read_transform_info(png_structrp png_ptr, png_inforp info_ptr) {
  png_debug(1, "in png_read_transform_info");

#ifdef PNG_READ_EXPAND_SUPPORTED
  if ((png_ptr->transformations & PNG_EXPAND) != 0) {
    if (info_ptr->color_type == PNG_COLOR_TYPE_PALETTE) {
      /* This check must match what actually happens in
       * png_do_expand_palette; if it ever checks the tRNS chunk to see if
       * it is all opaque we must do the same (at present it does not.)
       */
      if (png_ptr->num_trans > 0)
        info_ptr->color_type = PNG_COLOR_TYPE_RGB_ALPHA;

      else
        info_ptr->color_type = PNG_COLOR_TYPE_RGB;

      info_ptr->bit_depth = 8;
      info_ptr->num_trans = 0;

    } else {
      if (png_ptr->num_trans != 0) {
        if ((png_ptr->transformations & PNG_EXPAND_tRNS) != 0)
          info_ptr->color_type |= PNG_COLOR_MASK_ALPHA;
      }
      if (info_ptr->bit_depth < 8)
        info_ptr->bit_depth = 8;

      info_ptr->num_trans = 0;
    }
  }
#endif

#if defined(PNG_READ_BACKGROUND_SUPPORTED) ||                                  \
    defined(PNG_READ_ALPHA_MODE_SUPPORTED)
  /* The following is almost certainly wrong unless the background value is in
   * the screen space!
   */
  if ((png_ptr->transformations & PNG_COMPOSE) != 0)
    info_ptr->background = png_ptr->background;
#endif

#ifdef PNG_READ_GAMMA_SUPPORTED
  /* The following used to be conditional on PNG_GAMMA (prior to 1.5.4),
   * however it seems that the code in png_init_read_transformations, which has
   * been called before this from png_read_update_info->png_read_start_row
   * sometimes does the gamma transform and cancels the flag.
   *
   * TODO: this looks wrong; the info_ptr should end up with a gamma equal to
   * the screen_gamma value.  The following probably results in weirdness if
   * the info_ptr is used by the app after the rows have been read.
   */
  info_ptr->colorspace.gamma = png_ptr->colorspace.gamma;
#endif

  if (info_ptr->bit_depth == 16) {
#ifdef PNG_READ_16BIT_SUPPORTED
#ifdef PNG_READ_SCALE_16_TO_8_SUPPORTED
    if ((png_ptr->transformations & PNG_SCALE_16_TO_8) != 0)
      info_ptr->bit_depth = 8;
#endif

#ifdef PNG_READ_STRIP_16_TO_8_SUPPORTED
    if ((png_ptr->transformations & PNG_16_TO_8) != 0)
      info_ptr->bit_depth = 8;
#endif

#else
    /* No 16-bit support: force chopping 16-bit input down to 8, in this case
     * the app program can chose if both APIs are available by setting the
     * correct scaling to use.
     */
#ifdef PNG_READ_STRIP_16_TO_8_SUPPORTED
    /* For compatibility with previous versions use the strip method by
     * default.  This code works because if PNG_SCALE_16_TO_8 is already
     * set the code below will do that in preference to the chop.
     */
    png_ptr->transformations |= PNG_16_TO_8;
    info_ptr->bit_depth = 8;
#else

#ifdef PNG_READ_SCALE_16_TO_8_SUPPORTED
    png_ptr->transformations |= PNG_SCALE_16_TO_8;
    info_ptr->bit_depth = 8;
#else

    CONFIGURATION ERROR : you must enable at least one 16 to 8 method
#endif
#endif
#endif /* !READ_16BIT */
  }

#ifdef PNG_READ_GRAY_TO_RGB_SUPPORTED
  if ((png_ptr->transformations & PNG_GRAY_TO_RGB) != 0)
    info_ptr->color_type =
        (png_byte)(info_ptr->color_type | PNG_COLOR_MASK_COLOR);
#endif

#ifdef PNG_READ_RGB_TO_GRAY_SUPPORTED
  if ((png_ptr->transformations & PNG_RGB_TO_GRAY) != 0)
    info_ptr->color_type =
        (png_byte)(info_ptr->color_type & ~PNG_COLOR_MASK_COLOR);
#endif

#ifdef PNG_READ_QUANTIZE_SUPPORTED
  if ((png_ptr->transformations & PNG_QUANTIZE) != 0) {
    if (((info_ptr->color_type == PNG_COLOR_TYPE_RGB) ||
         (info_ptr->color_type == PNG_COLOR_TYPE_RGB_ALPHA)) &&
        png_ptr->palette_lookup != 0 && info_ptr->bit_depth == 8) {
      info_ptr->color_type = PNG_COLOR_TYPE_PALETTE;
    }
  }
#endif

#ifdef PNG_READ_EXPAND_16_SUPPORTED
  if ((png_ptr->transformations & PNG_EXPAND_16) != 0 &&
      info_ptr->bit_depth == 8 &&
      info_ptr->color_type != PNG_COLOR_TYPE_PALETTE) {
    info_ptr->bit_depth = 16;
  }
#endif

#ifdef PNG_READ_PACK_SUPPORTED
  if ((png_ptr->transformations & PNG_PACK) != 0 && (info_ptr->bit_depth < 8))
    info_ptr->bit_depth = 8;
#endif

  if (info_ptr->color_type == PNG_COLOR_TYPE_PALETTE)
    info_ptr->channels = 1;

  else if ((info_ptr->color_type & PNG_COLOR_MASK_COLOR) != 0)
    info_ptr->channels = 3;

  else
    info_ptr->channels = 1;

#ifdef PNG_READ_STRIP_ALPHA_SUPPORTED
  if ((png_ptr->transformations & PNG_STRIP_ALPHA) != 0) {
    info_ptr->color_type =
        (png_byte)(info_ptr->color_type & ~PNG_COLOR_MASK_ALPHA);
    info_ptr->num_trans = 0;
  }
#endif

  if ((info_ptr->color_type & PNG_COLOR_MASK_ALPHA) != 0)
    info_ptr->channels++;

#ifdef PNG_READ_FILLER_SUPPORTED
  /* STRIP_ALPHA and FILLER allowed:  MASK_ALPHA bit stripped above */
  if ((png_ptr->transformations & PNG_FILLER) != 0 &&
      (info_ptr->color_type == PNG_COLOR_TYPE_RGB ||
       info_ptr->color_type == PNG_COLOR_TYPE_GRAY)) {
    info_ptr->channels++;
    /* If adding a true alpha channel not just filler */
    if ((png_ptr->transformations & PNG_ADD_ALPHA) != 0)
      info_ptr->color_type |= PNG_COLOR_MASK_ALPHA;
  }
#endif

#if defined(PNG_USER_TRANSFORM_PTR_SUPPORTED) &&                               \
    defined(PNG_READ_USER_TRANSFORM_SUPPORTED)
  if ((png_ptr->transformations & PNG_USER_TRANSFORM) != 0) {
    if (png_ptr->user_transform_depth != 0)
      info_ptr->bit_depth = png_ptr->user_transform_depth;

    if (png_ptr->user_transform_channels != 0)
      info_ptr->channels = png_ptr->user_transform_channels;
  }
#endif

  info_ptr->pixel_depth = (png_byte)(info_ptr->channels * info_ptr->bit_depth);

  info_ptr->rowbytes = PNG_ROWBYTES(info_ptr->pixel_depth, info_ptr->width);

  /* Adding in 1.5.4: cache the above value in png_struct so that we can later
   * check in png_rowbytes that the user buffer won't get overwritten.  Note
   * that the field is not always set - if png_read_update_info isn't called
   * the application has to either not do any transforms or get the calculation
   * right itself.
   */
  png_ptr->info_rowbytes = info_ptr->rowbytes;

#ifndef PNG_READ_EXPAND_SUPPORTED
  if (png_ptr != NULL)
    return;
#endif
}