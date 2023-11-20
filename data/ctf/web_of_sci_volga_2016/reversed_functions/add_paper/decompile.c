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