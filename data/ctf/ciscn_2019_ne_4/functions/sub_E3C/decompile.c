__int64 __fastcall sub_E3C(int a1, unsigned int a2)
{
  __int64 result;

  if ( a1 > (int)a2 )
    return a2;
  if ( a2 - a1 == 10 )
    LODWORD(result) = a1 + 1;
  else
    LODWORD(result) = a1;
  return (unsigned int)result;
}
