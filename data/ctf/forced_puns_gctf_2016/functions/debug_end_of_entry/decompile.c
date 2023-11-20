_QWORD *__fastcall debug_end_of_entry(_QWORD *a1)
{
  _QWORD *v1;
  const void *i;

  v1 = a1;
  printf("[debug] root is %p\n", a1);
  for ( i = (const void *)v1[2]; i; i = (const void *)v1[2] )
  {
    printf("  [debug] next is %p\n", i);
    v1 = (_QWORD *)v1[2];
  }
  printf("  [debug] returning %p to caller\n", v1);
  return v1;
}
