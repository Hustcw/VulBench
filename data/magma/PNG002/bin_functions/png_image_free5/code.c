void __fastcall MAGMA_png_image_free(png_voidp argument)
{
  if ( argument && *(_QWORD *)argument && !*(_QWORD *)(*(_QWORD *)argument + 16LL) )
  {
    png_image_free_function(argument);
    *(_QWORD *)argument = 0LL;
  }
}
