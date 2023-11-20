__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v3;
  int v4;
  int v5;
  int v6;
  int v7;
  int v8;
  void *v10;
  const char *s1;
  unsigned int st_size;
  char *v13;
  int size;
  char *v15;
  char *v16;
  char *v17;
  struct stat v18;
  struct stat stat_buf;
  char s[4096];
  char filename[4096];
  char v22[48];
  char v23[256];
  char ptr[1032];
  unsigned __int64 v25;

  v25 = __readfsqword(0x28u);
  alarm(0x3Cu);
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  chdir("/sandbox/");
  v15 = getenv("REMOTE_HOST");
  snprintf(s, 0xFFFuLL, "%s%s/", "/sandbox/", v15);
  mkdir(s, 0x1C0u);
  snprintf(filename, 0xFFFuLL, "%s%s/pending", "/sandbox/", v15);
  stream = fopen(filename, "w+");
  v3 = fileno(stream);
  if ( flock(v3, 6) == -1 )
  {
    printf("Nope!\n");
    exit(1);
  }
LABEL_3:
  while ( dword_203128 <= 2 )
  {
    sub_12D0();
    switch ( (unsigned int)sub_11F0() )
    {
      case 1u:
        if ( qword_203130 )
          goto LABEL_3;
        if ( dword_203124 > 0 )
          goto LABEL_3;
        v4 = dword_203128++;
        if ( v4 > 1 )
          goto LABEL_3;
        printf("Enter file name: ");
        memset(v23, 0, sizeof(v23));
        sub_1050(0, (__int64)v23, 0xFFuLL);
        v5 = strlen(v23);
        v16 = sub_1380((__int64)v23, v5);
        snprintf(s, 0xFFFuLL, "%s%s/%s", "/sandbox/", v15, v16);
        printf("Writing: %s\n", s);
        qword_203130 = fopen(s, "w+");
        if ( !qword_203130 )
        {
          puts("Can't open file");
          goto LABEL_31;
        }
        dword_203124 = 1;
        break;
      case 2u:
        if ( qword_203130 )
          goto LABEL_3;
        if ( dword_203124 > 0 )
          goto LABEL_3;
        v6 = dword_203128++;
        if ( v6 > 1 )
          goto LABEL_3;
        printf("Enter file name: ");
        memset(v23, 0, sizeof(v23));
        sub_1050(0, (__int64)v23, 0xFFuLL);
        v7 = strlen(v23);
        v17 = sub_1380((__int64)v23, v7);
        snprintf(s, 0xFFFuLL, "%s%s/%s", "/sandbox/", v15, v17);
        printf("Reading: %s\n", s);
        qword_203130 = fopen(s, "r");
        if ( !qword_203130 )
        {
          puts("No such file");
          goto LABEL_31;
        }
        dword_203124 = 2;
        goto LABEL_3;
      case 3u:
        if ( dword_203124 == 1 )
        {
          printf("Size data");
          size = sub_11F0();
          if ( size > 1024 )
            size = 1024;
          printf("Data> ");
          memset(ptr, 0, 0x400uLL);
          sub_1050(0, (__int64)ptr, (unsigned int)size);
          fseek(qword_203130, 0LL, 0);
          fwrite(ptr, (unsigned int)size, 1uLL, qword_203130);
          printf("Key> ");
          memset(v22, 0, 0x21uLL);
          sub_1050(0, (__int64)v22, 0x10uLL);
          v13 = sub_1380((__int64)v22, 16);
          fwrite(v13, 1uLL, 0x20uLL, qword_203130);
          fclose(qword_203130);
          qword_203130 = 0LL;
          dword_203124 = 0;
          sub_1EF0(s, &stat_buf);
          printf("%d written bytes\n", LODWORD(stat_buf.st_size));
        }
        if ( dword_203124 == 2 )
        {
          sub_1EF0(s, &v18);
          st_size = v18.st_size;
          fseek(qword_203130, LODWORD(v18.st_size) - 32, 0);
          memset(ptr, 0, 0x400uLL);
          fread(ptr, 1uLL, 0x20uLL, qword_203130);
          printf("Enter key> ");
          memset(v22, 0, 0x21uLL);
          sub_1050(0, (__int64)v22, 0x10uLL);
          s1 = sub_1380((__int64)v22, 16);
          if ( !strncmp(s1, ptr, 0x20uLL) )
          {
            fseek(qword_203130, 0LL, 0);
            v10 = malloc((int)(st_size + 1));
            fread(v10, 1uLL, st_size, qword_203130);
            printf("Your data (size: %d):\n", st_size);
            sub_1150(1, (__int64)v10, st_size);
          }
          else
          {
            puts("Wrong key");
          }
          fclose(qword_203130);
          printf("\n--------------\nNow your file is going be deleted.\nWe hope you are satisfied with our services :)\n");
          unlink(s);
          qword_203130 = 0LL;
          dword_203124 = 0;
        }
        goto LABEL_3;
      case 4u:
        goto LABEL_31;
      default:
        goto LABEL_3;
    }
  }
  printf("This is DEMO version\nPlease purchase a full version\n");
LABEL_31:
  printf("\nBye!\n");
  v8 = fileno(stream);
  flock(v8, 8);
  fclose(stream);
  return 0LL;
}
