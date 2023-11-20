void sub_400D2C()
{
  int i;
  int v1;
  _QWORD *v2;

  for ( i = 0; i <= 15; ++i )
  {
    if ( !*(&ptr + i) )
    {
      sub_400C52("Please enter the name's size: ");
      v1 = sub_400C90();
      if ( v1 > 0 && v1 <= 4096 )
      {
        v2 = malloc(v1 + 16);
        *v2 = 0LL;
        v2[1] = time(0LL);
        sub_400C52("Please enter the name: ");
        sub_400B76((__int64)(v2 + 2), v1);
        *(&ptr + i) = v2;
      }
      return;
    }
  }
}
