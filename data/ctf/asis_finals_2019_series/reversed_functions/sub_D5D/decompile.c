void sub_D5D()
{
  int v0;

  puts("Calculation Done!");
  while ( 1 )
  {
    printf("i > ");
    v0 = read_int();
    if ( v0 < 0 )
      break;
    printf("x(%d) = %ld\n", (unsigned int)v0, x[v0]);
  }
}