__int64 __fastcall sub_4014B4(__int64 a1, _QWORD *a2)
{
  if ( !a1 )
    return 0LL;
  if ( *(_DWORD *)(a1 + 12) == -1 )
    return 0LL;
  *a2 = *(_QWORD *)(*(_QWORD *)a1 + 8LL * (int)(*(_DWORD *)(a1 + 12))--);
  return 1LL;
}
