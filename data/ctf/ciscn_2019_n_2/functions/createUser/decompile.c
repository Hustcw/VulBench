int createUser()
{
  __int64 v1;
  unsigned int v2;
  int i;

  for ( i = 0; i <= 2; ++i )
  {
    if ( !dword_602068[4 * i] )
    {
      v2 = i;
      break;
    }
    if ( i == 2 )
      return puts(":(");
  }
  *((_QWORD *)&chunkList + 2 * (int)v2) = malloc(0x18uLL);
  printf("name:");
  myRead(*((void **)&chunkList + 2 * (int)v2), 8);
  printf("age:");
  v1 = *((_QWORD *)&chunkList + 2 * (int)v2);
  *(_QWORD *)(v1 + 16) = readNum();
  *(_QWORD *)(*((_QWORD *)&chunkList + 2 * (int)v2) + 8LL) = 0LL;
  dword_602068[4 * v2] = 1;
  return printf("idx: %d\n", v2);
}
