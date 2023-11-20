__int64 __fastcall sub_400FA6(__int64 *a1)
{
  __int64 result;
  __int64 v2;

  v2 = rand() % 100000;
  result = (v2 << (rand() % 5)) % 0xFFFFFFFFFLL;
  *a1 = result;
  return result;
}
