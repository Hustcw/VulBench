void __fastcall upgrade_boss(Data *a1)
{
  if ( a1->boss.hp <= 0 )
  {
    if ( a1->boss.level > 2 )
    {
      sub_4018D4(a1);
      exit(-1);
    }
    puts("You Win! Boss is upgrading..");
    set_boss_info(&a1->boss, a1->boss.level + 1);
    printf("level:%d\n", a1->boss.level + 1);
  }
}