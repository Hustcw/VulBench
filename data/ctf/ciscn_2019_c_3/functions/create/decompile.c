void create()
{
  int i;
  int atoi;
  _QWORD *v2;

  for ( i = 0; i <= 8; ++i )
  {
    if ( !weapon_list[i] )
    {
      puts_flush("size: ");
      atoi = read_atoi();
      if ( atoi == 96 || atoi == 256 || atoi == 79 )
      {
        v2 = malloc(atoi);
        *v2 = 0LL;
        v2[1] = time(0LL) % 10 + 96;
        puts_flush("Give me the name: ");
        read_context((__int64)(v2 + 2), atoi);
        weapon_list[i] = v2;
      }
      else
      {
        puts_flush("you can only create three kinds of weapons");
      }
      return;
    }
  }
}
