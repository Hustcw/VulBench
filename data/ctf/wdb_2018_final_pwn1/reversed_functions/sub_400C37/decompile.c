__int64 __fastcall sub_400C37(void *a1, unsigned int a2)
{
  char buf; // [rsp+13h] [rbp-Dh] BYREF
  int i; // [rsp+14h] [rbp-Ch]
  unsigned __int64 v5; // [rsp+18h] [rbp-8h]

  v5 = __readfsqword(0x28u);
  memset(a1, 0, a2);
  for ( i = 0; a2 - 1 > i; ++i )
  {
    buf = 0;
    if ( read(0, &buf, 1uLL) != 1 || buf == 10 )
      break;
    *((_BYTE *)a1 + i) = buf;
  }
  return a2;
}