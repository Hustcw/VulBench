void /* PRIVATE */
png_check_IHDR(png_const_structrp png_ptr, png_uint_32 width,
               png_uint_32 height, int bit_depth, int color_type,
               int interlace_type, int compression_type, int filter_type) {
  int error = 0;

  /* Check for width and height valid values */
  if (width == 0) {
    png_warning(png_ptr, "Image width is zero in IHDR");
    error = 1;
  }

  if (width > PNG_UINT_31_MAX) {
    png_warning(png_ptr, "Invalid image width in IHDR");
    error = 1;
  }

  if (png_gt(((width + 7) & (~7U)), ((PNG_SIZE_MAX - 48 /* big_row_buf hack */
                                      - 1)              /* filter byte */
                                     / 8)               /* 8-byte RGBA pixels */
                                        - 1)) /* extra max_pixel_depth pad */
  {
    /* The size of the row must be within the limits of this architecture.
     * Because the read code can perform arbitrary transformations the
     * maximum size is checked here.  Because the code in png_read_start_row
     * adds extra space "for safety's sake" in several places a conservative
     * limit is used here.
     *
     * NOTE: it would be far better to check the size that is actually used,
     * but the effect in the real world is minor and the changes are more
     * extensive, therefore much more dangerous and much more difficult to
     * write in a way that avoids compiler warnings.
     */
    png_warning(png_ptr, "Image width is too large for this architecture");
    error = 1;
  }

#ifdef PNG_SET_USER_LIMITS_SUPPORTED
  if (width > png_ptr->user_width_max)
#else
  if (width > PNG_USER_WIDTH_MAX)
#endif
  {
    png_warning(png_ptr, "Image width exceeds user limit in IHDR");
    error = 1;
  }

  if (height == 0) {
    png_warning(png_ptr, "Image height is zero in IHDR");
    error = 1;
  }

  if (height > PNG_UINT_31_MAX) {
    png_warning(png_ptr, "Invalid image height in IHDR");
    error = 1;
  }

#ifdef PNG_SET_USER_LIMITS_SUPPORTED
  if (height > png_ptr->user_height_max)
#else
  if (height > PNG_USER_HEIGHT_MAX)
#endif
  {
    png_warning(png_ptr, "Image height exceeds user limit in IHDR");
    error = 1;
  }

  /* Check other values */
  if (bit_depth != 1 && bit_depth != 2 && bit_depth != 4 && bit_depth != 8 &&
      bit_depth != 16) {
    png_warning(png_ptr, "Invalid bit depth in IHDR");
    error = 1;
  }

  if (color_type < 0 || color_type == 1 || color_type == 5 || color_type > 6) {
    png_warning(png_ptr, "Invalid color type in IHDR");
    error = 1;
  }

  if (((color_type == PNG_COLOR_TYPE_PALETTE) && bit_depth > 8) ||
      ((color_type == PNG_COLOR_TYPE_RGB ||
        color_type == PNG_COLOR_TYPE_GRAY_ALPHA ||
        color_type == PNG_COLOR_TYPE_RGB_ALPHA) &&
       bit_depth < 8)) {
    png_warning(png_ptr, "Invalid color type/bit depth combination in IHDR");
    error = 1;
  }

  if (interlace_type >= PNG_INTERLACE_LAST) {
    png_warning(png_ptr, "Unknown interlace method in IHDR");
    error = 1;
  }

  if (compression_type != PNG_COMPRESSION_TYPE_BASE) {
    png_warning(png_ptr, "Unknown compression method in IHDR");
    error = 1;
  }

#ifdef PNG_MNG_FEATURES_SUPPORTED
  /* Accept filter_method 64 (intrapixel differencing) only if
   * 1. Libpng was compiled with PNG_MNG_FEATURES_SUPPORTED and
   * 2. Libpng did not read a PNG signature (this filter_method is only
   *    used in PNG datastreams that are embedded in MNG datastreams) and
   * 3. The application called png_permit_mng_features with a mask that
   *    included PNG_FLAG_MNG_FILTER_64 and
   * 4. The filter_method is 64 and
   * 5. The color_type is RGB or RGBA
   */
  if ((png_ptr->mode & PNG_HAVE_PNG_SIGNATURE) != 0 &&
      png_ptr->mng_features_permitted != 0)
    png_warning(png_ptr, "MNG features are not allowed in a PNG datastream");

  if (filter_type != PNG_FILTER_TYPE_BASE) {
    if (!((png_ptr->mng_features_permitted & PNG_FLAG_MNG_FILTER_64) != 0 &&
          (filter_type == PNG_INTRAPIXEL_DIFFERENCING) &&
          ((png_ptr->mode & PNG_HAVE_PNG_SIGNATURE) == 0) &&
          (color_type == PNG_COLOR_TYPE_RGB ||
           color_type == PNG_COLOR_TYPE_RGB_ALPHA))) {
      png_warning(png_ptr, "Unknown filter method in IHDR");
      error = 1;
    }

    if ((png_ptr->mode & PNG_HAVE_PNG_SIGNATURE) != 0) {
      png_warning(png_ptr, "Invalid filter method in IHDR");
      error = 1;
    }
  }

#else
  if (filter_type != PNG_FILTER_TYPE_BASE) {
    png_warning(png_ptr, "Unknown filter method in IHDR");
    error = 1;
  }
#endif

  if (error == 1)
    png_error(png_ptr, "Invalid IHDR data");
}
void /* PRIVATE */
png_read_start_row(png_structrp png_ptr) {
  /* Arrays to facilitate easy interlacing - use pass (0 - 6) as index */

  /* Start of interlace block */
  static const png_byte png_pass_start[7] = {0, 4, 0, 2, 0, 1, 0};

  /* Offset to next interlace block */
  static const png_byte png_pass_inc[7] = {8, 8, 4, 4, 2, 2, 1};

  /* Start of interlace block in the y direction */
  static const png_byte png_pass_ystart[7] = {0, 0, 4, 0, 2, 0, 1};

  /* Offset to next interlace block in the y direction */
  static const png_byte png_pass_yinc[7] = {8, 8, 8, 4, 4, 2, 2};

  unsigned int max_pixel_depth;
  size_t row_bytes;

  png_debug(1, "in png_read_start_row");

#ifdef PNG_READ_TRANSFORMS_SUPPORTED
  png_init_read_transformations(png_ptr);
#endif
  if (png_ptr->interlaced != 0) {
    if ((png_ptr->transformations & PNG_INTERLACE) == 0)
      png_ptr->num_rows =
          (png_ptr->height + png_pass_yinc[0] - 1 - png_pass_ystart[0]) /
          png_pass_yinc[0];

    else
      png_ptr->num_rows = png_ptr->height;

    png_ptr->iwidth = (png_ptr->width + png_pass_inc[png_ptr->pass] - 1 -
                       png_pass_start[png_ptr->pass]) /
                      png_pass_inc[png_ptr->pass];
  }

  else {
    png_ptr->num_rows = png_ptr->height;
    png_ptr->iwidth = png_ptr->width;
  }

  max_pixel_depth = (unsigned int)png_ptr->pixel_depth;

  /* WARNING: * png_read_transform_info (pngrtran.c) performs a simpler set of
   * calculations to calculate the final pixel depth, then
   * png_do_read_transforms actually does the transforms.  This means that the
   * code which effectively calculates this value is actually repeated in three
   * separate places.  They must all match.  Innocent changes to the order of
   * transformations can and will break libpng in a way that causes memory
   * overwrites.
   *
   * TODO: fix this.
   */
#ifdef PNG_READ_PACK_SUPPORTED
  if ((png_ptr->transformations & PNG_PACK) != 0 && png_ptr->bit_depth < 8)
    max_pixel_depth = 8;
#endif

#ifdef PNG_READ_EXPAND_SUPPORTED
  if ((png_ptr->transformations & PNG_EXPAND) != 0) {
    if (png_ptr->color_type == PNG_COLOR_TYPE_PALETTE) {
      if (png_ptr->num_trans != 0)
        max_pixel_depth = 32;

      else
        max_pixel_depth = 24;
    }

    else if (png_ptr->color_type == PNG_COLOR_TYPE_GRAY) {
      if (max_pixel_depth < 8)
        max_pixel_depth = 8;

      if (png_ptr->num_trans != 0)
        max_pixel_depth *= 2;
    }

    else if (png_ptr->color_type == PNG_COLOR_TYPE_RGB) {
      if (png_ptr->num_trans != 0) {
        max_pixel_depth *= 4;
        max_pixel_depth /= 3;
      }
    }
  }
#endif

#ifdef PNG_READ_EXPAND_16_SUPPORTED
  if ((png_ptr->transformations & PNG_EXPAND_16) != 0) {
#ifdef PNG_READ_EXPAND_SUPPORTED
    /* In fact it is an error if it isn't supported, but checking is
     * the safe way.
     */
    if ((png_ptr->transformations & PNG_EXPAND) != 0) {
      if (png_ptr->bit_depth < 16)
        max_pixel_depth *= 2;
    } else
#endif
      png_ptr->transformations &= ~PNG_EXPAND_16;
  }
#endif

#ifdef PNG_READ_FILLER_SUPPORTED
  if ((png_ptr->transformations & (PNG_FILLER)) != 0) {
    if (png_ptr->color_type == PNG_COLOR_TYPE_GRAY) {
      if (max_pixel_depth <= 8)
        max_pixel_depth = 16;

      else
        max_pixel_depth = 32;
    }

    else if (png_ptr->color_type == PNG_COLOR_TYPE_RGB ||
             png_ptr->color_type == PNG_COLOR_TYPE_PALETTE) {
      if (max_pixel_depth <= 32)
        max_pixel_depth = 32;

      else
        max_pixel_depth = 64;
    }
  }
#endif

#ifdef PNG_READ_GRAY_TO_RGB_SUPPORTED
  if ((png_ptr->transformations & PNG_GRAY_TO_RGB) != 0) {
    if (
#ifdef PNG_READ_EXPAND_SUPPORTED
        (png_ptr->num_trans != 0 &&
         (png_ptr->transformations & PNG_EXPAND) != 0) ||
#endif
#ifdef PNG_READ_FILLER_SUPPORTED
        (png_ptr->transformations & (PNG_FILLER)) != 0 ||
#endif
        png_ptr->color_type == PNG_COLOR_TYPE_GRAY_ALPHA) {
      if (max_pixel_depth <= 16)
        max_pixel_depth = 32;

      else
        max_pixel_depth = 64;
    }

    else {
      if (max_pixel_depth <= 8) {
        if (png_ptr->color_type == PNG_COLOR_TYPE_RGB_ALPHA)
          max_pixel_depth = 32;

        else
          max_pixel_depth = 24;
      }

      else if (png_ptr->color_type == PNG_COLOR_TYPE_RGB_ALPHA)
        max_pixel_depth = 64;

      else
        max_pixel_depth = 48;
    }
  }
#endif

#if defined(PNG_READ_USER_TRANSFORM_SUPPORTED) &&                              \
    defined(PNG_USER_TRANSFORM_PTR_SUPPORTED)
  if ((png_ptr->transformations & PNG_USER_TRANSFORM) != 0) {
    unsigned int user_pixel_depth =
        png_ptr->user_transform_depth * png_ptr->user_transform_channels;

    if (user_pixel_depth > max_pixel_depth)
      max_pixel_depth = user_pixel_depth;
  }
#endif

  /* This value is stored in png_struct and double checked in the row read
   * code.
   */
  png_ptr->maximum_pixel_depth = (png_byte)max_pixel_depth;
  png_ptr->transformed_pixel_depth = 0; /* calculated on demand */

  /* Align the width on the next larger 8 pixels.  Mainly used
   * for interlacing
   */
  row_bytes = ((png_ptr->width + 7) & ~((png_uint_32)7));
  /* Calculate the maximum bytes needed, adding a byte and a pixel
   * for safety's sake
   */
  row_bytes = PNG_ROWBYTES(max_pixel_depth, row_bytes) + 1 +
              ((max_pixel_depth + 7) >> 3U);


#ifdef PNG_MAX_MALLOC_64K
  if (row_bytes > (png_uint_32)65536L)
    png_error(png_ptr, "This image requires a row greater than 64KB");
#endif

  if (row_bytes + 48 > png_ptr->old_big_row_buf_size) {
    png_free(png_ptr, png_ptr->big_row_buf);
    png_free(png_ptr, png_ptr->big_prev_row);

    if (png_ptr->interlaced != 0)
      png_ptr->big_row_buf = (png_bytep)png_calloc(png_ptr, row_bytes + 48);

    else
      png_ptr->big_row_buf = (png_bytep)png_malloc(png_ptr, row_bytes + 48);

    png_ptr->big_prev_row = (png_bytep)png_malloc(png_ptr, row_bytes + 48);

#ifdef PNG_ALIGNED_MEMORY_SUPPORTED
    /* Use 16-byte aligned memory for row_buf with at least 16 bytes
     * of padding before and after row_buf; treat prev_row similarly.
     * NOTE: the alignment is to the start of the pixels, one beyond the start
     * of the buffer, because of the filter byte.  Prior to libpng 1.5.6 this
     * was incorrect; the filter byte was aligned, which had the exact
     * opposite effect of that intended.
     */
    {
      png_bytep temp = png_ptr->big_row_buf + 32;
      int extra = (int)((temp - (png_bytep)0) & 0x0f);
      png_ptr->row_buf = temp - extra - 1 /*filter byte*/;

      temp = png_ptr->big_prev_row + 32;
      extra = (int)((temp - (png_bytep)0) & 0x0f);
      png_ptr->prev_row = temp - extra - 1 /*filter byte*/;
    }

#else
    /* Use 31 bytes of padding before and 17 bytes after row_buf. */
    png_ptr->row_buf = png_ptr->big_row_buf + 31;
    png_ptr->prev_row = png_ptr->big_prev_row + 31;
#endif
    png_ptr->old_big_row_buf_size = row_bytes + 48;
  }

#ifdef PNG_MAX_MALLOC_64K
  if (png_ptr->rowbytes > 65535)
    png_error(png_ptr, "This image requires a row greater than 64KB");

#endif
  if (png_ptr->rowbytes > (PNG_SIZE_MAX - 1))
    png_error(png_ptr, "Row has too many bytes to allocate in memory");

  memset(png_ptr->prev_row, 0, png_ptr->rowbytes + 1);

  png_debug1(3, "width = %u,", png_ptr->width);
  png_debug1(3, "height = %u,", png_ptr->height);
  png_debug1(3, "iwidth = %u,", png_ptr->iwidth);
  png_debug1(3, "num_rows = %u,", png_ptr->num_rows);
  png_debug1(3, "rowbytes = %lu,", (unsigned long)png_ptr->rowbytes);
  png_debug1(
      3, "irowbytes = %lu",
      (unsigned long)PNG_ROWBYTES(png_ptr->pixel_depth, png_ptr->iwidth) + 1);

  /* The sequential reader needs a buffer for IDAT, but the progressive reader
   * does not, so free the read buffer now regardless; the sequential reader
   * reallocates it on demand.
   */
  if (png_ptr->read_buffer != NULL) {
    png_bytep buffer = png_ptr->read_buffer;

    png_ptr->read_buffer_size = 0;
    png_ptr->read_buffer = NULL;
    png_free(png_ptr, buffer);
  }

  /* Finally claim the zstream for the inflate of the IDAT data, use the bits
   * value from the stream (note that this will result in a fatal error if the
   * IDAT stream has a bogus deflate header window_bits value, but this should
   * not be happening any longer!)
   */
  if (png_inflate_claim(png_ptr, png_IDAT) != Z_OK)
    png_error(png_ptr, png_ptr->zstream.msg);

  png_ptr->flags |= PNG_FLAG_ROW_INIT;
}
