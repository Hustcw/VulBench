__int64 __fastcall sub_A97(__int64 a1, unsigned int a2, int a3)
{
  __int64 result;
  int v5;

  v5 = sub_985(a1, a2, a3);
  result = a2;
  if ( (int)a2 < a3 )
  {
    sub_A97(a1, a2, (unsigned int)(v5 - 1));
    return sub_A97(a1, (unsigned int)(v5 + 1), (unsigned int)a3);
  }
  return result;
}
