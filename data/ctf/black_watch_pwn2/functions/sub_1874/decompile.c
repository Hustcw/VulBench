int __fastcall sub_1874(__int64 a1)
{
  unsigned int v2;

  printf("Please input the red packet idx: ");
  v2 = sub_14F5();
  if ( v2 > 0x10 || !*(_QWORD *)(16LL * v2 + a1) )
    sub_1521();
  puts(*(const char **)(16LL * v2 + a1));
  return puts("Done!");
}
