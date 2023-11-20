__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v0;
  int a1a;
  int a1;
  char nptr[8];
  __int64 v4;
  __int64 v5;
  __int64 v6;
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v4 = 0LL;
  v5 = 0LL;
  v6 = 0LL;
  while ( 1 )
  {
    puts("Choose command to perform");
    puts("[1]. Add paper");
    puts("[2]. Delete paper");
    puts("[3]. List papers");
    puts("[4]. View paper info");
    puts("[5]. Exit\n");
    printf("> ");
    gets(nptr);
    v0 = atoi(nptr);
    puts("\n");
    switch ( v0 )
    {
      case 1:
        add_paper();
        break;
      case 2:
        printf("Enter index of paper to delete: ");
        gets(nptr);
        a1a = atoi(nptr);
        delete_paper(a1a);
        break;
      case 3:
        list_paper();
        break;
      case 4:
        printf("Enter index of paper to view: ");
        gets(nptr);
        a1 = atoi(nptr);
        if ( a1 >= 0 && a1 < count )
          view_paper_info(&paper[a1]);
        else
          printf("Wrong paper index %d\n\n\n", (unsigned int)a1);
        break;
      case 5:
        return;
      default:
        continue;
    }
  }
}