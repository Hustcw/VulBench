void __fastcall MAGMA_png_check_chunk_length(png_const_structrp png_ptr, png_uint_32 length)
{
  png_alloc_size_t user_chunk_malloc_max;
  unsigned __int64 v3;
  int v4;
  __int64 v5;
  unsigned __int64 v6;
  unsigned __int64 v7;

  user_chunk_malloc_max = png_ptr->user_chunk_malloc_max;
  v3 = 0x7FFFFFFFLL;
  if ( user_chunk_malloc_max - 1 >= 0x7FFFFFFE )
    user_chunk_malloc_max = 0x7FFFFFFFLL;
  if ( png_ptr->chunk_name == 1229209940 )
  {
    v4 = 6;
    if ( !png_ptr->interlaced )
      v4 = 0;
    v5 = png_ptr->width * png_ptr->channels * ((png_ptr->bit_depth > 8u) + 1) + v4 + 1;
    v6 = v5 * png_ptr->height;
    if ( 0xFFFFFFFF / (unsigned int)v5 < png_ptr->height )
      v6 = 0x7FFFFFFFLL;
    v7 = 32566LL;
    if ( (unsigned int)v5 < 0x7F36 )
      v7 = png_ptr->width * png_ptr->channels * ((png_ptr->bit_depth > 8u) + 1) + v4 + 1;
    if ( v6 + 5 * (v6 / v7) + 11 < 0x7FFFFFFF )
      v3 = v6 + 5 * (v6 / v7) + 11;
    if ( user_chunk_malloc_max < v3 )
      user_chunk_malloc_max = v3;
  }
  if ( user_chunk_malloc_max < length )
    MAGMA_png_chunk_error(png_ptr, "chunk data is too large");
}
