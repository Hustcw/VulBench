
__int64 __fastcall main(int a1, char **a2, char **a3)
{
  char buf[55]; // [rsp+0h] [rbp-50h] BYREF
  char v5; // [rsp+37h] [rbp-19h]
  ssize_t v6; // [rsp+38h] [rbp-18h]
  unsigned int seed[2]; // [rsp+40h] [rbp-10h]
  unsigned int v8; // [rsp+4Ch] [rbp-4h]

  memset(buf, 0, 0x30uLL);
  *(_QWORD *)seed = time(0LL);
  printf("Welcome, let me know your name: ");
  fflush(stdout);
  v6 = read(0, buf, 0x50uLL);
  if ( v6 <= 49 )
    buf[v6 - 1] = 0;
  printf("Hi, %s. Let's play a game.\n", buf);
  fflush(stdout);
  srand(seed[0]);
  v8 = 1;
  v5 = 0;
  while ( 1 )
  {
    printf("Game %d/50\n", v8);
    v5 = sub_A20();
    fflush(stdout);
    if ( v5 != 1 )
      break;
    if ( v5 )
    {
      if ( v8 == 50 )
      {
        sub_B28(buf);
        break;
      }
      ++v8;
    }
  }
  puts("Bye bye!");
  return 0LL;
}

__int64 sub_A20()
{
  __int16 v1; // [rsp+Ch] [rbp-4h] BYREF
  __int16 v2; // [rsp+Eh] [rbp-2h]

  printf("Give me the point(1~6): ");
  fflush(stdout);
  _isoc99_scanf("%hd", &v1);
  if ( v1 > 0 && v1 <= 6 )
  {
    v2 = rand() % 6 + 1;
    if ( v1 <= 0 || v1 > 6 || v2 <= 0 || v2 > 6 )
      _assert_fail("(point>=1 && point<=6) && (sPoint>=1 && sPoint<=6)", "dice_game.c", 0x18u, "dice_game");
    if ( v1 == v2 )
    {
      puts("You win.");
      return 1LL;
    }
    else
    {
      puts("You lost.");
      return 0LL;
    }
  }
  else
  {
    puts("Invalid value!");
    return 0LL;
  }
}

int __fastcall sub_B28(const char *a1)
{
  char s[104]; // [rsp+10h] [rbp-70h] BYREF
  FILE *stream; // [rsp+78h] [rbp-8h]

  printf("Congrats %s\n", a1);
  stream = fopen("flag", "r");
  fgets(s, 100, stream);
  puts(s);
  return fflush(stdout);
}