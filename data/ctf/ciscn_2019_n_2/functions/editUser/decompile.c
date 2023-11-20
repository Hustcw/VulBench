int editUser()
{
  __int64 v0;
  unsigned int Num;

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !*((_QWORD *)&chunkList + 2 * (int)Num) || !dword_602068[4 * Num] )
    return puts(":(");
  printf("name:");
  myRead(*((void **)&chunkList + 2 * (int)Num), 8);
  printf("age:");
  v0 = *((_QWORD *)&chunkList + 2 * (int)Num);
  *(_QWORD *)(v0 + 16) = readNum();
  return puts(":)");
}
