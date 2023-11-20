void calc_sum()
{
  void *v0; // rsp
  __int64 *v1; // rbx
  __int64 i; // [rsp+0h] [rbp-30h] BYREF
  __int64 v3; // [rsp+8h] [rbp-28h]
  __int64 *v4; // [rsp+10h] [rbp-20h]
  unsigned __int64 v5; // [rsp+18h] [rbp-18h]

  v5 = __readfsqword(0x28u);
  v0 = alloca(16 * ((4 * n + 30) / 0x10uLL));
  v4 = &i;
  for ( i = 0LL; i >= 0 && i < n; ++i )
  {
    printf("num[%ld] = ", i + 1);
    v1 = &v4[i];
    *v1 = read_long();
  }
  v3 = 0LL;
  for ( i = 0LL; i < n; ++i )
    v3 += v4[i];
  printf("SUM = %ld\n", v3);
}