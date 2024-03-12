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
