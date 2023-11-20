__int64 __fastcall sub_BE0(int a1)
{
  int v2;
  int v3;
  unsigned __int64 v4;

  v2 = a1;
  v4 = __readfsqword(0x28u);
  v3 = _isoc99_scanf("%d", &v2);
  if ( (unsigned int)v2 < 0x101 )
    return (unsigned int)v2;
  else
    return '\n';
}