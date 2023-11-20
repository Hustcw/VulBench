void clean()
{
  unsigned int i;

  for ( i = 0; i <= 0x63; ++i )
  {
    if ( flowerlist[i] && !flowerlist[i]->used )
    {
      free(flowerlist[i]);
      flowerlist[i] = 0LL;
      --flowercount;
    }
  }
  puts("Done!");
}