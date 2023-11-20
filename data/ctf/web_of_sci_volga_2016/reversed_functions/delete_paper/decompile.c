void __fastcall delete_paper(int a1)
{
  int i;

  if ( a1 >= 0 && a1 < count )
  {
    for ( i = a1; count - 1 > i; ++i )
      qmemcpy(&paper[i], &paper[i + 1], sizeof(Paper));
    --count;
    puts("\n");
  }
  else
  {
    printf("Wrong paper index %d\n\n\n", (unsigned int)a1);
  }
}