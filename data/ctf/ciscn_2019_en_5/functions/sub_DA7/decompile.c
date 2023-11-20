unsigned __int64 sub_DA7()
{
  int i;
  int j;
  int v3;
  unsigned __int64 size;
  _BYTE *v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  for ( i = 0; i <= 19 && qword_202100[i]; ++i )
    ;
  if ( i <= 20 )
  {
    printf("length> ");
    v3 = sub_CD3();
    if ( v3 > 7 && v3 <= 512 )
    {
      size = (int)((v3 + 15) & 0xFFFFFFF8);
      v5 = malloc(size);
      for ( j = 0; j <= size; ++j )
        v5[j] = 0;
      printf("content> ");
      sub_B41(v5, v3);
      qword_202100[i] = v5;
      qword_202060[i] = size;
      puts("done");
    }
    else
    {
      puts("invalid length");
    }
  }
  else
  {
    puts("full");
  }
  return __readfsqword(0x28u) ^ v6;
}
