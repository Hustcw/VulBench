void /* PRIVATE */
png_combine_row(png_const_structrp png_ptr, png_bytep dp, int display) {
  unsigned int pixel_depth = png_ptr->transformed_pixel_depth;
  png_const_bytep sp = png_ptr->row_buf + 1;
  png_uint_32 row_width = png_ptr->width;
  unsigned int pass = png_ptr->pass;
  png_bytep end_ptr = 0;
  png_byte end_byte = 0;
  unsigned int end_mask;

  png_debug(1, "in png_combine_row");

  /* Added in 1.5.6: it should not be possible to enter this routine until at
   * least one row has been read from the PNG data and transformed.
   */
  if (pixel_depth == 0)
    png_error(png_ptr, "internal row logic error");

  /* Added in 1.5.4: the pixel depth should match the information returned by
   * any call to png_read_update_info at this point.  Do not continue if we got
   * this wrong.
   */
  if (png_ptr->info_rowbytes != 0 &&
      png_ptr->info_rowbytes != PNG_ROWBYTES(pixel_depth, row_width))
    png_error(png_ptr, "internal row size calculation error");

  /* Don't expect this to ever happen: */
  if (row_width == 0)
    png_error(png_ptr, "internal row width error");

  /* Preserve the last byte in cases where only part of it will be overwritten,
   * the multiply below may overflow, we don't care because ANSI-C guarantees
   * we get the low bits.
   */
  end_mask = (pixel_depth * row_width) & 7;
  if (end_mask != 0) {
    /* end_ptr == NULL is a flag to say do nothing */
    end_ptr = dp + PNG_ROWBYTES(pixel_depth, row_width) - 1;
    end_byte = *end_ptr;
#ifdef PNG_READ_PACKSWAP_SUPPORTED
    if ((png_ptr->transformations & PNG_PACKSWAP) != 0)
      /* little-endian byte */
      end_mask = (unsigned int)(0xff << end_mask);

    else /* big-endian byte */
#endif
      end_mask = 0xff >> end_mask;
    /* end_mask is now the bits to *keep* from the destination row */
  }

  /* For non-interlaced images this reduces to a memcpy(). A memcpy()
   * will also happen if interlacing isn't supported or if the application
   * does not call png_set_interlace_handling().  In the latter cases the
   * caller just gets a sequence of the unexpanded rows from each interlace
   * pass.
   */
#ifdef PNG_READ_INTERLACING_SUPPORTED
  if (png_ptr->interlaced != 0 &&
      (png_ptr->transformations & PNG_INTERLACE) != 0 && pass < 6 &&
      (display == 0 ||
       /* The following copies everything for 'display' on passes 0, 2 and 4. */
       (display == 1 && (pass & 1) != 0))) {
    /* Narrow images may have no bits in a pass; the caller should handle
     * this, but this test is cheap:
     */
    if (row_width <= PNG_PASS_START_COL(pass))
      return;

    if (pixel_depth < 8) {
      /* For pixel depths up to 4 bpp the 8-pixel mask can be expanded to fit
       * into 32 bits, then a single loop over the bytes using the four byte
       * values in the 32-bit mask can be used.  For the 'display' option the
       * expanded mask may also not require any masking within a byte.  To
       * make this work the PACKSWAP option must be taken into account - it
       * simply requires the pixels to be reversed in each byte.
       *
       * The 'regular' case requires a mask for each of the first 6 passes,
       * the 'display' case does a copy for the even passes in the range
       * 0..6.  This has already been handled in the test above.
       *
       * The masks are arranged as four bytes with the first byte to use in
       * the lowest bits (little-endian) regardless of the order (PACKSWAP or
       * not) of the pixels in each byte.
       *
       * NOTE: the whole of this logic depends on the caller of this function
       * only calling it on rows appropriate to the pass.  This function only
       * understands the 'x' logic; the 'y' logic is handled by the caller.
       *
       * The following defines allow generation of compile time constant bit
       * masks for each pixel depth and each possibility of swapped or not
       * swapped bytes.  Pass 'p' is in the range 0..6; 'x', a pixel index,
       * is in the range 0..7; and the result is 1 if the pixel is to be
       * copied in the pass, 0 if not.  'S' is for the sparkle method, 'B'
       * for the block method.
       *
       * With some compilers a compile time expression of the general form:
       *
       *    (shift >= 32) ? (a >> (shift-32)) : (b >> shift)
       *
       * Produces warnings with values of 'shift' in the range 33 to 63
       * because the right hand side of the ?: expression is evaluated by
       * the compiler even though it isn't used.  Microsoft Visual C (various
       * versions) and the Intel C compiler are known to do this.  To avoid
       * this the following macros are used in 1.5.6.  This is a temporary
       * solution to avoid destabilizing the code during the release process.
       */
#if PNG_USE_COMPILE_TIME_MASKS
#define PNG_LSR(x, s) ((x) >> ((s)&0x1f))
#define PNG_LSL(x, s) ((x) << ((s)&0x1f))
#else
#define PNG_LSR(x, s) ((x) >> (s))
#define PNG_LSL(x, s) ((x) << (s))
#endif
#define S_COPY(p, x)                                                           \
  (((p) < 4 ? PNG_LSR(0x80088822, (3 - (p)) * 8 + (7 - (x)))                   \
            : PNG_LSR(0xaa55ff00, (7 - (p)) * 8 + (7 - (x)))) &                \
   1)
#define B_COPY(p, x)                                                           \
  (((p) < 4 ? PNG_LSR(0xff0fff33, (3 - (p)) * 8 + (7 - (x)))                   \
            : PNG_LSR(0xff55ff00, (7 - (p)) * 8 + (7 - (x)))) &                \
   1)

      /* Return a mask for pass 'p' pixel 'x' at depth 'd'.  The mask is
       * little endian - the first pixel is at bit 0 - however the extra
       * parameter 's' can be set to cause the mask position to be swapped
       * within each byte, to match the PNG format.  This is done by XOR of
       * the shift with 7, 6 or 4 for bit depths 1, 2 and 4.
       */
#define PIXEL_MASK(p, x, d, s)                                                 \
  (PNG_LSL(((PNG_LSL(1U, (d))) - 1), (((x) * (d)) ^ ((s) ? 8 - (d) : 0))))

      /* Hence generate the appropriate 'block' or 'sparkle' pixel copy mask.
       */
#define S_MASKx(p, x, d, s) (S_COPY(p, x) ? PIXEL_MASK(p, x, d, s) : 0)
#define B_MASKx(p, x, d, s) (B_COPY(p, x) ? PIXEL_MASK(p, x, d, s) : 0)

      /* Combine 8 of these to get the full mask.  For the 1-bpp and 2-bpp
       * cases the result needs replicating, for the 4-bpp case the above
       * generates a full 32 bits.
       */
#define MASK_EXPAND(m, d)                                                      \
  ((m) * ((d) == 1 ? 0x01010101 : ((d) == 2 ? 0x00010001 : 1)))

#define S_MASK(p, d, s)                                                        \
  MASK_EXPAND(S_MASKx(p, 0, d, s) + S_MASKx(p, 1, d, s) +                      \
                  S_MASKx(p, 2, d, s) + S_MASKx(p, 3, d, s) +                  \
                  S_MASKx(p, 4, d, s) + S_MASKx(p, 5, d, s) +                  \
                  S_MASKx(p, 6, d, s) + S_MASKx(p, 7, d, s),                   \
              d)

#define B_MASK(p, d, s)                                                        \
  MASK_EXPAND(B_MASKx(p, 0, d, s) + B_MASKx(p, 1, d, s) +                      \
                  B_MASKx(p, 2, d, s) + B_MASKx(p, 3, d, s) +                  \
                  B_MASKx(p, 4, d, s) + B_MASKx(p, 5, d, s) +                  \
                  B_MASKx(p, 6, d, s) + B_MASKx(p, 7, d, s),                   \
              d)

#if PNG_USE_COMPILE_TIME_MASKS
      /* Utility macros to construct all the masks for a depth/swap
       * combination.  The 's' parameter says whether the format is PNG
       * (big endian bytes) or not.  Only the three odd-numbered passes are
       * required for the display/block algorithm.
       */
#define S_MASKS(d, s)                                                          \
  {                                                                            \
    S_MASK(0, d, s), S_MASK(1, d, s), S_MASK(2, d, s), S_MASK(3, d, s),        \
        S_MASK(4, d, s), S_MASK(5, d, s)                                       \
  }

#define B_MASKS(d, s)                                                          \
  { B_MASK(1, d, s), B_MASK(3, d, s), B_MASK(5, d, s) }

#define DEPTH_INDEX(d) ((d) == 1 ? 0 : ((d) == 2 ? 1 : 2))

      /* Hence the pre-compiled masks indexed by PACKSWAP (or not), depth and
       * then pass:
       */
      static const png_uint_32 row_mask[2 /*PACKSWAP*/][3 /*depth*/][6] = {
          /* Little-endian byte masks for PACKSWAP */
          {S_MASKS(1, 0), S_MASKS(2, 0), S_MASKS(4, 0)},
          /* Normal (big-endian byte) masks - PNG format */
          {S_MASKS(1, 1), S_MASKS(2, 1), S_MASKS(4, 1)}};

      /* display_mask has only three entries for the odd passes, so index by
       * pass>>1.
       */
      static const png_uint_32 display_mask[2][3][3] = {
          /* Little-endian byte masks for PACKSWAP */
          {B_MASKS(1, 0), B_MASKS(2, 0), B_MASKS(4, 0)},
          /* Normal (big-endian byte) masks - PNG format */
          {B_MASKS(1, 1), B_MASKS(2, 1), B_MASKS(4, 1)}};

#define MASK(pass, depth, display, png)                                        \
  ((display) ? display_mask[png][DEPTH_INDEX(depth)][pass >> 1]                \
             : row_mask[png][DEPTH_INDEX(depth)][pass])

#else /* !PNG_USE_COMPILE_TIME_MASKS */
      /* This is the runtime alternative: it seems unlikely that this will
       * ever be either smaller or faster than the compile time approach.
       */
#define MASK(pass, depth, display, png)                                        \
  ((display) ? B_MASK(pass, depth, png) : S_MASK(pass, depth, png))
#endif /* !USE_COMPILE_TIME_MASKS */

      /* Use the appropriate mask to copy the required bits.  In some cases
       * the byte mask will be 0 or 0xff; optimize these cases.  row_width is
       * the number of pixels, but the code copies bytes, so it is necessary
       * to special case the end.
       */
      png_uint_32 pixels_per_byte = 8 / pixel_depth;
      png_uint_32 mask;

#ifdef PNG_READ_PACKSWAP_SUPPORTED
      if ((png_ptr->transformations & PNG_PACKSWAP) != 0)
        mask = MASK(pass, pixel_depth, display, 0);

      else
#endif
        mask = MASK(pass, pixel_depth, display, 1);

      for (;;) {
        png_uint_32 m;

        /* It doesn't matter in the following if png_uint_32 has more than
         * 32 bits because the high bits always match those in m<<24; it is,
         * however, essential to use OR here, not +, because of this.
         */
        m = mask;
        mask = (m >> 8) | (m << 24); /* rotate right to good compilers */
        m &= 0xff;

        if (m != 0) /* something to copy */
        {
          if (m != 0xff)
            *dp = (png_byte)((*dp & ~m) | (*sp & m));
          else
            *dp = *sp;
        }

        /* NOTE: this may overwrite the last byte with garbage if the image
         * is not an exact number of bytes wide; libpng has always done
         * this.
         */
        if (row_width <= pixels_per_byte)
          break; /* May need to restore part of the last byte */

        row_width -= pixels_per_byte;
        ++dp;
        ++sp;
      }
    }

    else /* pixel_depth >= 8 */
    {
      unsigned int bytes_to_copy, bytes_to_jump;

      /* Validate the depth - it must be a multiple of 8 */
      if (pixel_depth & 7)
        png_error(png_ptr, "invalid user transform pixel depth");

      pixel_depth >>= 3; /* now in bytes */

      row_width *= pixel_depth;

      /* Regardless of pass number the Adam 7 interlace always results in a
       * fixed number of pixels to copy then to skip.  There may be a
       * different number of pixels to skip at the start though.
       */
      {
        unsigned int offset = PNG_PASS_START_COL(pass) * pixel_depth;

        row_width -= offset;
        dp += offset;
        sp += offset;
      }

      /* Work out the bytes to copy. */
      if (display != 0) {
        /* When doing the 'block' algorithm the pixel in the pass gets
         * replicated to adjacent pixels.  This is why the even (0,2,4,6)
         * passes are skipped above - the entire expanded row is copied.
         */
        bytes_to_copy = (1 << ((6 - pass) >> 1)) * pixel_depth;

        /* But don't allow this number to exceed the actual row width. */
        if (bytes_to_copy > row_width)
          bytes_to_copy = row_width;
      }

      else /* normal row; Adam7 only ever gives us one pixel to copy. */
        bytes_to_copy = pixel_depth;

      /* In Adam7 there is a constant offset between where the pixels go. */
      bytes_to_jump = PNG_PASS_COL_OFFSET(pass) * pixel_depth;

      /* And simply copy these bytes.  Some optimization is possible here,
       * depending on the value of 'bytes_to_copy'.  Special case the low
       * byte counts, which we know to be frequent.
       *
       * Notice that these cases all 'return' rather than 'break' - this
       * avoids an unnecessary test on whether to restore the last byte
       * below.
       */
      switch (bytes_to_copy) {
      case 1:
        for (;;) {
          *dp = *sp;

          if (row_width <= bytes_to_jump)
            return;

          dp += bytes_to_jump;
          sp += bytes_to_jump;
          row_width -= bytes_to_jump;
        }

      case 2:
        /* There is a possibility of a partial copy at the end here; this
         * slows the code down somewhat.
         */
        do {
          dp[0] = sp[0];
          dp[1] = sp[1];

          if (row_width <= bytes_to_jump)
            return;

          sp += bytes_to_jump;
          dp += bytes_to_jump;
          row_width -= bytes_to_jump;
        } while (row_width > 1);

        /* And there can only be one byte left at this point: */
        *dp = *sp;
        return;

      case 3:
        /* This can only be the RGB case, so each copy is exactly one
         * pixel and it is not necessary to check for a partial copy.
         */
        for (;;) {
          dp[0] = sp[0];
          dp[1] = sp[1];
          dp[2] = sp[2];

          if (row_width <= bytes_to_jump)
            return;

          sp += bytes_to_jump;
          dp += bytes_to_jump;
          row_width -= bytes_to_jump;
        }

      default:
#if PNG_ALIGN_TYPE != PNG_ALIGN_NONE
        /* Check for double byte alignment and, if possible, use a
         * 16-bit copy.  Don't attempt this for narrow images - ones that
         * are less than an interlace panel wide.  Don't attempt it for
         * wide bytes_to_copy either - use the memcpy there.
         */
        if (bytes_to_copy < 16 /*else use memcpy*/ &&
            png_isaligned(dp, png_uint_16) && png_isaligned(sp, png_uint_16) &&
            bytes_to_copy % (sizeof(png_uint_16)) == 0 &&
            bytes_to_jump % (sizeof(png_uint_16)) == 0) {
          /* Everything is aligned for png_uint_16 copies, but try for
           * png_uint_32 first.
           */
          if (png_isaligned(dp, png_uint_32) &&
              png_isaligned(sp, png_uint_32) &&
              bytes_to_copy % (sizeof(png_uint_32)) == 0 &&
              bytes_to_jump % (sizeof(png_uint_32)) == 0) {
            png_uint_32p dp32 = png_aligncast(png_uint_32p, dp);
            png_const_uint_32p sp32 =
                png_aligncastconst(png_const_uint_32p, sp);
            size_t skip =
                (bytes_to_jump - bytes_to_copy) / (sizeof(png_uint_32));

            do {
              size_t c = bytes_to_copy;
              do {
                *dp32++ = *sp32++;
                c -= (sizeof(png_uint_32));
              } while (c > 0);

              if (row_width <= bytes_to_jump)
                return;

              dp32 += skip;
              sp32 += skip;
              row_width -= bytes_to_jump;
            } while (bytes_to_copy <= row_width);

            /* Get to here when the row_width truncates the final copy.
             * There will be 1-3 bytes left to copy, so don't try the
             * 16-bit loop below.
             */
            dp = (png_bytep)dp32;
            sp = (png_const_bytep)sp32;
            do
              *dp++ = *sp++;
            while (--row_width > 0);
            return;
          }

          /* Else do it in 16-bit quantities, but only if the size is
           * not too large.
           */
          else {
            png_uint_16p dp16 = png_aligncast(png_uint_16p, dp);
            png_const_uint_16p sp16 =
                png_aligncastconst(png_const_uint_16p, sp);
            size_t skip =
                (bytes_to_jump - bytes_to_copy) / (sizeof(png_uint_16));

            do {
              size_t c = bytes_to_copy;
              do {
                *dp16++ = *sp16++;
                c -= (sizeof(png_uint_16));
              } while (c > 0);

              if (row_width <= bytes_to_jump)
                return;

              dp16 += skip;
              sp16 += skip;
              row_width -= bytes_to_jump;
            } while (bytes_to_copy <= row_width);

            /* End of row - 1 byte left, bytes_to_copy > row_width: */
            dp = (png_bytep)dp16;
            sp = (png_const_bytep)sp16;
            do
              *dp++ = *sp++;
            while (--row_width > 0);
            return;
          }
        }
#endif /* ALIGN_TYPE code */

        /* The true default - use a memcpy: */
        for (;;) {
          memcpy(dp, sp, bytes_to_copy);

          if (row_width <= bytes_to_jump)
            return;

          sp += bytes_to_jump;
          dp += bytes_to_jump;
          row_width -= bytes_to_jump;
          if (bytes_to_copy > row_width)
            bytes_to_copy = row_width;
        }
      }

      /* NOT REACHED*/
    } /* pixel_depth >= 8 */

    /* Here if pixel_depth < 8 to check 'end_ptr' below. */
  } else
#endif /* READ_INTERLACING */

    /* If here then the switch above wasn't used so just memcpy the whole row
     * from the temporary row buffer (notice that this overwrites the end of the
     * destination row if it is a partial byte.)
     */
    memcpy(dp, sp, PNG_ROWBYTES(pixel_depth, row_width));

  /* Restore the overwritten bits from the last byte if necessary. */
  if (end_ptr != NULL)
    *end_ptr = (png_byte)((end_byte & end_mask) | (*end_ptr & ~end_mask));
}

