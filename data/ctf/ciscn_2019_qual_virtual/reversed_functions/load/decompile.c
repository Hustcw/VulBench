__int64 __fastcall load(Link *a1)
{
  __int64 v2;

  if ( (unsigned int)pop_internal(a1, &v2) )
    return push_internal(a1, a1->val[a1->stack_rsp + v2]);
  else
    return 0LL;
}