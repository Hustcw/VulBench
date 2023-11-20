unsigned __int64 sub_4009AB()
{
  int v1;
  char nptr[8];
  __int64 v3;
  __int64 v4;
  __int64 v5;
  char v6[1096];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v3 = 0LL;
  v4 = 0LL;
  v5 = 0LL;
  memset(v6, 0, 0x440uLL);
  if ( dword_60208C <= 24 )
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
      v1 = atoi(nptr);
      puts("\n");
      switch ( v1 )
      {
        case 1:
          printf("Paper name: ");
          gets(v6);
          puts("\n");
          continue;
        case 2:
          printf("Paper authors: ");
          gets(&v6[256]);
          puts("\n");
          continue;
        case 3:
          printf("Paper abstract: ");
          gets(&v6[512]);
          puts("\n");
          continue;
        case 4:
          printf("Paper tags: ");
          gets(&v6[1024]);
          puts("\n");
          continue;
        case 5:
          sub_400D52(v6, v6);
          continue;
        case 6:
          qmemcpy((void *)(1088LL * dword_60208C++ + 6299808), v6, 0x440uLL);
          break;
        case 7:
          return __readfsqword(0x28u) ^ v7;
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
  return __readfsqword(0x28u) ^ v7;
}
