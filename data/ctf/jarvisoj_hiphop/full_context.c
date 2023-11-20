__int64 level_hp_mapping[8] = { 100LL, 1000LL, 3000LL, 9223372036854775806LL, 0LL, 0LL, 0LL, 0LL };
char aAttack[9][32] =
{
  "fireball",
  "iceball",
  "magicball",
  "lightning",
  "hellfire",
  "icesword",
  "magicsword",
  "hollylight"
};
char s2[] = "fireball";
char aIceball[] = "iceball";
char aMagicball[] = "magicball";
char aLightning[] = "lightning";
char aHellfire[] = "hellfire";
char aIcesword[] = "icesword";
char aMagicsword[] = "magicsword";
char aHollylight[] = "hollylight";
char byte_603380;

struct Data
{
  __int64 hp;
  int d;
  char iceshield;
  char fireshield;
  char windshield;
  char j;
  BossInfo boss;
  Skill skill;
  char m;
};

struct Skill
{
  char skill[32];
  char b[8];
  __int64 damage;
};

struct BossInfo
{
  __int64 level;
  __int64 hp;
};

Data data;
char byte_6033F0;

__int64 level_hp_mapping[8] = { 100LL, 1000LL, 3000LL, 9223372036854775806LL, 0LL, 0LL, 0LL, 0LL };
char aAttack[9][32] =
{
  "fireball",
  "iceball",
  "magicball",
  "lightning",
  "hellfire",
  "icesword",
  "magicsword",
  "hollylight"
};
char s2[] = "fireball";
char aIceball[] = "iceball";
char aMagicball[] = "magicball";
char aLightning[] = "lightning";
char aHellfire[] = "hellfire";
char aIcesword[] = "icesword";
char aMagicsword[] = "magicsword";
char aHollylight[] = "hollylight";
char byte_603380;

struct Data
{
  __int64 hp;
  int d;
  char iceshield;
  char fireshield;
  char windshield;
  char j;
  BossInfo boss;
  Skill skill;
  char m;
};

struct Skill
{
  char skill[32];
  char b[8];
  __int64 damage;
};

struct BossInfo
{
  __int64 level;
  __int64 hp;
};

Data data;
char byte_6033F0;


void __fastcall set_50(_QWORD *a1)
{
  *a1 = 50LL;
}

void __fastcall set_fireball_damage(_QWORD *a1)
{
  *a1 = ((rand() % 1000) << 16) % 100;
}

void __fastcall set_iceball_damage(_QWORD *a1)
{
  int v1;

  v1 = (unsigned __int16)rand();
  *a1 = v1 - 1000 * ((int)((unsigned __int64)(0x10624DD3LL * v1) >> 32) >> 6);
}

_QWORD *__fastcall set_magicball_damage(_QWORD *a1)
{
  int v1;
  _QWORD *result;
  int v3;

  v3 = rand() % 1000;
  v1 = (v3 << (rand() % 5)) % 100;
  result = a1;
  *a1 = v1;
  return result;
}

void __fastcall set_lightning_damage(_QWORD *a1)
{
  switch ( rand() % 5 )
  {
    case 0:
      *a1 = 1LL;
      goto LABEL_3;
    case 1:
LABEL_3:
      *a1 = 10LL;
      goto LABEL_4;
    case 2:
LABEL_4:
      *a1 = 20LL;
      goto LABEL_5;
    case 3:
LABEL_5:
      *a1 = 100LL;
      goto LABEL_6;
    case 4:
LABEL_6:
      *a1 = 200LL;
      break;
    default:
      return;
  }
}

void __fastcall set_hellfire_damage(__int64 *a1)
{
  *a1 = ((__int64)(rand() % 100000) << 16) % 1610612736;
}

void __fastcall set_icesword_damage(_QWORD *a1)
{
  rand();
  rand();
  rand();
  *a1 = 0xFFFFFFFFLL;
}

void __fastcall set_magicsword_damage(__int64 *a1)
{
  __int64 v1;

  v1 = rand() % 100000;
  *a1 = (v1 << (rand() % 5)) % 0xFFFFFFFFFLL;
}

void __fastcall set_hollylight_damage(_QWORD *a1)
{
  switch ( rand() % 5 )
  {
    case 0:
      *a1 = 10LL;
      goto LABEL_3;
    case 1:
LABEL_3:
      *a1 = 0xFFFFLL;
      goto LABEL_4;
    case 2:
LABEL_4:
      *a1 = 0xFFFFFFFLL;
      goto LABEL_5;
    case 3:
LABEL_5:
      *a1 = 0xFFFFFFFFLL;
      goto LABEL_6;
    case 4:
LABEL_6:
      *a1 = 0xFFFFFFFFFLL;
      break;
    default:
      return;
  }
}

void __fastcall set_default_damage(Data2 *a1)
{
  int i;

  strcpy(a1->skill, "attack");
  set_50(&a1->damage);
  a1->b[0] = 0;
  for ( i = 1; i <= 7; ++i )
    a1->b[i] = 0;
}

