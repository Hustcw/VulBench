int play()
{
  char s[208]; // [esp+8h] [ebp-D0h] BYREF

  memset(s, 0, 0xC8u);
  puts("Huh...maby you have a change to get my flag.");
  puts("If you can solve my puzzle :p");
  puts("Help this cat found his anchovies:");
  read(0, s, 400u);
  puts("Where are the anchovies?");
  return 0;
}