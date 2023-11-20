void sub_80485FB()
{
  char *dest;
  int i;
  char *v2;

  for ( i = 0; i <= 2; ++i )
  {
    dest = (char *)malloc(0x90u);
    if ( !i )
    {
      dword_8049FB8 = (int)dest;
      v2 = dest;
    }
    strcpy(dest, (&src)[i]);
    *((_DWORD *)dest + 35) = 0;
    *((_DWORD *)v2 + 35) = dest;
    v2 = dest;
  }
  dword_8049FB4 = 3;
}
