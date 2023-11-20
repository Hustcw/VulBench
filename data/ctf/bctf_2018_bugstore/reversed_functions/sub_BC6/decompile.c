__int64 __fastcall sub_BC6(_BYTE *a1, unsigned int a2)
{
  _BYTE *v2; // rbp
  unsigned int v3; // ebx
  char buf; // [rsp+7h] [rbp-31h] BYREF
  unsigned __int64 v6; // [rsp+8h] [rbp-30h]

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