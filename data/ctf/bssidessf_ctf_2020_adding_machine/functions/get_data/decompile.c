unsigned __int64 __fastcall get_data(__int64 *a1, unsigned __int8 a2)
{
  int i;
  char s[40];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    snprintf(s, 0x20uLL, "long %d", (unsigned int)i);
    *a1++ = get_long(s);
  }
  return __readfsqword(0x28u) ^ v6;
}
