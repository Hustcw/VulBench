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