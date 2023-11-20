void sub_AA3()
{
  int v0;
  int v1;
  int v2;
  int v3;
  char a1[2];
  char nptr[12];
  unsigned int v6;

  v6 = __readgsdword(0x14u);
  v2 = 0;
  printf("Operator: ");
  read_str(a1, 2u);
  if ( a1[0] == 83 )
  {
    printf("Operand: ");
    read_str(nptr, 0xCu);
    v0 = atoi(nptr);
    while ( nptr[0] != 46 )
    {
      v2 += ((int (__stdcall *)(int, int))sub_A91)(v0, v0);
      printf("Operand: ");
      read_str(nptr, 0xCu);
      v0 = atoi(nptr);
    }
    printf("Sum: %d\n", v2);
  }
  else
  {
    printf("Operand: ");
    read_str(nptr, 0xCu);
    v1 = atoi(nptr);
    printf("Operand: ");
    read_str(nptr, 0xCu);
    v3 = atoi(nptr);
    if ( a1[0] == 43 )
      sub_9C4(v1, v3);
    if ( a1[0] == 45 )
      sub_9F8(v1, v3);
    if ( a1[0] == 42 )
      sub_A2A(v1, v3);
    if ( a1[0] == 47 )
      sub_A5D(v1, v3);
  }
}