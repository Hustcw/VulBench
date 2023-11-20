int del()
{
  unsigned int v1;

  if ( !flowercount )
    return puts("No flower in the garden");
  printf("Which flower do you want to remove from the garden:");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0x63 && flowerlist[v1] )
  {
    *(_DWORD *)flowerlist[v1] = 0;
    free(*(void **)(flowerlist[v1] + 8LL));
    return puts("Successful");
  }
  else
  {
    puts("Invalid choice");
    return 0;
  }
}
