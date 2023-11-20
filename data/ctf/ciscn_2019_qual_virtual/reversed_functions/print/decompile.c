void __fastcall print(Link *a1)
{
  int i;

  if ( a1 && a1->stack_rsp != -1 )
  {
    for ( i = 0; i < a1->stack_rsp; ++i )
      printf("%d ", a1->val[i]);
    printf("%d\n", a1->val[a1->stack_rsp]);
  }
}