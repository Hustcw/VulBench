__int64 __fastcall add_nums(__int64 a1, unsigned __int8 a2)
{
  int i;
  __int64 v4;

  v4 = 0LL;
  for ( i = 0; i < a2; ++i )
    v4 += *(_QWORD *)(8LL * i + a1);
  return v4;
}