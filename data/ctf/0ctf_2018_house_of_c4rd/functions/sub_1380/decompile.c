char *__fastcall sub_1380(__int64 a1, int a2)
{
  char *v3;
  int v4;
  char v5[24];
  char v6[96];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  v3 = (char *)malloc(0x21uLL);
  MD5_Init(v6);
  MD5_Update(v6, a1, a2);
  v4 = 0;
  MD5_Final(v5, v6);
  while ( v4 < 16 )
  {
    snprintf(&v3[2 * v4], 0x20uLL, "%02x", (unsigned __int8)v5[v4]);
    ++v4;
  }
  return v3;
}
