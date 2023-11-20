unsigned __int64 sub_AFE()
{
  char v1[72]; // [rsp+0h] [rbp-58h] BYREF
  unsigned __int64 v2; // [rsp+48h] [rbp-10h]

  v2 = __readfsqword(0x28u);
  strcpy(v1, "(F)ormat String Bug\n(A)rbitrary Write\n(S)tack Overflow\n(E)xit\n");
  puts(v1);
  _printf_chk(1LL, (__int64)"Your choice: ");
  return __readfsqword(0x28u) ^ v2;
}