unsigned int sub_732()
{
  unsigned int result;
  int v1;
  int v2;
  char v3[2];
  char nptr[12];
  unsigned int v5;

  v5 = __readgsdword(0x14u);
  printf("Operand: ");
  sub_6C0((int)nptr, 0xCu);
  v1 = atoi(nptr);
  printf("Operand: ");
  sub_6C0((int)nptr, 0xCu);
  v2 = atoi(nptr);
  printf("Operator: ");
  sub_6C0((int)v3, 2u);
  if ( v3[0] == 43 )
    printf("Result: %d\n", v1 + v2);
  if ( v3[0] == 45 )
    printf("Result: %d\n", v1 - v2);
  if ( v3[0] == 42 )
    printf("Result: %d\n", v2 * v1);
  if ( v3[0] == 47 )
    printf("Result: %d\n", v1 / v2);
  result = __readgsdword(0x14u) ^ v5;
  if ( result )
    sub_1030();
  return result;
}
