unsigned int sub_C1C()
{
  unsigned int v0;
  unsigned int result;
  char s[512];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  setbuf(stdin, 0);
  setbuf(stdout, 0);
  setbuf(stderr, 0);
  v0 = time(0);
  srand(v0);
  unk_300C = malloc(0x244u);
  *(_DWORD *)(unk_300C + 576) = unk_300C + 60;
  dword_3010 = fopen("banner.txt", "r");
  if ( !dword_3010 )
  {
    perror("fopen");
    exit(1);
  }
  memset(s, 0, sizeof(s));
  fread(s, 1u, 0x200u, dword_3010);
  printf("%s", s);
  result = __readgsdword(0x14u) ^ v3;
  if ( result )
    sub_FF0();
  return result;
}
