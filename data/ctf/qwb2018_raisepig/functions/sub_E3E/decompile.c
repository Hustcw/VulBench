__int64 sub_E3E()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( dword_20202C )
  {
    printf("Which pig do you want to eat:");
    _isoc99_scanf("%d", &v1);
    if ( v1 > 0x63 || !qword_202040[v1] )
    {
      puts("Invalid choice");
      return 0LL;
    }
    srand(0);
    *(_DWORD *)qword_202040[v1] = 0;
    free(*(void **)(qword_202040[v1] + 8LL));
  }
  else
  {
    puts("No pig");
  }
  return 0LL;
}
