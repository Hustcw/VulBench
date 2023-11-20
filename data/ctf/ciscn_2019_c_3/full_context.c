struct Weapon
{
  __int64 attack_times;
  __int64 attack_numbers;
  char name[8];
};

Weapon *weapon_list[9];
struct Weapon
{
  __int64 attack_times;
  __int64 attack_numbers;
  char name[8];
};

Weapon *weapon_list[9];

void __fastcall read_str(char *a1, unsigned int a2)
{
  unsigned int v2;

  v2 = 0;
  do
  {
    if ( read(0, &a1[v2], 1uLL) == -1 )
      exit(0);
    if ( a1[v2] == 10 )
    {
      a1[v2] = 0;
      return;
    }
    ++v2;
  }
  while ( v2 < a2 );
  a1[v2 - 1] = 0;
}

int __fastcall puts_flush(const char *a1)
{
  puts(a1);
  return fflush(stdout);
}

__int64 menu()
{
  puts_flush("Welcome to my bar!!");
  putchar(10);
  puts_flush("Be careful that a group of drunks are coming to you.");
  putchar(10);
  printf("——You can choose a weapon to fight them.——");
  putchar(10);
  puts_flush("1: Create a weapon");
  puts_flush("2: Show me weapon");
  puts_flush("3: Fight!!Fight!!Fight!!");
  puts_flush("5: You are a loser!!byebye!!");
  return puts_flush("Command: ");
}

int read_atoi()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, sizeof(s));
  read(0, s, 8uLL);
  return atoi(s);
}

void create()
{
  int i;
  unsigned int atoi;
  Weapon *v2;

  for ( i = 0; i <= 8; ++i )
  {
    if ( !weapon_list[i] )
    {
      puts_flush("size: ");
      atoi = read_atoi();
      if ( atoi == 96 || atoi == 256 || atoi == 79 )
      {
        v2 = (Weapon *)malloc((int)atoi);
        v2->attack_times = 0LL;
        v2->attack_numbers = time(0LL) % 10 + 96;
        puts_flush("Give me the name: ");
        read_str(v2->name, atoi);
        weapon_list[i] = v2;
      }
      else
      {
        puts_flush("you can only create three kinds of weapons");
      }
      return;
    }
  }
}

void show()
{
  unsigned int atoi;
  char s[1000];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts_flush("index: ");
  atoi = read_atoi();
  if ( atoi <= 8 )
  {
    if ( weapon_list[atoi] )
    {
      snprintf(
        s,
        0x100uLL,
        "weapons'name: %s\nattack_times: %lu\nattack_numbers: %lu",
        weapon_list[atoi]->name,
        weapon_list[atoi]->attack_times,
        weapon_list[atoi]->attack_numbers);
      puts_flush(s);
    }
  }
}

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

void dele()
{
  unsigned int atoi;

  puts_flush("weapon:");
  atoi = read_atoi();
  if ( atoi <= 8 )
  {
    if ( weapon_list[atoi] )
      free(weapon_list[atoi]);
  }
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int atoi;

  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu(argc, argv);
        atoi = read_atoi();
        if ( atoi != 3 )
          break;
        dele();
      }
      if ( atoi > 3 )
        break;
      if ( atoi == 1 )
      {
        create();
      }
      else
      {
        if ( atoi != 2 )
          goto LABEL_15;
        show();
      }
    }
    if ( atoi == 5 )
    {
      puts_flush("bye,bye!!");
      exit(0);
    }
    if ( atoi != 666 )
LABEL_15:
      exit(0);
    backdoor();
  }
}
