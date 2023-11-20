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