void sub_87B()
{
  int v0;
  int v1;
  char a1[2];
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v0 = atoi(nptr);
  printf("Operator: ");
  read_str(a1, 2u);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v1 = atoi(nptr);
  if ( a1[0] == 43 )
    printf("Result: %d\n", v0 + v1);
  if ( a1[0] == 45 )
    printf("Result: %d\n", v0 - v1);
  if ( a1[0] == 42 )
    printf("Result: %d\n", v1 * v0);
  if ( a1[0] == 47 )
    printf("Result: %d\n", v0 / v1);
  if ( __readgsdword(0x14u) != v4 )
    sub_1030();
}