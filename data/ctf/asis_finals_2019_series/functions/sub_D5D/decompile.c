__int64 sub_D5D()
{
  __int64 result;

  puts("Calculation Done!");
  while ( 1 )
  {
    printf("i > ");
    result = sub_B1A();
    if ( (int)result < 0 )
      break;
    printf("x(%d) = %ld\n", (unsigned int)result, *(_QWORD *)(8LL * (int)result + qword_202068));
  }
  return result;
}
