int __fastcall sub_1766(__int64 a1)
{
  int v2;
  unsigned int v3;

  if ( qword_4010 <= 0 )
    sub_1521();
  --qword_4010;
  printf("Please input the red packet idx: ");
  v3 = sub_14F5();
  if ( v3 > 0x10 || !*(_QWORD *)(16LL * v3 + a1) )
    sub_1521();
  printf("Please input content: ");
  v2 = read(0, *(void **)(16LL * v3 + a1), *(int *)(16LL * v3 + a1 + 8));
  if ( v2 <= 0 )
    sub_1521();
  *(_BYTE *)(v2 - 1LL + *(_QWORD *)(16LL * v3 + a1)) = 0;
  return puts("Done!");
}
