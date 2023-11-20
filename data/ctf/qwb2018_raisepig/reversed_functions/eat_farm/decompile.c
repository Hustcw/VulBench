void eat_farm()
{
  unsigned int i;

  for ( i = 0; i <= 0x63; ++i )
  {
    if ( list[i] && !list[i]->used )
    {
      free(list[i]);
      list[i] = 0LL;
      --count;
    }
  }
  puts("Done!");
}