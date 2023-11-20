_BOOL8 sub_4007CD()
{
  int i;
  int v2;
  unsigned int v3;
  unsigned int v4;
  char format[128];
  char nptr[136];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  v2 = 0;
  puts("Tell me your name first");
  gets(format);
  strcat(format, ", your response: ");
  puts("Alright, pass a little test first, would you.");
  for ( i = 0; i < 10; ++i )
  {
    v3 = rand() % 0x10000;
    v4 = rand() % 0x10000;
    printf("%d + %d = ?\n", v3, v4);
    printf(format);
    gets(nptr);
    if ( v3 + v4 == atoi(nptr) )
      ++v2;
  }
  return v2 != 10;
}
