__int64 Edit()
{
  unsigned int v1;
  __int64 v2;
  void *v3;

  printf("Index:");
  v1 = read_int();
  if ( v1 >= 0xA )
  {
    puts("You want to steal the flag?");
    exit(0);
  }
  if ( flist[v1] )
  {
    v2 = flist[v1];
    if ( *(_DWORD *)(v2 + 12) )
    {
      --*(_DWORD *)(v2 + 12);
      v3 = realloc(*(void **)v2, *(int *)(v2 + 8));
      if ( v3 )
      {
        *(_QWORD *)v2 = v3;
        printf("New content:");
        secure_read(*(void **)v2, *(_DWORD *)(v2 + 8));
        puts("OK!");
      }
      else
      {
        puts("Can not edit this flag!");
      }
      return 0LL;
    }
    else
    {
      puts("Dead!");
      return 0LL;
    }
  }
  else
  {
    puts("None flag!");
    return 0LL;
  }
}
