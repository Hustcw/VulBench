void read_nx()
{
  printf("n = ");
  n = read_int();
  x = (__int64 *)malloc(8LL * n);
  if ( !x )
    sub_A97("Could not allocate memory");
}