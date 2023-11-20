int Delete()
{
  unsigned int v1;
  void **ptr;

  printf("Index:");
  v1 = read_int();
  if ( v1 >= 0xA )
  {
    puts("You want to steal the flag?");
    exit(0);
  }
  if ( !flist[v1] )
    return puts("None flag!");
  ptr = (void **)flist[v1];
  free(*ptr);
  *ptr = 0LL;
  free(ptr);
  flist[v1] = 0LL;
  return puts("OK!");
}
