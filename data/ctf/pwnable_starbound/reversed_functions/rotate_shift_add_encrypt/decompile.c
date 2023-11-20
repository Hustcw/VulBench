int __cdecl rotate_shift_add_encrypt(int a1, _DWORD *a2)
{
  int v2;

  v2 = (unsigned __int16)((2 * *a2) | (*a2 >> 15));
  *a2 = v2;
  return (a1 + v2) % 95 + 32;
}