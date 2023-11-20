unsigned __int64 __fastcall sub_B41(_BYTE *a1, int a2)
{
  _BYTE *buf;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( buf = a1; &a1[a2] != buf && read(0, buf, 1uLL) == 1 && *buf != 10 && *buf; ++buf )
    ;
  *buf = 0;
  return __readfsqword(0x28u) ^ v4;
}
