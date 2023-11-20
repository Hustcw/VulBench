__int64 *__fastcall sub_400EC8(__int64 *a1)
{
  __int64 v1;
  __int64 *result;

  v1 = ((__int64)(rand() % 100000) << 16) % 1610612736;
  result = a1;
  *a1 = v1;
  return result;
}
