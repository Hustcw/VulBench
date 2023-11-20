__int64 sub_E98()
{
  int v1;
  unsigned int v2;
  unsigned int v3;
  int v4;

  printf("index: ");
  v2 = sub_BE0(v1);
  v3 = v2;
  if ( v2 <= 0xF )
  {
    v2 = *((_DWORD *)&unk_202040 + 4 * (int)v2);
    if ( v2 == 1 )
    {
      printf("size: ");
      v2 = sub_BE0(1);
      v4 = sub_E3C(*((_DWORD *)&unk_202044 + 4 * (int)v3), v2);
      if ( (int)v2 > 0 )
      {
        printf("content: ");
        return (unsigned int)sub_DA8(qword_202048[2 * (int)v3], v4);
      }
    }
  }
  return v2;
}
