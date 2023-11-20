void __fastcall free_(Link *a1)
{
  if ( a1 )
  {
    free(a1->val);
    free(a1);
  }
}