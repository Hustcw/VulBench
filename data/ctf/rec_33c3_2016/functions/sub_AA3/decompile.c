unsigned int sub_AA3()
{
  unsigned int result;
  int v1;
  int v2;
  int v3;
  int v4;
  char v5[2];
  char nptr[12];
  unsigned int v7;

  v7 = __readgsdword(0x14u);
  v3 = 0;
  printf("Operator: ");
  sub_6C0((int)v5, 2u);
  if ( v5[0] == 83 )
  {
    printf("Operand: ");
    sub_6C0((int)nptr, 0xCu);
    v1 = atoi(nptr);
    while ( nptr[0] != 46 )
    {
      v3 += ((int (__stdcall *)(int, int))sub_A91)(v1, v1);
      printf("Operand: ");
      sub_6C0((int)nptr, 0xCu);
      v1 = atoi(nptr);
    }
    printf("Sum: %d\n", v3);
  }
  else
  {
    printf("Operand: ");
    sub_6C0((int)nptr, 0xCu);
    v2 = atoi(nptr);
    printf("Operand: ");
    sub_6C0((int)nptr, 0xCu);
    v4 = atoi(nptr);
    if ( v5[0] == 43 )
      sub_9C4(v2, v4);
    if ( v5[0] == 45 )
      sub_9F8(v2, v4);
    if ( v5[0] == 42 )
      sub_A2A(v2, v4);
    if ( v5[0] == 47 )
      sub_A5D(v2, v4);
  }
  result = __readgsdword(0x14u) ^ v7;
  if ( result )
    sub_1030();
  return result;
}
