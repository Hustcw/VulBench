void __fastcall sub_A97(unsigned int *a1, unsigned int a2, unsigned int a3)
{
  int v4;

  v4 = sub_985((__int64)a1, a2, a3);
  if ( (int)a2 < (int)a3 )
  {
    sub_A97(a1, a2, v4 - 1);
    sub_A97(a1, v4 + 1, a3);
  }
}