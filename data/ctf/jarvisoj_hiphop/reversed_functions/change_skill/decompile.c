void __fastcall change_skill(Data *a1)
{
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  v1 = 0;
  skill_menu();
  printf("choice:");
  scanf("%d", &v1);
  if ( v1 > 0 && v1 <= 9 )
  {
    if ( v1 <= 4 || a1->boss[0] > 2 )
    {
      choose_skill(a1->skill.skill, v1 - 1);
      printf("Change Skill: %s\n", aAttack[v1 - 1]);
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
}