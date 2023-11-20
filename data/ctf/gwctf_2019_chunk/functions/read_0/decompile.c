__int64 __fastcall read_0(__int64 a1, int a2)
{
  unsigned int i;
  char buf[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; (int)i < a2; ++i )
  {
    read(0, buf, 1uLL);
    if ( buf[0] == 10 )
      break;
    *(_BYTE *)(a1 + (int)i) = buf[0];
  }
  *(_BYTE *)((int)i + a1) = 0;
  return i;
}
