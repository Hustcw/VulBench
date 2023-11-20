size_t __fastcall get_input(__int64 a1, int a2)
{
  size_t result;
  signed int v3;
  _BYTE *v4;

  v3 = 0;
  while ( 1 )
  {
    v4 = (_BYTE *)(v3 + a1);
    result = fread(v4, 1uLL, 1uLL, stdin);
    if ( (int)result <= 0 )
      break;
    if ( *v4 == 10 )
    {
      if ( v3 )
      {
        result = v3 + a1;
        *v4 = 0;
        return result;
      }
    }
    else
    {
      result = (unsigned int)++v3;
      if ( a2 + 1 <= (unsigned int)v3 )
        return result;
    }
  }
  return result;
}
