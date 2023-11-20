char *__fastcall sub_AD6(char *a1, unsigned __int16 a2)
{
  char *result;

  result = &a1[read(0, a1, a2)];
  *result = 0;
  return result;
}
