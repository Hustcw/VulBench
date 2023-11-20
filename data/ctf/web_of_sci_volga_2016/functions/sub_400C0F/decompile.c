int __fastcall sub_400C0F(int a1)
{
  int i;

  if ( a1 < 0 || a1 >= dword_60208C )
    return printf("Wrong paper index %d\n\n\n", (unsigned int)a1);
  for ( i = a1; dword_60208C - 1 > i; ++i )
    qmemcpy((char *)&unk_6020A0 + 1088 * i, (const void *)(1088LL * (i + 1) + 6299808), 0x440uLL);
  --dword_60208C;
  return puts("\n");
}
