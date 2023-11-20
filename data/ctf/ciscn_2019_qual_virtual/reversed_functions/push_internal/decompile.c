__int64 __fastcall push_internal(Link *stack, __int64 val)
{
  int v3;

  if ( !stack )
    return 0LL;
  v3 = stack->stack_rsp + 1;
  if ( v3 == stack->stack_top )
    return 0LL;
  stack->val[v3] = val;
  stack->stack_rsp = v3;
  return 1LL;
}