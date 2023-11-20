__int64 __fastcall pop_internal(Link *a1, _QWORD *a2)
{
  if ( !a1 )
    return 0LL;
  if ( a1->stack_rsp == -1 )
    return 0LL;
  *a2 = a1->val[a1->stack_rsp--];
  return 1LL;
}