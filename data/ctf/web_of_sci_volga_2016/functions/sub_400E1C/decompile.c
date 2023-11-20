unsigned __int64 sub_400E1C()
{
  int v1;
  int v2;
  int v3;
  char nptr[8];
  __int64 v5;
  __int64 v6;
  __int64 v7;
  unsigned __int64 v8;

  v8 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v5 = 0LL;
  v6 = 0LL;
  v7 = 0LL;
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
    v1 = atoi(nptr);
    puts("\n");
    switch ( v1 )
    {
      case 1:
        sub_4009AB();
        break;
      case 2:
        printf("Enter index of paper to delete: ");
        gets(nptr);
        v2 = atoi(nptr);
        sub_400C0F(v2);
        break;
      case 3:
        sub_400CC6();
        break;
      case 4:
        printf("Enter index of paper to view: ");
        gets(nptr);
        v3 = atoi(nptr);
        if ( v3 >= 0 && v3 < dword_60208C )
          sub_400D52((const char *)(1088LL * v3 + 6299808));
        else
          printf("Wrong paper index %d\n\n\n", (unsigned int)v3);
        break;
      case 5:
        return __readfsqword(0x28u) ^ v8;
      default:
        continue;
    }
  }
}
