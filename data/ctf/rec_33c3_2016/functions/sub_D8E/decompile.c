unsigned int __cdecl sub_D8E(int a1)
{
  unsigned int result;
  char s[20];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  printf("Your note: ");
  if ( a1 )
    sub_6C0((int)s, 0x14u);
  else
    puts(s);
  result = __readgsdword(0x14u) ^ v3;
  if ( result )
    sub_1030();
  return result;
}
