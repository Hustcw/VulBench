__int64 sub_1138()
{
  int v1;
  unsigned int v2;
  unsigned int v3;

  printf("index: ");
  v2 = sub_BE0(v1);
  v3 = v2;
  if ( v2 <= 0xF )
  {
    v2 = *((_DWORD *)&unk_202040 + 4 * (int)v2);
    if ( v2 == 1 )
    {
      printf("content: ");
      return (unsigned int)sub_10A4(qword_202048[2 * (int)v3], *((_DWORD *)&unk_202044 + 4 * (int)v3));
    }
  }
  return v2;
}
