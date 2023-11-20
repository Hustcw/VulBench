void show()
{
  unsigned int atoi;
  char s[1000];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts_flush("index: ");
  atoi = read_atoi();
  if ( atoi <= 8 )
  {
    if ( weapon_list[atoi] )
    {
      snprintf(
        s,
        0x100uLL,
        "weapons'name: %s\nattack_times: %lu\nattack_numbers: %lu",
        weapon_list[atoi]->name,
        weapon_list[atoi]->attack_times,
        weapon_list[atoi]->attack_numbers);
      puts_flush(s);
    }
  }
}