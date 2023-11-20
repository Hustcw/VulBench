void del()
{
  unsigned int v0;

  if ( flowercount )
  {
    printf("Which flower do you want to remove from the garden:");
    __isoc99_scanf("%d", &v0);
    if ( v0 <= 0x63 && flowerlist[v0] )
    {
      flowerlist[v0]->used = 0;
      free(flowerlist[v0]->name);
      puts("Successful");
    }
    else
    {
      puts("Invalid choice");
    }
  }
  else
  {
    puts("No flower in the garden");
  }
}