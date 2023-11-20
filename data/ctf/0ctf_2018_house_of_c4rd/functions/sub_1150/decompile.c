unsigned __int64 __fastcall sub_1150(int a1, __int64 a2, unsigned __int64 a3)
{
  unsigned __int64 i;

  for ( i = 0LL; i < a3; i += write(a1, (const void *)(i + a2), a3 - i) )
    ;
  return i;
}
