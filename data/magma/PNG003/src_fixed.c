void /* PRIVATE */
png_handle_PLTE(png_structrp png_ptr, png_inforp info_ptr, png_uint_32 length) {
  png_color palette[PNG_MAX_PALETTE_LENGTH];
  int max_palette_length, num, i;
#ifdef PNG_POINTER_INDEXING_SUPPORTED
  png_colorp pal_ptr;
#endif

  png_debug(1, "in png_handle_PLTE");

  if ((png_ptr->mode & PNG_HAVE_IHDR) == 0)
    png_chunk_error(png_ptr, "missing IHDR");

  /* Moved to before the 'after IDAT' check below because otherwise duplicate
   * PLTE chunks are potentially ignored (the spec says there shall not be more
   * than one PLTE, the error is not treated as benign, so this check trumps
   * the requirement that PLTE appears before IDAT.)
   */
  else if ((png_ptr->mode & PNG_HAVE_PLTE) != 0)
    png_chunk_error(png_ptr, "duplicate");

  else if ((png_ptr->mode & PNG_HAVE_IDAT) != 0) {
    /* This is benign because the non-benign error happened before, when an
     * IDAT was encountered in a color-mapped image with no PLTE.
     */
    png_crc_finish(png_ptr, length);
    png_chunk_benign_error(png_ptr, "out of place");
    return;
  }

  png_ptr->mode |= PNG_HAVE_PLTE;

  if ((png_ptr->color_type & PNG_COLOR_MASK_COLOR) == 0) {
    png_crc_finish(png_ptr, length);
    png_chunk_benign_error(png_ptr, "ignored in grayscale PNG");
    return;
  }

#ifndef PNG_READ_OPT_PLTE_SUPPORTED
  if (png_ptr->color_type != PNG_COLOR_TYPE_PALETTE) {
    png_crc_finish(png_ptr, length);
    return;
  }
#endif

  if (length > 3 * PNG_MAX_PALETTE_LENGTH || length % 3) {
    png_crc_finish(png_ptr, length);

    if (png_ptr->color_type != PNG_COLOR_TYPE_PALETTE)
      png_chunk_benign_error(png_ptr, "invalid");

    else
      png_chunk_error(png_ptr, "invalid");

    return;
  }

  /* The cast is safe because 'length' is less than 3*PNG_MAX_PALETTE_LENGTH */
  num = (int)length / 3;

  /* If the palette has 256 or fewer entries but is too large for the bit
   * depth, we don't issue an error, to preserve the behavior of previous
   * libpng versions. We silently truncate the unused extra palette entries
   * here.
   */
  if (png_ptr->color_type == PNG_COLOR_TYPE_PALETTE)
    max_palette_length = (1 << png_ptr->bit_depth);
  else
    max_palette_length = PNG_MAX_PALETTE_LENGTH;

  if (num > max_palette_length)
    num = max_palette_length;


#ifdef PNG_POINTER_INDEXING_SUPPORTED
  for (i = 0, pal_ptr = palette; i < num; i++, pal_ptr++) {
    png_byte buf[3];

    png_crc_read(png_ptr, buf, 3);
    pal_ptr->red = buf[0];
    pal_ptr->green = buf[1];
    pal_ptr->blue = buf[2];
  }
#else
  for (i = 0; i < num; i++) {
    png_byte buf[3];

    png_crc_read(png_ptr, buf, 3);
    /* Don't depend upon png_color being any order */
    palette[i].red = buf[0];
    palette[i].green = buf[1];
    palette[i].blue = buf[2];
  }
#endif

  /* If we actually need the PLTE chunk (ie for a paletted image), we do
   * whatever the normal CRC configuration tells us.  However, if we
   * have an RGB image, the PLTE can be considered ancillary, so
   * we will act as though it is.
   */
#ifndef PNG_READ_OPT_PLTE_SUPPORTED
  if (png_ptr->color_type == PNG_COLOR_TYPE_PALETTE)
#endif
  {
    png_crc_finish(png_ptr, (png_uint_32)(length - (unsigned int)num * 3));
  }

#ifndef PNG_READ_OPT_PLTE_SUPPORTED
  else if (png_crc_error(png_ptr) != 0) /* Only if we have a CRC error */
  {
    /* If we don't want to use the data from an ancillary chunk,
     * we have two options: an error abort, or a warning and we
     * ignore the data in this chunk (which should be OK, since
     * it's considered ancillary for a RGB or RGBA image).
     *
     * IMPLEMENTATION NOTE: this is only here because png_crc_finish uses the
     * chunk type to determine whether to check the ancillary or the critical
     * flags.
     */
    if ((png_ptr->flags & PNG_FLAG_CRC_ANCILLARY_USE) == 0) {
      if ((png_ptr->flags & PNG_FLAG_CRC_ANCILLARY_NOWARN) != 0)
        return;

      else
        png_chunk_error(png_ptr, "CRC error");
    }

    /* Otherwise, we (optionally) emit a warning and use the chunk. */
    else if ((png_ptr->flags & PNG_FLAG_CRC_ANCILLARY_NOWARN) == 0)
      png_chunk_warning(png_ptr, "CRC error");
  }
#endif

  /* TODO: png_set_PLTE has the side effect of setting png_ptr->palette to its
   * own copy of the palette.  This has the side effect that when png_start_row
   * is called (this happens after any call to png_read_update_info) the
   * info_ptr palette gets changed.  This is extremely unexpected and
   * confusing.
   *
   * Fix this by not sharing the palette in this way.
   */
  png_set_PLTE(png_ptr, info_ptr, palette, num);

  /* The three chunks, bKGD, hIST and tRNS *must* appear after PLTE and before
   * IDAT.  Prior to 1.6.0 this was not checked; instead the code merely
   * checked the apparent validity of a tRNS chunk inserted before PLTE on a
   * palette PNG.  1.6.0 attempts to rigorously follow the standard and
   * therefore does a benign error if the erroneous condition is detected *and*
   * cancels the tRNS if the benign error returns.  The alternative is to
   * amend the standard since it would be rather hypocritical of the standards
   * maintainers to ignore it.
   */
#ifdef PNG_READ_tRNS_SUPPORTED
  if (png_ptr->num_trans > 0 ||
      (info_ptr != NULL && (info_ptr->valid & PNG_INFO_tRNS) != 0)) {
    /* Cancel this because otherwise it would be used if the transforms
     * require it.  Don't cancel the 'valid' flag because this would prevent
     * detection of duplicate chunks.
     */
    png_ptr->num_trans = 0;

    if (info_ptr != NULL)
      info_ptr->num_trans = 0;

    png_chunk_benign_error(png_ptr, "tRNS must be after");
  }
#endif

#ifdef PNG_READ_hIST_SUPPORTED
  if (info_ptr != NULL && (info_ptr->valid & PNG_INFO_hIST) != 0)
    png_chunk_benign_error(png_ptr, "hIST must be after");
#endif

#ifdef PNG_READ_bKGD_SUPPORTED
  if (info_ptr != NULL && (info_ptr->valid & PNG_INFO_bKGD) != 0)
    png_chunk_benign_error(png_ptr, "bKGD must be after");
#endif
}
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
