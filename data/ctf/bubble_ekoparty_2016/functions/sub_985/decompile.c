__int64 __fastcall sub_985(__int64 a1, unsigned int a2, int a3)
{
  int v3;
  int v5;
  unsigned int v6;
  unsigned int v7;
  int v8;
  int v9;

  v7 = *(_DWORD *)(4LL * (int)a2 + a1);
  v5 = a2 + 1;
  v6 = a2;
  while ( v5 <= a3 )
  {
    v3 = v5++;
    if ( *(_DWORD *)(4LL * v3 + a1) < v7 )
    {
      v8 = *(_DWORD *)(4LL * ++v6 + a1);
      *(_DWORD *)(a1 + 4LL * v6) = *(_DWORD *)(4LL * v5 - 4 + a1);
      *(_DWORD *)(a1 + 4LL * v5 - 4) = v8;
    }
  }
  v9 = *(_DWORD *)(4LL * v6 + a1);
  *(_DWORD *)(a1 + 4LL * v6) = v7;
  *(_DWORD *)(a1 + 4LL * (int)a2) = v9;
  return v6;
}
