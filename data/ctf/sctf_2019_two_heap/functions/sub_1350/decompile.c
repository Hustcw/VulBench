unsigned __int64 __fastcall sub_1350(_BYTE *a1, int a2)
{
  _BYTE *v2;
  char v3;
  char buf;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  if ( a2 > 0 )
  {
    v2 = a1;
    do
    {
      buf = 0;
      if ( read(0, &buf, 1uLL) <= 0 )
        exit(0);
      v3 = buf;
      *v2 = buf;
      if ( v3 == 10 )
        break;
      ++v2;
    }
    while ( v2 != &a1[a2 - 1 + 1] );
  }
  return __readfsqword(0x28u) ^ v6;
}
