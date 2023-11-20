void create()
{
  int i;
  unsigned int atoi;
  Weapon *v2;

  for ( i = 0; i <= 8; ++i )
  {
    if ( !weapon_list[i] )
    {
      puts_flush("size: ");
      atoi = read_atoi();
      if ( atoi == 96 || atoi == 256 || atoi == 79 )
      {
        v2 = (Weapon *)malloc((int)atoi);
        v2->attack_times = 0LL;
        v2->attack_numbers = time(0LL) % 10 + 96;
        puts_flush("Give me the name: ");
        read_str(v2->name, atoi);
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