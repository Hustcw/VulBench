__int64 __fastcall mul(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( (unsigned int)pop_internal(a1, &v2) && (unsigned int)pop_internal(a1, &v3) )
    return push_internal(a1, v3 * v2);
  else
    return 0LL;
}