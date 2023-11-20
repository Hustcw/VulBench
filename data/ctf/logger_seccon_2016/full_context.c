FILE *edata;
FILE *fp;

FILE *edata;
FILE *fp;

char *__fastcall calc_filename(const char *a1, const char *a2, char *a3)
{
  size_t v3;
  int i;
  char v7[96];
  char v8[16];
  char dest[128];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  memset(dest, 0, sizeof(dest));
  strcat(dest, a1);
  strcat(dest, a2);
  if ( (unsigned int)MD5_Init(v7) != 1 )
  {
    puts("Initialization error.");
    exit(1);
  }
  v3 = strlen(dest);
  if ( (unsigned int)MD5_Update(v7, dest, v3) != 1 )
  {
    puts("Update error.");
    exit(1);
  }
  if ( (unsigned int)MD5_Final(v8, v7) != 1 )
  {
    puts("Finalization error.");
    exit(1);
  }
  for ( i = 0; i <= 15; ++i )
    sprintf(&a3[2 * i], "%02x", (unsigned __int8)v8[i]);
  return a3;
}

_BOOL8 check_dir()
{
  struct stat v1;

  if ( stat("/tmp/logger", &v1) )
  {
    puts("Stat error. /tmp/logger exists?");
    exit(1);
  }
  return (v1.st_mode & 0xF000) == 0x4000;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  const char *v3;
  int i;
  int v5;
  int v6;
  size_t size;
  void *ptr;
  struct stat v9;
  char v10[32];
  char *buf;
  char dest[14];
  __int16 v13;
  __int64 v14;
  __int64 v15;
  __int64 v16;
  __int64 v17;
  char v18;
  char v19[64];
  char v20[72];
  unsigned __int64 v21;

  v21 = __readfsqword(0x28u);
  strcpy(dest, "/tmp/logger/");
  dest[13] = 0;
  v13 = 0;
  v14 = 0LL;
  v15 = 0LL;
  v16 = 0LL;
  v17 = 0LL;
  v18 = 0;
  setvbuf(edata, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  puts("Welcome to logging service.");
  puts("Log file will be removed every 5 minites.");
  puts("1. Login\n2. exit");
  __isoc99_scanf("%ld", &size);
  getchar();
  if ( size != 1 )
    exit(0);
  printf("%s", "Name    :");
  __isoc99_scanf("%63s", v19);
  printf("%s", "Password:");
  __isoc99_scanf("%63s", v20);
  v3 = calc_filename(v19, v20, v10);
  strcat(dest, v3);
  if ( !check_dir() )
  {
    puts("/tmp/logger directory not exists");
    exit(1);
  }
  fp = fopen(dest, "a+");
  if ( !fp )
  {
    puts("open error.");
    exit(1);
  }
  stat(dest, &v9);
  buf = (char *)malloc(SLODWORD(v9.st_size));
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        puts("1. Read log\n2. Append log\n3. Display info\n4. exit");
        __isoc99_scanf("%ld", &size);
        getchar();
        if ( size != 1 )
          break;
        for ( i = 0; ; ++i )
        {
          v6 = fgetc(fp);
          if ( v6 == -1 )
            break;
          buf[i] = v6;
        }
        write(1, buf, v9.st_size);
      }
      if ( size != 2 )
        break;
      printf("%s", "Log size(max 128byte):");
      __isoc99_scanf("%ld", &size);
      getchar();
      if ( (__int64)size > 128 )
      {
        puts("Size error.");
        exit(1);
      }
      ptr = malloc(size);
      v5 = read(0, ptr, size);
      fwrite(ptr, v5, 1uLL, fp);
      fclose(fp);
      stat(dest, &v9);
      fp = fopen(dest, "a+");
      if ( !fp )
      {
        puts("open error.");
        exit(1);
      }
      buf = (char *)malloc(SLODWORD(v9.st_size));
    }
    if ( size != 3 )
    {
      fclose(fp);
      puts("Thank you for your logging :)");
      exit(0);
    }
    puts("=====Info=====");
    printf("Your Name: %s", v19);
    printf("Your Password: %s", v20);
    printf("filename: %s", v10);
    puts("==============");
  }
}

