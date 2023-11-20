__int64 visit()
{
  unsigned int i;

  if ( count )
  {
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( list[i] && list[i]->used )
      {
        printf("Name[%u] :%s\n", i, list[i]->name);
        printf("Type[%u] :%s\n", i, list[i]->type);
      }
    }
  }
  else
  {
    puts("No pig in the garden !");
  }
  return 0LL;
}