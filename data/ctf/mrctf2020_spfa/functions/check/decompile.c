__int64 __fastcall check(unsigned int a1, unsigned int a2, int a3)
{
  if ( a1 == a2 || a3 < 0 || a1 > 0x1D || a2 > 0x1D || used[30 * a1 + a2] )
    return 0LL;
  used[30 * a1 + a2] = 1;
  return 1LL;
}
