void __fastcall MAGMA_png_check_chunk_length(png_const_structrp png_ptr, png_uint_32 length)
{
  png_alloc_size_t user_chunk_malloc_max;
  unsigned __int64 v3;
  unsigned __int64 height;
  __int64 v5;
  unsigned __int64 v6;
  unsigned __int64 v7;
  unsigned __int64 v8;

  user_chunk_malloc_max = png_ptr->user_chunk_malloc_max;
  v3 = 0x7FFFFFFFLL;
  if ( user_chunk_malloc_max - 1 >= 0x7FFFFFFE )
    user_chunk_malloc_max = 0x7FFFFFFFLL;
  if ( png_ptr->chunk_name == 1229209940 )
  {
    height = png_ptr->height;
    v5 = 6LL;
    if ( !png_ptr->interlaced )
      v5 = 0LL;
    v6 = png_ptr->width * (unsigned __int64)png_ptr->channels * ((png_ptr->bit_depth > 8u) + 1LL) + v5 + 1;
    v7 = height * v6;
    if ( 0xFFFFFFFF / v6 < height )
      v7 = 0x7FFFFFFFLL;
    v8 = 32566LL;
    if ( v6 < 0x7F36 )
      v8 = png_ptr->width * (unsigned __int64)png_ptr->channels * ((png_ptr->bit_depth > 8u) + 1LL) + v5 + 1;
    if ( v7 + 5 * (v7 / v8) + 11 < 0x7FFFFFFF )
      v3 = v7 + 5 * (v7 / v8) + 11;
    if ( user_chunk_malloc_max < v3 )
      user_chunk_malloc_max = v3;
  }
  if ( user_chunk_malloc_max < length )
    MAGMA_png_chunk_error(png_ptr, "chunk data is too large");
}
