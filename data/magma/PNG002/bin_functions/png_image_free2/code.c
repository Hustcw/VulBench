void __fastcall MAGMA_png_image_free(__int64 a1)
{
  if ( a1 && *(_QWORD *)a1 && !*(_QWORD *)(*(_QWORD *)a1 + 16LL) )
  {
    MAGMA_png_safe_execute(a1, png_image_free_function, a1);
    *(_QWORD *)a1 = 0LL;
  }
}
