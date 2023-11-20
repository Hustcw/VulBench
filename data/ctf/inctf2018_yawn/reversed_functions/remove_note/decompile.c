int __cdecl remove_note()
{
  unsigned int idx;

  printf("Enter idx: ");
  idx = get_int();
  if ( idx > 9 || !table[idx] )
    return 0;
  free(table[idx]->desc);
  table[idx]->desc = 0LL;
  free(table[idx]);
  table[idx] = 0LL;
  return 0;
}