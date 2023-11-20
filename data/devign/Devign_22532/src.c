static void xvid_idct_put(uint8_t *dest, ptrdiff_t line_size, int16_t *block)

{

    ff_xvid_idct(block);

    ff_put_pixels_clamped(block, dest, line_size);

}
