__int64 __fastcall save(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( !(unsigned int)pop_internal(a1, &v2) || !(unsigned int)pop_internal(a1, &v3) )
    return 0LL;
  a1->val[a1->stack_rsp + v2] = v3;
  return 1LL;
}