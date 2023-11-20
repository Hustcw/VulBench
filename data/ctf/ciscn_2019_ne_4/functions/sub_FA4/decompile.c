__int64 sub_FA4()
{
  int v0;
  int v2;
  int v3;
  __int64 v4;

  printf("index: ");
  v0 = sub_BE0(v3);
  v4 = v0;
  v2 = v0;
  if ( (unsigned __int64)v0 <= 0xF )
  {
    v4 = *((int *)&unk_202040 + 4 * v0);
    if ( v4 == 1 )
    {
      *((_DWORD *)&unk_202040 + 4 * v0) = 0;
      *((_DWORD *)&unk_202044 + 4 * v0) = 0;
      free((void *)qword_202048[2 * v0]);
      qword_202048[2 * v2] = 0LL;
    }
  }
  return v4;
}
