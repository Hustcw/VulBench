unsigned __int64 __fastcall sub_B70(_BYTE *a1, __int64 a2)
{
  _BYTE *v2;
  char buf;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  if ( a2 )
  {
    v2 = a1;
    do
    {
      buf = 0;
      if ( read(0, &buf, 1uLL) < 0 )
      {
        puts("Read error!!\n");
        exit(1);
      }
      if ( buf == 10 )
        break;
      *v2++ = buf;
    }
    while ( v2 != &a1[a2] );
  }
  return __readfsqword(0x28u) ^ v5;
}
