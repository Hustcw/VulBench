int sub_1930()
{
  int v0;
  _BYTE **v1;
  _BYTE *v2;
  char v3;

  if ( unk_205B40 > 1 )
  {
    v0 = 1;
    v1 = (_BYTE **)((char *)&unk_204040 + 8);
    do
    {
      v2 = *v1;
      if ( **v1 == 62 )
      {
        v3 = v2[1];
        if ( !v3 || v3 == 62 && !v2[2] )
          break;
      }
      ++v0;
      ++v1;
      _printf_chk(1LL, "%s ", v2);
    }
    while ( unk_205B40 > v0 );
  }
  return putchar(10);
}
