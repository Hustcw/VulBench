void __fastcall use_skill_impl(Data *a1)
{
  int i;

  puts("\n========================================Skill Activation");
  printf("\rYou use %s\n", a1->skill.skill);
  for ( i = 0; i <= 8 && strcmp(a1->skill.skill, aAttack[i]); ++i )
    ;
  update_damage(&a1->skill);
  if ( !byte_603380 )
  {
    byte_603380 = 1;
    if ( i <= 4 )
    {
      if ( a1->skill.damage >= 0 )
      {
        a1->boss.hp -= (int)a1->skill.damage;
        printf("Boss's hp is %ld\n", a1->boss.hp);
        goto LABEL_14;
      }
    }
    else if ( a1->skill.damage >= 0 )
    {
      a1->boss.hp -= a1->skill.damage;
      printf("Boss's hp is %ld\n", a1->boss.hp);
LABEL_14:
      upgrade_boss(&data);
      byte_603380 = 0;
      goto LABEL_15;
    }
    puts("Damage can't be negative number!");
    goto LABEL_14;
  }
  printf("You are already using the skill. Skill failed to use:%s\n", a1->skill.skill);
LABEL_15:
  a1->skill.damage = 0LL;
  puts("\n=======================================");
}