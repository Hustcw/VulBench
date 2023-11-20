Entry *__fastcall debug_end_of_entry(Entry *a1)
{
  Entry *v1;
  Entry *i;

  v1 = a1;
  printf("[debug] root is %p\n", a1);
  for ( i = v1->next; i; i = v1->next )
  {
    printf("  [debug] next is %p\n", i);
    v1 = v1->next;
  }
  printf("  [debug] returning %p to caller\n", v1);
  return v1;
}