int printUser()
{
  unsigned int Num;

  printf("Index:");
  Num = readNum();
  if ( Num >= 4 )
    exit(1);
  if ( !*((_QWORD *)&chunkList + 2 * (int)Num) || !dword_602068[4 * Num] )
    return puts(":(");
  puts("------------------------");
  printf("name: ");
  puts(*((const char **)&chunkList + 2 * (int)Num));
  printf(
    "age: %lld\nmoney: %lld\n",
    *(_QWORD *)(*((_QWORD *)&chunkList + 2 * (int)Num) + 16LL),
    *(_QWORD *)(*((_QWORD *)&chunkList + 2 * (int)Num) + 8LL));
  puts("------------------------");
  return puts(":)");
}
