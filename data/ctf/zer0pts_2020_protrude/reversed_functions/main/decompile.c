int __cdecl main(int argc, const char **argv, const char **envp)
{
  setup(argc, argv, envp);
  printf("n = ");
  n = read_long();
  if ( n > 0 && n <= 22 )
    calc_sum();
  else
    puts("Invalid input");
  return 0;
}