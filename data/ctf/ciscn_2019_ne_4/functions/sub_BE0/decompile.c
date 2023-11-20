__int64 __fastcall sub_BE0(int a1)
{
  int v2[3];
  unsigned __int64 v3;

  v2[0] = a1;
  v3 = __readfsqword(0x28u);
  v2[2] = _isoc99_scanf("%d", v2);
  if ( v2[0] < 0x101u )
    return (unsigned int)v2[0];
  else
    return 10LL;
}
