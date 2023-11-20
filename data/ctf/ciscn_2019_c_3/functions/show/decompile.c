unsigned __int64 show()
{
  unsigned int atoi;
  char s[1000];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts_flush("index: ");
  atoi = read_atoi();
  if ( atoi <= 8 && weapon_list[atoi] )
  {
    snprintf(
      s,
      0x100uLL,
      "weapons'name: %s\nattack_times: %lu\nattack_numbers: %lu",
      (const char *)(weapon_list[atoi] + 16LL),
      *(_QWORD *)weapon_list[atoi],
      *(_QWORD *)(weapon_list[atoi] + 8LL));
    puts_flush(s);
  }
  return __readfsqword(0x28u) ^ v3;
}
