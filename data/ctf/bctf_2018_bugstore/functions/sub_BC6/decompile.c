__int64 __fastcall sub_BC6(_BYTE *a1, unsigned int a2)
{
  _BYTE *v2;
  unsigned int v3;
  char buf;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  if ( a2 )
  {
    v2 = a1;
    v3 = 0;
    while ( 1 )
    {
      read(0, &buf, 1uLL);
      if ( buf == 10 || !buf )
        break;
      ++v3;
      *v2++ = buf;
      if ( a2 == v3 )
        goto LABEL_7;
    }
    a1[v3] = 0;
    return v3;
  }
  else
  {
LABEL_7:
    a1[a2 - 1] = 0;
    return a2;
  }
}
