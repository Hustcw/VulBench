int deleteUser()
{
  unsigned int Num;

  printf("Index:");
  Num = readNum();
  if ( Num >= 3 )
    exit(1);
  if ( !*((_QWORD *)&chunkList + 2 * (int)Num) )
    return puts(":(");
  free(*((void **)&chunkList + 2 * (int)Num));
  dword_602068[4 * Num] = 0;
  return puts(":)");
}
