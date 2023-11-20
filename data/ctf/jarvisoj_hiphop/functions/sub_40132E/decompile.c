__int64 __fastcall sub_40132E(_QWORD *a1)
{
  __int64 result;

  printf("Your HP is %d\n", *a1);
  result = *a1;
  if ( (__int64)*a1 <= 0 )
  {
    printf("game over");
    exit(-1);
  }
  return result;
}
