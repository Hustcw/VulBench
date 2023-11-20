unsigned __int64 calc_sum()
{
  void *v0;
  __int64 *v1;
  __int64 i;
  __int64 v4;
  __int64 *v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  v0 = alloca(16 * ((4 * n + 30) / 0x10uLL));
  v5 = &i;
  for ( i = 0LL; i >= 0 && i < n; ++i )
  {
    printf("num[%ld] = ", i + 1);
    v1 = &v5[i];
    *v1 = read_long();
  }
  v4 = 0LL;
  for ( i = 0LL; i < n; ++i )
    v4 += v5[i];
  printf("SUM = %ld\n", v4);
  return __readfsqword(0x28u) ^ v6;
}
