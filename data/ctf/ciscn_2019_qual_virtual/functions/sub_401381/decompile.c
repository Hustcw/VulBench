void __fastcall sub_401381(void **a1)
{
  if ( a1 )
  {
    free(*a1);
    free(a1);
  }
}
