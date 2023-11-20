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