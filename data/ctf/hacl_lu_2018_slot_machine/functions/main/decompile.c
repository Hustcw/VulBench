int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  unsigned __int64 num;
  char *v4;
  unsigned int v6;
  unsigned int v7;
  char *buf;
  char *v9;

  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 2, 0LL);
  buf = 0LL;
  v9 = 0LL;
  v6 = 8;
  puts("Hi!");
  puts(
    "You currently have 8 coins!. With each coin you can either malloc, free or do an 8-byte write on the heap! good luck!");
  printf("Here is system : 0x%016llx\n", &system);
  while ( v6-- )
  {
    printf("Select your action! (coins : %d)\n", v6);
    puts("[ 1 ] : malloc");
    puts("[ 2 ] : free");
    puts("[ 3 ] : write");
    puts("[ 4 ] : bye!");
    num = read_num();
    if ( num == 2 )
    {
      puts("where?");
      v4 = &v9[read_num()];
      free(v4);
      if ( buf == v4 )
        buf = 0LL;
    }
    else if ( num > 2 )
    {
      if ( num == 3 )
      {
        puts("what?");
        read(0, buf, 8uLL);
      }
      else if ( num == 4 )
      {
        bye();
      }
    }
    else if ( num == 1 )
    {
      puts("How much?");
      v7 = read_num();
      buf = (char *)malloc_wrapper(v7);
      v9 = buf;
    }
  }
  bye();
}
