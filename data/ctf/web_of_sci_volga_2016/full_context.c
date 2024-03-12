struct Paper
{
  char name[256];
  char author[256];
  char abstract[512];
  char tags[64];
};

int count;
Paper paper[25];

void add_paper()
{
  int v0;
  char nptr[8];
  __int64 v2;
  __int64 v3;
  __int64 v4;
  Paper a1;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  v3 = 0LL;
  v4 = 0LL;
  memset(&a1, 0, sizeof(a1));
  if ( count <= 24 )
  {
    while ( 2 )
    {
      puts("Add paper menu");
      puts("[1]. Add name");
      puts("[2]. Add authors");
      puts("[3]. Add abstract");
      puts("[4]. Add tags");
      puts("[5]. View paper info");
      puts("[6]. Quit");
      puts("[7]. Quit without saving\n");
      printf("> ");
      gets(nptr);
      v0 = atoi(nptr);
      puts("\n");
      switch ( v0 )
      {
        case 1:
          printf("Paper name: ");
          gets(&a1);
          puts("\n");
          continue;
        case 2:
          printf("Paper authors: ");
          gets(a1.author);
          puts("\n");
          continue;
        case 3:
          printf("Paper abstract: ");
          gets(a1.abstract);
          puts("\n");
          continue;
        case 4:
          printf("Paper tags: ");
          gets(a1.tags);
          puts("\n");
          continue;
        case 5:
          view_paper_info(&a1);
          continue;
        case 6:
          qmemcpy(&paper[count++], &a1, sizeof(Paper));
          break;
        case 7:
          return;
        default:
          continue;
      }
      break;
    }
  }
  else
  {
    puts("Too many papers are already indexed");
  }
}

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

void list_paper()
{
  int i;

  puts("List of indexed papers:");
  for ( i = 0; i < count; ++i )
    printf("[%d] %s \"%s\"\n", (unsigned int)i, &paper[1088 * i + 256], &paper[1088 * i]);
  puts("\n");
}

void __fastcall view_paper_info(Paper *a1)
{
  printf("Paper name:\n\t\"%s\"\nAuthors:\n\t%s\n", a1->name, a1->author);
  printf("Abstract:\n\t");
  if ( a1->abstract[0] )
    printf(a1->abstract);
  else
    printf("N/A");
  printf("\nTags:\n\t");
  if ( a1->tags[0] )
    printf(a1->tags);
  else
    printf("N/A");
  puts("\n\n");
}

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