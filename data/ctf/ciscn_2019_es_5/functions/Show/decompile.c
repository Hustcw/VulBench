int Show()
{
  unsigned int v1;
  __int64 v2;

  printf("Index:");
  v1 = read_int();
  if ( v1 >= 0xA )
  {
    puts("You want to steal the flag?");
    exit(0);
  }
  if ( !flist[v1] )
    return puts("None flag!");
  v2 = flist[v1];
  if ( !*(_DWORD *)(v2 + 12) )
    return puts("Dead flag!");
  printf("Flag of index %d:\n", v1);
  printf("Content: %s\nSize: %dsState: %d\n", *(const char **)v2, *(unsigned int *)(v2 + 8), *(unsigned int *)(v2 + 12));
  return puts("Done!");
}
