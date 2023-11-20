__int64 __fastcall hash_str(unsigned __int8 *a1)
{
  unsigned __int8 *v1;
  unsigned int v4;

  v4 = 4919;
  while ( *a1 )
  {
    v1 = a1++;
    v4 = v4 * *v1 + 1;
  }
  return v4;
}