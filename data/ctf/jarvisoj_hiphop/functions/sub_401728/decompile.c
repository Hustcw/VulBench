unsigned __int64 __fastcall sub_401728(__int64 a1)
{
  int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  v2 = 0;
  sub_401402();
  printf("choice:");
  scanf("%d", &v2);
  if ( v2 > 0 && v2 <= 9 )
  {
    if ( v2 <= 4 || *(__int64 *)(a1 + 16) > 2 )
    {
      sub_40114A((char *)(a1 + 32), v2 - 1);
      printf("Change Skill: %s\n", (const char *)(32LL * (v2 - 1) + 6304064));
    }
    else
    {
      puts("You have not learned this skill yet");
    }
  }
  else
  {
    puts("Wrong Choice");
  }
  return __readfsqword(0x28u) ^ v3;
}
