Link *__fastcall create_link(int a1)
{
  Link *ptr;
  void *s;

  ptr = (Link *)malloc(0x10uLL);
  if ( !ptr )
    return 0LL;
  s = malloc(8LL * a1);
  if ( s )
  {
    memset(s, 0, 8LL * a1);
    ptr->val = (__int64 *)s;
    ptr->stack_top = a1;
    ptr->stack_rsp = -1;
    return ptr;
  }
  else
  {
    free(ptr);
    return 0LL;
  }
}