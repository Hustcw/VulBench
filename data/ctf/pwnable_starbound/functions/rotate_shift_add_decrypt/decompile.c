int __cdecl rotate_shift_add_decrypt(int a1, _DWORD *a2)
{
  int v2;
  int result;

  v2 = (unsigned __int16)((2 * *a2) | (*a2 >> 15));
  *a2 = v2;
  result = (a1 - v2 - 32) % 95 + ((a1 - v2 - 32) % 95 < 0 ? 0x5F : 0);
  if ( result <= 31 )
    result += 95;
  return result;
}
