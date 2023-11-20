void dele()
{
  unsigned int atoi;

  puts_flush("weapon:");
  atoi = read_atoi();
  if ( atoi <= 8 )
  {
    if ( weapon_list[atoi] )
      free((void *)weapon_list[atoi]);
  }
}
