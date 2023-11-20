__int64 __fastcall sub_40144E(__int64 a1, __int64 a2)
{
  int v3;

  if ( !a1 )
    return 0LL;
  v3 = *(_DWORD *)(a1 + 12) + 1;
  if ( v3 == *(_DWORD *)(a1 + 8) )
    return 0LL;
  *(_QWORD *)(*(_QWORD *)a1 + 8LL * v3) = a2;
  *(_DWORD *)(a1 + 12) = v3;
  return 1LL;
}
