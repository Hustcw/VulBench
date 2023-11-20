__int64 __fastcall getn(char *a1, unsigned int a2)
{
  char buf;
  unsigned int i;

  for ( i = 0; i < a2; ++i )
  {
    read(0, &buf, 1uLL);
    if ( buf == 10 )
      break;
    a1[i] = buf;
  }
  return i;
}