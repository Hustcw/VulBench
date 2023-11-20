void sub_E0E()
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
    read_str(v1, 2u);
    if ( v1[0] == '0' )
      sub_D8E(1);
    if ( v1[0] == '1' )
      sub_D8E(0);
    if ( v1[0] == '2' )
      sub_AA3();
    if ( v1[0] == '3' )
      sub_87B();
    if ( v1[0] == '4' )
      sub_732();
    if ( v1[0] == '5' )
      sub_D57();
  }
  while ( v1[0] != 54 );
}