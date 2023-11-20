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