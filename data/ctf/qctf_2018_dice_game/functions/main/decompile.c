__int64 __fastcall main(int a1, char **a2, char **a3)
{
  char buf[55];
  char v5;
  ssize_t v6;
  unsigned int seed[2];
  unsigned int v8;

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
