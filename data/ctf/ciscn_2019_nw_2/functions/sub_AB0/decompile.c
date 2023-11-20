__int64 sub_AB0()
{
  __int64 v0;
  __int64 v1;

  v0 = 1LL;
  if ( qword_202040[0] )
  {
    do
      v1 = (int)v0++;
    while ( *(_QWORD *)&byte_202038[8 * v0] );
  }
  else
  {
    v1 = 0LL;
  }
  qword_202040[v1] = (__int64)malloc(0x70uLL);
  puts("title:");
  read(0, (void *)qword_202040[v1], 8uLL);
  puts("content:");
  read(0, (void *)(qword_202040[v1] + 8), 0x68uLL);
  return __printf_chk(1LL, "%s %s", (const char *)qword_202040[v1], (const char *)(qword_202040[v1] + 8));
}
