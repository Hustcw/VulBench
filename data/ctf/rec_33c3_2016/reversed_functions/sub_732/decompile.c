void sub_732()
{
  int v0;
  int v1;
  char v2[2];
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v0 = atoi(nptr);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v1 = atoi(nptr);
  printf("Operator: ");
  read_str(v2, 2u);
  if ( v2[0] == 43 )
    printf("Result: %d\n", v0 + v1);
  if ( v2[0] == 45 )
    printf("Result: %d\n", v0 - v1);
  if ( v2[0] == 42 )
    printf("Result: %d\n", v1 * v0);
  if ( v2[0] == 47 )
    printf("Result: %d\n", v0 / v1);
}