int __fastcall png_image_free_function(png_voidp argument)
{
  __int128 *v1;
  __int128 v2;
  __int128 v3;
  png_const_structrp png_ptr[2];
  __int128 v6;
  __int128 v7;

  v1 = *(__int128 **)argument;
  if ( !**(_QWORD **)argument )
    return 0;
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
  *((_BYTE *)argument + 24) |= 8u;
  return 1;
}


__int64 __fastcall MAGMA_png_safe_execute(__int64 a1, __int64 (__fastcall *a2)(__int64), __int64 a3)
{
  int v4;
  unsigned int v6;
  __int64 v7;
  struct __jmp_buf_tag env[1];

  v7 = *(_QWORD *)(*(_QWORD *)a1 + 16LL);
  v4 = _setjmp(env);
  v6 = v4 == 0;
  if ( !v4 )
  {
    *(_QWORD *)(*(_QWORD *)a1 + 16LL) = env;
    v6 = a2(a3);
  }
  *(_QWORD *)(*(_QWORD *)a1 + 16LL) = v7;
  if ( !v6 )
    MAGMA_png_image_free(a1);
  return v6;
}


void __fastcall MAGMA_png_image_free(__int64 a1)
{
  if ( a1 && *(_QWORD *)a1 && !*(_QWORD *)(*(_QWORD *)a1 + 16LL) )
  {
    MAGMA_png_safe_execute(a1, png_image_free_function, a1);
    *(_QWORD *)a1 = 0LL;
  }
}
