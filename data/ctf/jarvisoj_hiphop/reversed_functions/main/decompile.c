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