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