void visit()
{
  unsigned int i;

  if ( flowercount )
  {
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( flowerlist[i] )
      {
        if ( flowerlist[i]->used )
        {
          printf("Name of the flower[%u] :%s\n", i, flowerlist[i]->name);
          printf("Color of the flower[%u] :%s\n", i, flowerlist[i]->color);
        }
      }
    }
  }
  else
  {
    puts("No flower in the garden !");
  }
}