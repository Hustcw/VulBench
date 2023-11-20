int __cdecl main(int argc, const char **argv, const char **envp)
{
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  byte_602240 = argc != 2;
  init_key();
  signal(14, (__sighandler_t)ALARMhandler);
  alarm(0xAu);
  puts("Welcome to Secure Signed Shell");
  while ( !(unsigned int)handle_it("Welcome to Secure Signed Shell") )
    ;
  return 0;
}
