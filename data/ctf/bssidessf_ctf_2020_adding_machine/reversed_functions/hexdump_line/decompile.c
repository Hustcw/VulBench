unsigned __int64 __fastcall hexdump_line(_BYTE *a1)
{
  char v2;
  int i;
  int j;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  printf("%p | ", a1);
  for ( i = 0; i <= 15; ++i )
  {
    printf("%02x ", (unsigned __int8)a1[i]);
    if ( i == 7 )
      putchar(' ');
  }
  putchar(124);
  for ( j = 0; j <= 15; ++j )
  {
    v2 = a1[j];
    if ( v2 <= 0x1F || v2 == 0x7F )
      putchar('.');
    else
      putchar(v2);
  }
  puts("|");
  return __readfsqword(0x28u) ^ v5;
}