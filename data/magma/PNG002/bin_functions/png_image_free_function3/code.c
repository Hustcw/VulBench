int __fastcall png_image_free_function(png_voidp argument)
{
  __int128 *v1;
  __int128 v2;
  __int128 v3;
  int result;
  png_const_structrp png_ptr[2];
  __int128 v6;
  __int128 v7;

  v1 = *(__int128 **)argument;
  if ( **(_QWORD **)argument )
  {
    v2 = *v1;
    v3 = v1[1];
    v7 = v1[2];
    v6 = v3;
    *(_OWORD *)png_ptr = v2;
    *(_QWORD *)argument = png_ptr;
    MAGMA_png_free(png_ptr[0], v1);
    if ( (BYTE8(v7) & 1) != 0 )
      MAGMA_png_error(png_ptr[0], "simplified write not supported");
    MAGMA_png_destroy_read_struct((png_structpp)png_ptr, (png_infopp)&png_ptr[1], 0LL);
  }
  return result;
}
