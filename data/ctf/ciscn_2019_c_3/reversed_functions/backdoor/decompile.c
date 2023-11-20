void backdoor()
{
  signed int v0;
  unsigned int atoi;
  char s[1000];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  v0 = 0;
  puts_flush("Can't beat down them?Let me add the attack_number for you !! ");
  puts_flush("weapon:");
  atoi = read_atoi();
  if ( atoi <= 8 && weapon_list[atoi] )
  {
    while ( (int)(atoi - 1) > v0 )
    {
      ++weapon_list[atoi]->attack_times;
      ++v0;
    }
  }
  snprintf(
    s,
    0x100uLL,
    "weapons'name: %s\nattack_times: %lu\nattack_numbers: %lu",
    weapon_list[atoi]->name,
    weapon_list[atoi]->attack_times,
    weapon_list[atoi]->attack_numbers);
  puts_flush(s);
}