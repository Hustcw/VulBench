int sub_400990()
{
  int i;
  int v2;

  for ( i = 0; *(&ptr + i) && i <= 19; ++i )
    ;
  if ( i > 19 )
    return puts("Not any more !!");
  printf("Name Size:");
  v2 = sub_400941();
  if ( v2 <= 15 || v2 > 96 )
    return puts("Invalid size !!");
  printf("Name:");
  *(&ptr + i) = malloc(v2);
  sub_400846((__int64)*(&ptr + i), v2);
  return puts("Done!");
}
