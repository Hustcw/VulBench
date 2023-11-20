int buyGift()
{
  int v1;
  unsigned int Num;
  void *buf;

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !*((_QWORD *)&chunkList + 2 * (int)Num) || *(__int64 *)(*((_QWORD *)&chunkList + 2 * (int)Num) + 8LL) <= 0x100000 )
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
