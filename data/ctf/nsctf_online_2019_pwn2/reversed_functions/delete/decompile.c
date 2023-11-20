void delete()
{
  if ( ptr )
  {
    free(ptr);
    ptr = 0LL;
  }
  puts("Delete success");
}