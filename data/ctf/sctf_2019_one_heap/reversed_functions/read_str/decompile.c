void __fastcall read_str(_BYTE *a1, __int64 a2)
{
  _BYTE *v2;
  char buf;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
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
}