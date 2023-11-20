__int64 eat()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( count )
  {
    printf("Which pig do you want to eat:");
    _isoc99_scanf("%d", &v1);
    if ( v1 > 0x63 || !list[v1] )
    {
      puts("Invalid choice");
      return 0LL;
    }
    srand(0);
    list[v1]->used = 0;
    free(list[v1]->name);
  }
  else
  {
    puts("No pig");
  }
  return 0LL;
}