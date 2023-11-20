_BOOL8 __fastcall move_to_stack(Link *a1, Link *stack)
{
  __int64 v3;

  return (unsigned int)pop_internal(a1, &v3) && (unsigned int)push_internal(stack, v3);
}