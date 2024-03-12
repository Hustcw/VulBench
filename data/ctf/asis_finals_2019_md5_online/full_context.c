struct Data
{
  char e[60];
  unsigned __int8 salt[4];
  _BYTE data[512];
  unsigned __int8 *salt_ptr;
};

Data *struc;
FILE *dword_3010;


void __cdecl calc_md5(char *a1, char *a2, int with_salt)
{
  unsigned __int8 *v3;
  size_t v4;
  int i;
  int j;
  const char *s;
  char v8[92];
  char v9[16];
  unsigned int v10;

  v10 = __readgsdword(0x14u);
  if ( with_salt )
  {
    s = a1 - 4;
    for ( i = 0; i <= 3; ++i )
    {
      v3 = &struc->salt_ptr[i];
      *v3 = rand();
      if ( !struc->salt_ptr[i] )
        ++struc->salt_ptr[i];
    }
  }
  else
  {
    s = a1;
  }
  if ( MD5_Init(v8) != 1 )
  {
    perror("MD5_Init");
    exit(1);
  }
  v4 = strlen(s);
  if ( MD5_Update(v8, s, v4) != 1 )
  {
    perror("MD5_Update");
    exit(1);
  }
  if ( MD5_Final(v9, v8) != 1 )
  {
    perror("MD5_Final");
    exit(1);
  }
  for ( j = 0; j <= 15; ++j )
    sprintf(&a2[2 * j], "%02x", (unsigned __int8)v9[j]);
}

void __cdecl read_str(char *s, int a2)
{
  int i;
  ssize_t v3;
  char *v4;

  for ( i = 0; i < a2; i += v3 )
  {
    v3 = read(0, &s[i], 0x1F4u);
    if ( !v3 )
    {
      perror("read");
      exit(1);
    }
    v4 = strchr(s, 10);
    if ( v4 )
    {
      *v4 = 0;
      return;
    }
  }
}

void init_()
{
  unsigned int v0;
  char s[512];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  setbuf(stdin, 0);
  setbuf(stdout, 0);
  setbuf(stderr, 0);
  v0 = time(0);
  srand(v0);
  struc = (Data *)malloc(0x244u);
  struc->salt_ptr = struc->salt;
  dword_3010 = fopen("banner.txt", "r");
  if ( !dword_3010 )
  {
    perror("fopen");
    exit(1);
  }
  memset(s, 0, sizeof(s));
  fread(s, 1u, 0x200u, dword_3010);
  printf("%s", s);
}

void free_data()
{
  fclose(dword_3010);
  free(struc);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4;
  int i;

  init_();
  for ( i = 0; i <= 2; ++i )
  {
    printf("Text: ");
    read_str(struc->data, 512);
    if ( !struc->data[0] )
      break;
    printf("With salt? [y/N] ");
    v4 = getchar();
    getchar();
    if ( v4 == 'Y' || v4 == 'y' )
    {
      calc_md5(struc->data, struc->e, 1);
      printf("MD5 (salted): %s\n", struc);
      printf(
        "Salt: \\x%02x\\x%02x\\x%02x\\x%02x\n",
        *struc->salt_ptr,
        struc->salt_ptr[1],
        struc->salt_ptr[2],
        struc->salt_ptr[3]);
    }
    else
    {
      calc_md5(struc->data, struc->e, 0);
      printf("MD5: %s\n", struc);
    }
  }
  free_data();
  return 0;
}