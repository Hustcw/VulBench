void __fastcall sub_4019A4(Data *a1)
{
  int v1;
  __int64 v2;
  __int64 a;
  __int64 v4;
  int v5;
  int v6;
  int v7;
  unsigned __int64 v8;

  v8 = __readfsqword(0x28u);
  puts("\n========================================Boss' Attack");
  puts("Boss is Attacking you!");
  menu_();
  printf("choice:");
  scanf("%d", &v5);
  switch ( v5 )
  {
    case 2:
      a1->fireshield = 1;
      break;
    case 3:
      a1->windshield = 1;
      break;
    case 1:
      a1->iceshield = 1;
      break;
  }
  v6 = rand();
  v7 = v6 % 4;
  v1 = v6 % 4;
  if ( v6 % 4 == 1 )
  {
    if ( a1->windshield )
      goto LABEL_16;
    a = a1->hp;
    a1->hp = a - ret_250();
  }
  else
  {
    if ( v1 == 2 )
    {
      if ( !a1->fireshield )
      {
        v4 = a1->hp;
        a1->hp = v4 - ret_250_();
        goto LABEL_18;
      }
      goto LABEL_16;
    }
    if ( !v1 )
    {
      if ( a1->iceshield )
      {
LABEL_16:
        puts("You succeed in defense");
        goto LABEL_18;
      }
      v2 = a1->hp;
      a1->hp = v2 - ret_250_2();
    }
  }
LABEL_18:
  clear_weapon(a1);
  check_hp(a1);
  puts("========================================");
}