void read_x0x1()
{
  __int64 *v0;
  __int64 *v1;

  printf("x0 = ");
  v0 = x;
  *v0 = read_int();
  printf("x1 = ");
  v1 = x + 1;
  *v1 = read_int();
}