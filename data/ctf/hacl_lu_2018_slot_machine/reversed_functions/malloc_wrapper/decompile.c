void *__fastcall malloc_wrapper(unsigned int a1)
{
  if ( a1 <= 0x400 )
    return malloc(a1);
  else
    return 0LL;
}