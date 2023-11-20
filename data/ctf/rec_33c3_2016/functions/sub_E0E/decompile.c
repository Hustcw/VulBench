unsigned int sub_E0E()
{
  unsigned int result;
  char v1[2];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  do
  {
    puts("0 - Take note");
    puts("1 - Read note");
    puts("2 - Polish");
    puts("3 - Infix");
    puts("4 - Reverse Polish");
    puts("5 - Sign");
    puts("6 - Exit");
    printf("> ");
    sub_6C0((int)v1, 2u);
    if ( v1[0] == 48 )
      sub_D8E(1);
    if ( v1[0] == 49 )
      sub_D8E(0);
    if ( v1[0] == 50 )
      sub_AA3();
    if ( v1[0] == 51 )
      sub_87B();
    if ( v1[0] == 52 )
      sub_732();
    if ( v1[0] == 53 )
      sub_D57();
  }
  while ( v1[0] != 54 );
  result = __readgsdword(0x14u) ^ v2;
  if ( result )
    sub_1030();
  return result;
}
