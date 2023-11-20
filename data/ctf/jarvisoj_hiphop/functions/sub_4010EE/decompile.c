__int64 __fastcall sub_4010EE(__int64 a1)
{
  __int64 result;
  int i;

  strcpy((char *)a1, "attack");
  sub_400CD6((_QWORD *)(a1 + 40));
  result = a1;
  *(_BYTE *)(a1 + 32) = 0;
  for ( i = 1; i <= 7; ++i )
  {
    result = i;
    *(_BYTE *)(a1 + i + 32) = 0;
  }
  return result;
}
