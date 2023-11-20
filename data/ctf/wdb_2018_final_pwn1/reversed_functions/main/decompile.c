void __fastcall __noreturn main(int a1, const char **a2, char **a3)
{
  char v3; // al
  char v4; // al

  printf("Put the code: ");
  sub_400C37(byte_6024E0, 0x400u);
  for ( byte_6024C1 = 0; ; ++byte_6024C1 )
  {
    byte_6028E1 = byte_6024E0[byte_6024C1];
    if ( !byte_6028E1 )
      break;
    byte_6028E0 = 0;
    if ( byte_6028E1 == 62 )
      ++byte_6024C0;
    if ( byte_6028E1 == 60 )
      --byte_6024C0;
    if ( byte_6028E1 == 43 )
      ++byte_6020C0[byte_6024C0];
    if ( byte_6028E1 == 45 )
      --byte_6020C0[byte_6024C0];
    if ( byte_6028E1 == 46 )
      _IO_putc(byte_6020C0[byte_6024C0], stdout);
    if ( byte_6028E1 == 44 )
      read(0, &byte_6020C0[byte_6024C0], 1uLL);
    while ( byte_6028E1 == '[' && !byte_6020C0[byte_6024C0] )
    {
      if ( byte_6024E0[byte_6024C1] == '[' )
        ++byte_6028E0;
      if ( byte_6024E0[byte_6024C1] == ']' )
      {
        v3 = byte_6028E0--;
        if ( v3 == 1 )
          break;
      }
      ++byte_6024C1;
    }
    while ( byte_6028E1 == 93 && byte_6020C0[byte_6024C0] )
    {
      if ( byte_6024E0[byte_6024C1] == 93 )
        ++byte_6028E0;
      if ( byte_6024E0[byte_6024C1] == 91 )
      {
        v4 = byte_6028E0--;
        if ( v4 == 1 )
          break;
      }
      --byte_6024C1;
    }
  }
  exit(1);
}