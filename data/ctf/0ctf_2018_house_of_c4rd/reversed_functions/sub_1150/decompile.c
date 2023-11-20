unsigned __int64 __fastcall sub_1150(int a1, char *a2, unsigned __int64 a3)
{
  unsigned __int64 i;

  for ( i = 0LL; i < a3; i += write(a1, &a2[i], a3 - i) )
    ;
  return i;
}