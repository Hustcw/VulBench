deinterlace_row(png_bytep buffer, png_const_bytep row,
   unsigned int pixel_size, png_uint_32 w, int pass)
{
   /* The inverse of the above, 'row' is part of row 'y' of the output image,
    * in 'buffer'.  The image is 'w' wide and this is pass 'pass', distribute
    * the pixels of row into buffer and return the number written (to allow
    * this to be checked).
    */
   png_uint_32 xin, xout, xstep;
   xout = PNG_PASS_START_COL(pass);
   xstep = 1U<<PNG_PASS_COL_SHIFT(pass);
   for (xin=0; xout<w; xout+=xstep)
   {
      pixel_copy(buffer, xout, row, xin, pixel_size);
      ++xin;
   }
}
