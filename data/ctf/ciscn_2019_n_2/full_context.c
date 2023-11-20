

ssize_t __fastcall myRead(void *a1, int a2)
{
  return read(0, a1, a2);
}

void __noreturn handler()
{
  puts("Timeout");
  exit(1);
}

unsigned int initIO()
{
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  signal(14, (__sighandler_t)handler);
  return alarm(0x3Cu);
}

int dispMenu()
{
  puts("$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  puts("$       Baby Tcache       $");
  puts("$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  puts("$   1. Create user        $");
  puts("$   2. Delete user        $ ");
  puts("$   3. Edit user          $ ");
  puts("$   4. Display user       $ ");
  puts("$   5. Add money          $ ");
  puts("$   6. Buy gift           $ ");
  puts("$   7. Exit               $ ");
  puts("$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  return printf("Your choice: ");
}

__int64 readNum()
{
  char nptr[24]; // [rsp+0h] [rbp-20h] BYREF
  unsigned __int64 v2; // [rsp+18h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  myRead(nptr, 16LL);
  return atoll(nptr);
}

int createUser()
{
  Info *info; // rbx
  unsigned int v2; // [rsp+8h] [rbp-18h]
  int i; // [rsp+Ch] [rbp-14h]

  for ( i = 0; i <= 2; ++i )
  {
    if ( !chunkList[i].used )
    {
      v2 = i;
      break;
    }
    if ( i == 2 )
      return puts(":(");
  }
  chunkList[v2].info = (Info *)malloc(0x18uLL);
  printf("name:");
  myRead(chunkList[v2].info, 8LL);
  printf("age:");
  info = chunkList[v2].info;
  info->age = readNum();
  chunkList[v2].info->momey = 0LL;
  chunkList[v2].used = 1;
  return printf("idx: %d\n", v2);
}

int editUser()
{
  Info *info; // rbx
  unsigned int Num; // [rsp+Ch] [rbp-14h]

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !chunkList[Num].info || !chunkList[Num].used )
    return puts(":(");
  printf("name:");
  myRead(chunkList[Num].info, 8LL);
  printf("age:");
  info = chunkList[Num].info;
  info->age = readNum();
  return puts(":)");
}

int deleteUser()
{
  unsigned int Num; // [rsp+Ch] [rbp-4h]

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !chunkList[Num].info )
    return puts(":(");
  free(chunkList[Num].info);
  chunkList[Num].used = 0;
  return puts(":)");
}

int addMoney()
{
  unsigned int Num; // [rsp+Ch] [rbp-4h]

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !chunkList[Num].info )
    return puts(":(");
  ++chunkList[Num].info->momey;
  return puts(":)");
}

int buyGift()
{
  int v1; // [rsp+0h] [rbp-10h] BYREF
  unsigned int Num; // [rsp+4h] [rbp-Ch]
  void *buf; // [rsp+8h] [rbp-8h] BYREF

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !chunkList[Num].info || chunkList[Num].info->momey <= 0x100000 )
    return puts(":(");
  printf("input the address you want to leak:");
  _isoc99_scanf("%p", &buf);
  printf("input the size you want to leak:");
  _isoc99_scanf("%d", &v1);
  printf("data:[[[");
  write(1, buf, v1);
  puts("]]]\n");
  return puts(":)");
}

int printUser()
{
  unsigned int Num; // [rsp+Ch] [rbp-4h]

  printf("Index:");
  Num = readNum();
  if ( Num >= 4 )
    exit(1);
  if ( !chunkList[Num].info || !chunkList[Num].used )
    return puts(":(");
  puts("------------------------");
  printf("name: ");
  puts(chunkList[Num].info->name);
  printf("age: %lld\nmoney: %lld\n", chunkList[Num].info->age, chunkList[Num].info->momey);
  puts("------------------------");
  return puts(":)");
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  __int64 Num; // [rsp+8h] [rbp-8h]

  initIO(argc, argv, envp);
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          while ( 1 )
          {
            while ( 1 )
            {
              while ( 1 )
              {
                dispMenu();
                Num = readNum();
                if ( Num != 1 )
                  break;
                createUser();
              }
              if ( Num != 2 )
                break;
              deleteUser();
            }
            if ( Num != 3 )
              break;
            editUser();
          }
          if ( Num != 4 )
            break;
          printUser();
        }
        if ( Num != 5 )
          break;
        addMoney();
      }
      if ( Num != 6 )
        break;
      buyGift();
    }
    if ( Num == 7 )
      break;
    puts("Invalid Choice");
  }
  return 0;
}
