char *__fastcall sub_ACC(char *a1, int a2)
{
  char *result;
  int v3;

  v3 = read(0, a1, a2);
  if ( v3 <= 0 )
    sub_A97("Broken pipe");
  result = &a1[v3];
  *result = 0;
  return result;
}
