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