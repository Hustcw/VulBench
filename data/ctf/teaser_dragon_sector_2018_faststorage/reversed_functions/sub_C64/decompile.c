_BOOL8 __fastcall sub_C64(int a1, char a2, char a3)
{
  return (((1 << a2) | (1 << a3)) & dword_202040[a1]) == ((1 << a2) | (1 << a3));
}