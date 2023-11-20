int __cdecl main(int argc, const char **argv, const char **envp)
{
  int i;
  FILE *stream;

  setbuf(stdout, 0);
  setbuf(stderr, 0);
  memset(adminpassword, 0, sizeof(adminpassword));
  stream = fopen("adminpassword.txt", "r");
  if ( !stream )
  {
    printf("Can't read admin password!");
    exit(1);
  }
  readline(adminpassword, 32, stream);
  fclose(stream);
  for ( i = 0; i <= 7; ++i )
  {
    *(&posts + i) = malloc(0x184u);
    memset(*(&posts + i), 0, 0x184u);
  }
  readpostsfromfile();
  return menu();
}
