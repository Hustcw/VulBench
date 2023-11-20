__int64 __fastcall sub_401D37(__int64 a1)
{
  __int64 v2;
  __int64 v3;

  if ( !(unsigned int)sub_4014B4(a1, &v2) || !(unsigned int)sub_4014B4(a1, &v3) )
    return 0LL;
  *(_QWORD *)(8 * (*(int *)(a1 + 12) + v2) + *(_QWORD *)a1) = v3;
  return 1LL;
}
