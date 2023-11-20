int addMoney()
{
  unsigned int Num;

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !*((_QWORD *)&chunkList + 2 * (int)Num) )
    return puts(":(");
  ++*(_QWORD *)(*((_QWORD *)&chunkList + 2 * (int)Num) + 8LL);
  return puts(":)");
}
