void __cdecl sub_D8E(int a1)
{
  char s[20];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  printf("Your note: ");
  if ( a1 )
    read_str(s, 0x14u);
  else
    puts(s);
}