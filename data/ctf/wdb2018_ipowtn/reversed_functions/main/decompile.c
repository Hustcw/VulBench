int __cdecl main(int argc, const char **argv, const char **envp)
{
  struct timeval v4;

  do
  {
    gettimeofday(&v4, 0);
    srand(v4.tv_usec);
    sub_400C30();
  }
  while ( sub_40111C() == 1 );
  return 0;
}