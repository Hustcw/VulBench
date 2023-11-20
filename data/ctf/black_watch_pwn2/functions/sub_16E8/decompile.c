int __fastcall sub_16E8(__int64 a1)
{
  unsigned int v2;

  printf("Please input the red packet idx: ");
  v2 = sub_14F5();
  if ( v2 > 0x10 || !*(_QWORD *)(16LL * v2 + a1) )
    sub_1521();
  free(*(void **)(16LL * v2 + a1));
  return puts("Done!");
}