void __fastcall choose_skill(char *a1, int a2)
{
  strcpy(a1, aAttack[a2]);
}

void __fastcall update_damage(Data2 *a1)
{
  if ( !strcmp(a1->skill, s2) )
  {
    set_fireball_damage(&a1->damage);
    sleep(1u);
  }
  else if ( !strcmp(a1->skill, aIceball) )
  {
    sleep(0);
    set_iceball_damage(&a1->damage);
  }
  else if ( !strcmp(a1->skill, aMagicball) )
  {
    sleep(0);
    set_magicball_damage(&a1->damage);
  }
  else if ( !strcmp(a1->skill, aLightning) )
  {
    set_lightning_damage(&a1->damage);
    sleep(0);
  }
  else if ( !strcmp(a1->skill, aHellfire) )
  {
    set_hellfire_damage(&a1->damage);
    sleep(0);
  }
  else if ( !strcmp(a1->skill, aIcesword) )
  {
    set_icesword_damage(&a1->damage);
    sleep(1u);
  }
  else if ( !strcmp(a1->skill, aMagicsword) )
  {
    set_magicsword_damage(&a1->damage);
    sleep(0);
  }
  else if ( !strcmp(a1->skill, aHollylight) )
  {
    set_hollylight_damage(&a1->damage);
    sleep(0);
  }
  else
  {
    set_default_damage(a1);
  }
}

void __fastcall check_hp(Data *a1)
{
  printf("Your HP is %d\n", a1->hp);
  if ( a1->hp <= 0 )
  {
    printf("game over");
    exit(-1);
  }
}

void __fastcall clear_weapon(Data *a1)
{
  a1->fireshield = 0;
  a1->iceshield = 0;
  a1->windshield = 0;
}

void __fastcall set_boss_info(BossInfo *a1, int a2)
{
  a1->level = a2;
  a1->hp = level_hp_mapping[a1->level];
}

__int64 ret_250_2()
{
  return 250LL;
}

__int64 ret_250()
{
  return 250LL;
}

__int64 ret_250_()
{
  return 250LL;
}

void skill_menu()
{
  puts("select skill");
  puts("1. attack");
  puts("2. fireball");
  puts("3. iceball");
  puts("4. magicball");
  puts("5. lightning");
  puts("6. hellfire");
  puts("7. icesword");
  puts("8. magicsword");
  puts("9. hollylight");
}

void menu_()
{
  puts("select shield");
  puts("1. iceshield");
  puts("2. fireshield");
  puts("3. windshield");
}

void how_to_play()
{
  puts("You have to kill the boss monster. You can use several skills, and you must stop the attack of boss.  Have fun! ");
}

void menu()
{
  std::cout << "1. How to play" << std::endl;
  std::cout << "2. Use skill " << std::endl;
  std::cout << "3. Change skill" << std::endl;
  std::cout << "4. Remove skill" << std::endl;
  std::cout << "5. Recieve suggestion" << std::endl;
  std::cout << "6. Exit" << std::endl;
}

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

void __fastcall remove_skill(Data *a1)
{
  choose_skill(a1->skill.skill, 0);
}

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

void __fastcall sub_4018D4(Data *a1)
{
  __gid_t rgid;

  puts("Congraturation! You win!");
  a1->m = 1;
  rgid = getegid();
  setregid(rgid, rgid);
  system("/bin/cat /home/hunting/flag");
}

void sub_401942()
{
  char v0[104];
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("content:");
  scanf("%s", v0);
  puts("ok, thanks.");
}

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

void __fastcall use_skill()
{
  use_skill_impl(&data);
}

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  unsigned int v3;
  int v5;
  int v6;
  pthread_t newthread;
  char v8[104];
  unsigned __int64 v9;

  v9 = __readfsqword(0x28u);
  v3 = time(0LL);
  srand(v3);
  v6 = 0;
  while ( 2 )
  {
    if ( v6 > 249 )
    {
      puts("Game Over");
      return 0LL;
    }
    else
    {
      if ( !byte_6033F0 )
      {
        menu();
        printf("choice:");
        scanf("%d", &v5);
        switch ( v5 )
        {
          case 1:
            how_to_play();
            goto LABEL_12;
          case 2:
            pthread_create(&newthread, 0LL, (void *(*)(void *))use_skill, 0LL);
            goto LABEL_12;
          case 3:
            change_skill(&data);
            goto LABEL_12;
          case 4:
            remove_skill(&data);
            goto LABEL_12;
          case 5:
            sub_401942();
LABEL_12:
            if ( v5 == 2 )
            {
              sub_4019A4(&data);
              sleep(0);
            }
            ++v6;
            continue;
          default:
            return 0LL;
        }
      }
      puts("What's your name?");
      scanf("%s", v8);
      return 0LL;
    }
  }
}
