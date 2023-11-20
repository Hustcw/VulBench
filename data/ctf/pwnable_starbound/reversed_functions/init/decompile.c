void init()
{
  int v0;
  char *v1;
  int v2;
  int seed[4];

  setvbuf(stdin, 0, 2, 0);
  setvbuf(stdout, 0, 2, 0);
  setvbuf(stderr, 0, 2, 0);
  signal(14, (__sighandler_t)do_afk);
  puts("[Info] Landing ...");
  usleep(0x7A120u);
  v0 = open("/dev/urandom", 0);
  read(v0, seed, 4u);
  close(v0);
  srand(seed[0]);
  me = seed[0];
  init_map();
  pos = rand() % dword_8057F84;
  dword_8057F8C = 0;
  hp = 100;
  dword_8057F94 = 0;
  v1 = getenv("REMOTE_HOST");
  if ( !v1 )
    v1 = "127.0.0.1";
  cp = (char *)malloc(strlen(v1) + 1);
  fd = -1;
  dword_80580CC = 0;
  strcpy(cp, v1);
  v2 = rand();
  __strcpy_chk(byte_80580D0, name_list[v2 % 2826], 128);
  cmd_view();
  cmd_go_back();
}