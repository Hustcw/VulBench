char byte_6020C0[1024]; // weak
char byte_6024C0; // weak
char byte_6024C1; // weak
_BYTE byte_6024E0[1024]; // weak
char byte_6028E0; // weak
char byte_6028E1; // weak
char byte_6020C0[1024]; // weak
char byte_6024C0; // weak
char byte_6024C1; // weak
_BYTE byte_6024E0[1024]; // weak
char byte_6028E0; // weak
char byte_6028E1; // weak

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

__int64 __fastcall sub_400C37(void *a1, unsigned int a2)
{
  char buf; // [rsp+13h] [rbp-Dh] BYREF
  int i; // [rsp+14h] [rbp-Ch]
  unsigned __int64 v5; // [rsp+18h] [rbp-8h]

  v5 = __readfsqword(0x28u);
  memset(a1, 0, a2);
  for ( i = 0; a2 - 1 > i; ++i )
  {
    buf = 0;
    if ( read(0, &buf, 1uLL) != 1 || buf == 10 )
      break;
    *((_BYTE *)a1 + i) = buf;
  }
  return a2;
}
