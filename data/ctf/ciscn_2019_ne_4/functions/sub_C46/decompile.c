__int64 sub_C46()
{
  __int64 result;
  int i;
  int v2;
  int v3;
  void *v4;

  result = 0LL;
  for ( i = 0; i <= 15; ++i )
  {
    result = *((unsigned int *)&unk_202040 + 4 * i);
    if ( !(_DWORD)result )
    {
      printf("size: ");
      v3 = sub_BE0(v2);
      if ( v3 > 0 )
      {
        if ( v3 > 4096 )
          v3 = 4096;
        v4 = calloc(v3, 1uLL);
        if ( !v4 )
          exit(-1);
        *((_DWORD *)&unk_202040 + 4 * i) = 1;
        *((_DWORD *)&unk_202044 + 4 * i) = v3;
        qword_202048[2 * i] = v4;
        printf("The lowbits of heap leak check : %x\n", qword_202048[2 * i] & 0xFFFLL);
        printf("the index of ticket is %d \n", (unsigned int)i);
      }
      return (unsigned int)i;
    }
  }
  return result;
}
