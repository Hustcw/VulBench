int __cdecl is_printable(char *s)
{
  size_t i; // [esp+Ch] [ebp-Ch]

  for ( i = 0; strlen(s) > i; ++i )
  {
    if ( s[i] <= 31 || s[i] == 127 )
      return 0;
  }
  return 1;
}