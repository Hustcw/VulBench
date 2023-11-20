__int64 __fastcall sub_400C37(void *a1, unsigned int a2)
{
  char buf;
  unsigned int i;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  memset(a1, 0, a2);
  for ( i = 0; a2 - 1 > i; ++i )
  {
    buf = 0;
    if ( read(0, &buf, 1uLL) != 1 || buf == 10 )
      break;
    *((_BYTE *)a1 + (int)i) = buf;
  }
  return a2;
}
