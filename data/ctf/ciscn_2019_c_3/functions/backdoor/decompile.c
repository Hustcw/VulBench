unsigned __int64 backdoor()
{
  signed int v1;
  unsigned int atoi;
  char s[1000];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  v1 = 0;
  puts_flush("Can't beat down them?Let me add the attack_number for you !! ");
  puts_flush("weapon:");
  atoi = read_atoi();
  if ( atoi <= 8 && weapon_list[atoi] )
  {
    while ( (int)(atoi - 1) > v1 )
    {
      ++*(_QWORD *)weapon_list[atoi];
      ++v1;
    }
  }
  snprintf(
    s,
    0x100uLL,
    "weapons'name: %s\nattack_times: %lu\nattack_numbers: %lu",
    (const char *)(weapon_list[atoi] + 16LL),
    *(_QWORD *)weapon_list[atoi],
    *(_QWORD *)(weapon_list[atoi] + 8LL));
  puts_flush(s);
  return __readfsqword(0x28u) ^ v4;
}
